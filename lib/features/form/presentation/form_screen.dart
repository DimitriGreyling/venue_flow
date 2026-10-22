import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/core/widgets/responsive.dart';
import 'package:venue_flow_app/features/form/presentation/views/form_mobile_view.dart'
    deferred as form_mobile_view;
import 'package:venue_flow_app/features/form/presentation/views/form_tablet_view.dart'
    deferred as form_tablet_view;
import 'package:venue_flow_app/features/form/presentation/views/form_desktop_view.dart'
    deferred as form_desktop_view;
import '../../../core/theme/theme_x.dart';

class FormScreen extends ConsumerStatefulWidget {
  const FormScreen({super.key});

  @override
  ConsumerState<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends ConsumerState<FormScreen> {
  // Tracks the X and Y screen coordinates for fields bar
  double _floatingFieldsTop = 120.0;
  double _floatingFieldsLeft = 20.0;

  // Tracks the X and Y screen coordinates for settings bar
  double _floatingSettingsTop = 120.0;
  double _floatingSettingsLeft = 20.0;

  // Track if positioning needs a safe initial layout configuration check
  bool _isPositionsInitialized = false;

  // Track the visibility state of the floating bars
  bool _showFloatingFieldsBar = false;
  bool _showFloatingSettingsBar = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;
    const _wideBreakpoint = 1000.0;
    final statusBarHeight = MediaQuery.paddingOf(context).top;

    // Initialize positions dynamically on first build based on screen dimensions
    if (!_isPositionsInitialized) {
      // 1. Fields bar starts at Top Left
      _floatingFieldsTop =
          statusBarHeight + 65.0; // Pushed down past status bar
      _floatingFieldsLeft = 20.0; // Pinned to left edge

      // 2. Settings bar starts at Top Right
      _floatingSettingsTop = statusBarHeight + 65.0;
      //Show settings bar on the right side of the screen
      _floatingSettingsLeft = 20.0;

      _isPositionsInitialized = true;
    }

    //Display mobile of desktop view based on the screen size
    return Responsive(
      loadMobile: form_mobile_view.loadLibrary,
      loadTablet: form_tablet_view.loadLibrary,
      loadDesktop: form_desktop_view.loadLibrary,
      mobile: (_) => form_mobile_view.FormMobileView(),
      tablet: (_) => form_tablet_view.FormTabletView(),
      desktop: (_) => form_desktop_view.FormDesktopView(),
    );
  }
}
