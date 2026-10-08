import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/error/error_service.dart';
import 'core/router/app_router.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Venue Flow',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: rootMessengerKey,   // <- toasts
      routerConfig: ref.watch(routerProvider),
      theme: ThemeData(useMaterial3: true, fontFamily: 'Inter', colorSchemeSeed: Colors.indigo),
    );
  }
}