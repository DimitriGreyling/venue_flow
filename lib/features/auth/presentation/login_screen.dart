import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/core/widgets/responsive.dart';
import 'package:venue_flow_app/features/auth/presentation/views/login_desktop_view.dart'
    deferred as login_desktop_view;
import 'package:venue_flow_app/features/auth/presentation/views/login_tablet_view.dart'
    deferred as login_tablet_view;
import 'package:venue_flow_app/features/auth/presentation/views/login_mobile_view.dart'
    deferred as login_mobile_view;

/// A production-ready, fully responsive Flutter implementation of the Venue Manager login screen.
/// Features a split-screen layout:
/// - Left side: Immersive visual hero banner with background image, dark gradient overlay, and quote.
/// - Right side: Deep indigo modern authentication card with custom styled inputs, social buttons, and typography.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      loadMobile: login_mobile_view.loadLibrary,
      loadTablet: login_tablet_view.loadLibrary,
      loadDesktop: login_desktop_view.loadLibrary,
      mobile: (_) => login_mobile_view.LoginMobileView(),
      tablet: (_) => login_tablet_view.LoginTabletView(),
      desktop: (_) => login_desktop_view.LoginDesktopView(),
    );
  }
}
