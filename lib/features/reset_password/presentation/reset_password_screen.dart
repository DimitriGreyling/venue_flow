import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme_x.dart';
import '../../../../core/widgets/responsive.dart';
import './views/reset_password_mobile_view.dart'
    deferred as reset_password_mobile_view;
import './views/reset_password_desktop_view.dart'
    deferred as reset_password_desktop_view;
import './views/reset_password_tablet_view.dart'
    deferred as reset_password_tablet_view;

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.token,
  });

  final String email;
  final String token;

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;
    const _wideBreakpoint = 1000.0;
    final wide = MediaQuery.of(context).size.width >= _wideBreakpoint;

    return Responsive(
      loadMobile: reset_password_mobile_view.loadLibrary,
      loadDesktop: reset_password_desktop_view.loadLibrary,
      loadTablet: reset_password_tablet_view.loadLibrary,
      mobile: (_) => reset_password_mobile_view.ResetPasswordMobileView(),
      tablet: (_) => reset_password_tablet_view.ResetPasswordTabletView(
        email: widget.email,
        token: widget.token,
      ),
      desktop: (_) => reset_password_desktop_view.ResetPasswordDesktopView(),
    );
  }
}
