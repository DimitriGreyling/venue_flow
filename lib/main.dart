import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/routing/app_router.dart';
import 'package:venue_flow_app/shared/helpers/global_popup_service.dart';
import 'package:venue_flow_app/views/popup/global_popup_overlay.dart';
import 'theme/theme.dart';
import 'theme/theme_provider.dart';
import 'views/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(lightSystemUiStyle);

  await dotenv.load(fileName: ".env");

  final container = ProviderContainer();
  GlobalPopupService.initialize(container);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: EditorialConciergeApp(),
    ),
  );
}

class EditorialConciergeApp extends ConsumerWidget {
  const EditorialConciergeApp({super.key});

  double _responsiveFontScale(double width) {
    if (width < 480) {
      return 0.84;
    }
    if (width < 768) {
      return 0.92;
    }
    if (width < 1024) {
      return 0.97;
    }
    return 1.0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final router = ref.watch(appRouterProvider);

    // Update system UI overlay style when theme changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(getSystemUiStyle(themeMode));
    });

    return MaterialApp.router(
      restorationScopeId: 'app',
      scrollBehavior: const MaterialScrollBehavior().copyWith(
          //TODO:: add ack for mobil devices

          // dragDevices: {
          //   PointerDeviceKind.mouse,
          //   PointerDeviceKind.touch,
          //   PointerDeviceKind.trackpad,
          //   PointerDeviceKind.stylus,
          //   PointerDeviceKind.unknown,
          // },
          ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'Venue Flow',
      // Theme configuration
      theme: editorialLightTheme,
      darkTheme: editorialDarkTheme,
      themeMode: ThemeMode.light, //themeMode,
      builder: (context, child) {
        if (child == null) return const SizedBox.shrink();

        final mediaQuery = MediaQuery.of(context);
        final responsiveScale =
            mediaQuery.textScaler.textScaleFactor * _responsiveFontScale(mediaQuery.size.width);

        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: TextScaler.linear(responsiveScale),
          ),
          child: GlobalPopupOverlay(child: child),
        );
      },
    );
  }
}
