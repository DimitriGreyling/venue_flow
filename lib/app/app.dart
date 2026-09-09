import 'package:flutter/material.dart';
import 'package:venue_flow_app/app/router.dart';
import 'package:venue_flow_app/app/theme/app_theme.dart';

class VenueFlowApp extends StatelessWidget {
  const VenueFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter().router;

    return MaterialApp.router(
      title: 'Modern Venue Intelligence',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: router,
    );
  }
}
