import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'VenueFlow',
      theme: ThemeData(useMaterial3: true,colorSchemeSeed: Colors.indigo),
      routerConfig: ref.watch(routerProvider),
    );
  }
}
