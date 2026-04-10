import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:venue_flow_app/routing/app_router.dart';
import 'theme/theme.dart';
import 'theme/theme_provider.dart';
import 'views/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(lightSystemUiStyle);

  await dotenv.load(fileName: ".env");

  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  if (supabaseUrl == null) {
    throw Exception('SUPABASE_URL not found in .env');
  }

  final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];
  if (supabaseAnonKey == null) {
    throw Exception('SUPABASE_ANON_KEY not found in .env');
  }

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  runApp(
    const ProviderScope(
      child: EditorialConciergeApp(),
    ),
  );
}

class EditorialConciergeApp extends ConsumerWidget {
  const EditorialConciergeApp({super.key});

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

        return child;
      },
    );
  }
}
