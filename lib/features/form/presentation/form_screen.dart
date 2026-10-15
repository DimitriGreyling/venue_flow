import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/core/widgets/responsive.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/theme/theme_x.dart';
import '../../../core/widgets/side_nav.dart';
import '../../../core/widgets/top_bar.dart';
import '../../auth/presentation/auth_session.dart';

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
      final screenSize = MediaQuery.sizeOf(context);

      // 1. Fields bar starts at Top Left
      _floatingFieldsTop = statusBarHeight + 65.0; // Pushed down past status bar
      _floatingFieldsLeft = 20.0;                  // Pinned to left edge

      // 2. Settings bar starts at Top Right
      _floatingSettingsTop = statusBarHeight + 65.0;
      // Subtracting ~180px gives the card enough breathing room so it doesn't spawn off-screen
      _floatingSettingsLeft = screenSize.width - 190.0;

      _isPositionsInitialized = true;
    }

    return Responsive(
      mobile: mobileView(cs: cs, sem: sem, wideBreakpoint: _wideBreakpoint),
      desktop: desktopView(cs: cs, sem: sem, wideBreakpoint: _wideBreakpoint),
    );
  }

  Widget mobileView({
    required ColorScheme cs,
    required AppSemanticColors sem,
    required double wideBreakpoint,
  }) {
    final wide = MediaQuery.sizeOf(context).width >= wideBreakpoint;

    return Scaffold(
      drawer: wide
          ? null
          : Drawer(
              width: 240,
              backgroundColor: cs.surface,
              child: SideNav(activePath: '/forms'),
            ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // SAFE NULL-CHECK: Safeguard boolean states before reading them inside the Stack layout template
          final showFields = _showFloatingFieldsBar ?? false;
          final showSettings = _showFloatingSettingsBar ?? false;

          return Stack(
            children: [
              // Base Layer: Page layout content
              Row(
                children: [
                  if (wide) const SideNav(activePath: '/dashboard'),
                  Expanded(
                    child: Column(
                      children: [
                        TopBar(wide: wide),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.all(wide ? 24 : 16),
                            child: Center(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 1440,
                                  maxHeight:
                                      MediaQuery.sizeOf(context).height * 0.89,
                                ),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        color: cs.surfaceContainerHighest,
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text('Block 2'),
                                            const SizedBox(height: 16),
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                setState(() {
                                                  _showFloatingFieldsBar =
                                                      !(_showFloatingFieldsBar ??
                                                          false);
                                                });
                                              },
                                              icon: Icon(
                                                showFields
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                              ),
                                              label: Text(
                                                showFields
                                                    ? 'Hide Fields Floating Bar'
                                                    : 'Show Fields Floating Bar',
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                setState(() {
                                                  _showFloatingSettingsBar =
                                                      !(_showFloatingSettingsBar ??
                                                          false);
                                                });
                                              },
                                              icon: Icon(
                                                showSettings
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                              ),
                                              label: Text(
                                                showSettings
                                                    ? 'Hide Settings Floating Bar'
                                                    : 'Show Settings Floating Bar',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Top Floating Overlay Layer with active boundaries checking
              if (showFields) _buildFieldsFloatingBar(cs, constraints),
              if (showSettings) _buildSettingsFloatingBar(cs, constraints),
            ],
          );
        },
      ),
    );
  }

  Widget desktopView({
    required ColorScheme cs,
    required AppSemanticColors sem,
    required double wideBreakpoint,
  }) {
    final wide = MediaQuery.sizeOf(context).width >= wideBreakpoint;

    return Scaffold(
      drawer: wide
          ? null
          : Drawer(
              width: 240,
              backgroundColor: cs.surface,
              child: SideNav(activePath: '/forms'),
            ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final showFields = _showFloatingFieldsBar ?? false;
          final showSettings = _showFloatingSettingsBar ?? false;

          return Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TopBar(wide: wide),
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      _showFloatingFieldsBar =
                                          !(_showFloatingFieldsBar ?? false);
                                    });
                                  },
                                  icon: Icon(
                                    showFields
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  label: Text(
                                    showFields
                                        ? 'Toggle Fields Bar'
                                        : 'Show Fields Bar',
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      _showFloatingSettingsBar =
                                          !(_showFloatingSettingsBar ?? false);
                                    });
                                  },
                                  icon: Icon(
                                    showSettings
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  label: Text(
                                    showSettings
                                        ? 'Toggle Settings Bar'
                                        : 'Show Settings Bar',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (showFields) _buildFieldsFloatingBar(cs, constraints),
              if (showSettings) _buildSettingsFloatingBar(cs, constraints),
            ],
          );
        },
      ),
    );
  }

  // Floating Bar 1: Fields Configuration
  Widget _buildFieldsFloatingBar(ColorScheme cs, BoxConstraints constraints) {
    final showFields = _showFloatingFieldsBar ?? false;

    return Positioned(
      top: _floatingFieldsTop,
      left: _floatingFieldsLeft,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _floatingFieldsTop = (_floatingFieldsTop + details.delta.dy).clamp(
              0.0,
              constraints.maxHeight - 55.0,
            );
            _floatingFieldsLeft = (_floatingFieldsLeft + details.delta.dx)
                .clamp(0.0, constraints.maxWidth - 165.0);
          });
        },
        child: AnimatedScale(
          scale: showFields ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutBack,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            color: cs.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.drag_indicator,
                    size: 18,
                    color: cs.onPrimaryContainer,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Form Fields',
                    style: TextStyle(
                      color: cs.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    onPressed: () =>
                        setState(() => _showFloatingFieldsBar = false),
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Floating Bar 2: Form Settings
  Widget _buildSettingsFloatingBar(ColorScheme cs, BoxConstraints constraints) {
    final showSettings = _showFloatingSettingsBar ?? false;
    return Positioned(
      top: _floatingSettingsTop,
      left: _floatingSettingsLeft,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _floatingSettingsTop = (_floatingSettingsTop + details.delta.dy)
                .clamp(0.0, constraints.maxHeight - 55.0);
            _floatingSettingsLeft = (_floatingSettingsLeft + details.delta.dx)
                .clamp(0.0, constraints.maxWidth - 175.0);
          });
        },
        child: AnimatedScale(
          scale: showSettings ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutBack,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.3,
              maxHeight: MediaQuery.of(context).size.height * 0.8,
              minHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: cs.secondaryContainer,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.drag_indicator,
                      size: 18,
                      color: cs.onSecondaryContainer,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Field Settings',
                      style: TextStyle(
                        color: cs.onSecondaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      onPressed: () =>
                          setState(() => _showFloatingSettingsBar = false),
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
