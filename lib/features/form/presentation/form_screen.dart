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
                  Expanded(
                    child: Column(
                      children: [
                        TopBar(wide: wide),
                        Row(
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
                                    ? 'Hide Fields Floating Bar'
                                    : 'Show Fields Floating Bar',
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
                                    ? 'Hide Settings Floating Bar'
                                    : 'Show Settings Floating Bar',
                              ),
                            ),
                          ],
                        ),
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
  // Widget _buildFieldsFloatingBar(ColorScheme cs, BoxConstraints constraints) {
  //   final showFields = _showFloatingFieldsBar ?? false;
  //
  //   return Positioned(
  //     top: _floatingFieldsTop,
  //     left: _floatingFieldsLeft,
  //     child: GestureDetector(
  //       onPanUpdate: (details) {
  //         setState(() {
  //           _floatingFieldsTop = (_floatingFieldsTop + details.delta.dy).clamp(
  //             0.0,
  //             constraints.maxHeight - 55.0,
  //           );
  //           _floatingFieldsLeft = (_floatingFieldsLeft + details.delta.dx)
  //               .clamp(0.0, constraints.maxWidth - 165.0);
  //         });
  //       },
  //       child: AnimatedScale(
  //         scale: showFields ? 1.0 : 0.0,
  //         duration: const Duration(milliseconds: 250),
  //         curve: Curves.easeOutBack,
  //         child: ConstrainedBox(
  //           constraints: BoxConstraints(
  //             maxWidth: MediaQuery.of(context).size.width * 0.3,
  //             maxHeight: MediaQuery.of(context).size.height * 0.8,
  //             minHeight: MediaQuery.of(context).size.height * 0.8,
  //           ),
  //           child: Card(
  //             elevation: 8,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(30),
  //             ),
  //             color: cs.outlineVariant,
  //             child: Padding(
  //               padding: const EdgeInsets.symmetric(
  //                 horizontal: 16,
  //                 vertical: 10,
  //               ),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   // Row(
  //                   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   //   children: [
  //                   //     // Icon(
  //                   //     //   Icons.drag_indicator,
  //                   //     //   size: 18,
  //                   //     //   color: cs.onPrimary,
  //                   //     // ),
  //                   //
  //                   //     // 1. Shift the Drag Indicator slightly to the LEFT (-10 pixels)
  //                   //     Transform.translate(
  //                   //       offset: const Offset(-30, -20),
  //                   //       child: CircleAvatar(
  //                   //         child: Icon(
  //                   //           Icons.drag_indicator,
  //                   //           size: 20,
  //                   //           color: cs.onPrimary,
  //                   //         ),
  //                   //       ),
  //                   //     ),
  //                   //
  //                   //     Text(
  //                   //       'Form Fields',
  //                   //       style: TextStyle(
  //                   //         color: cs.onPrimary,
  //                   //         fontWeight: FontWeight.bold,
  //                   //         fontSize: 16,
  //                   //       ),
  //                   //     ),
  //                   //     // IconButton(
  //                   //     //   icon: Icon(Icons.close, size: 30, color: cs.error),
  //                   //     //   onPressed: () =>
  //                   //     //       setState(() => _showFloatingFieldsBar = false),
  //                   //     //   constraints: const BoxConstraints(),
  //                   //     //   padding: EdgeInsets.zero,
  //                   //     // ),
  //                   //
  //                   //     // 2. Shift the Close Button slightly to the RIGHT (+10 pixels)
  //                   //     GestureDetector(
  //                   //       onTap: () =>
  //                   //           setState(() => _showFloatingFieldsBar = false),
  //                   //       child: Transform.translate(
  //                   //         offset: const Offset(30, -20),
  //                   //         child: CircleAvatar(
  //                   //           backgroundColor: cs.error,
  //                   //           child: IconButton(
  //                   //             icon: Icon(
  //                   //               Icons.close,
  //                   //               size: 20,
  //                   //               color: cs.onError,
  //                   //             ),
  //                   //             onPressed: () => setState(
  //                   //               () => _showFloatingFieldsBar = false,
  //                   //             ),
  //                   //             constraints: const BoxConstraints(),
  //                   //             padding: EdgeInsets.zero,
  //                   //           ),
  //                   //         ),
  //                   //       ),
  //                   //     ),
  //                   //   ],
  //                   // ),
  //
  //                   // Stack(
  //                   //   clipBehavior: Clip.none,
  //                   //   // CRITICAL: Allows the button to pop outside the layout bounds
  //                   //   children: [
  //                   //     // --- Your Main Title Header Card Content goes here ---
  //                   //     Padding(
  //                   //       padding: const EdgeInsets.all(16.0),
  //                   //       child: Column(
  //                   //         crossAxisAlignment: CrossAxisAlignment.start,
  //                   //         children: [
  //                   //           Text(
  //                   //             'Form Fields',
  //                   //             style: TextStyle(
  //                   //               color: cs.onPrimary,
  //                   //               fontWeight: FontWeight.bold,
  //                   //             ),
  //                   //           ),
  //                   //           // ... rest of your layout content
  //                   //         ],
  //                   //       ),
  //                   //     ),
  //                   //
  //                   //     // --- The Correct Positioned Overlap Button ---
  //                   //     Positioned(
  //                   //       // Replacing Offset(30, -20) with actual layout coordinates relative to the corner.
  //                   //       // Adjust these numbers until it sits right where you want it.
  //                   //       top: -20,
  //                   //       right: -30,
  //                   //       child: CircleAvatar(
  //                   //         backgroundColor: cs.error,
  //                   //         radius: 16,
  //                   //         // Clean sizing for a small badge style button
  //                   //         child: IconButton(
  //                   //           icon: Icon(
  //                   //             Icons.close,
  //                   //             size: 16,
  //                   //             color: cs.onError,
  //                   //           ),
  //                   //           // Use ONE clear trigger path instead of nesting detectors
  //                   //           onPressed: () {
  //                   //             setState(() {
  //                   //               _showFloatingFieldsBar = false;
  //                   //             });
  //                   //           },
  //                   //           constraints: const BoxConstraints(),
  //                   //           padding: EdgeInsets.zero,
  //                   //         ),
  //                   //       ),
  //                   //     ),
  //                   //   ],
  //                   // ),
  //
  //                   Container(
  //                     padding: const EdgeInsets.only(top: 20, right: 30),
  //                     color: Colors.transparent, // Keeps it invisible but clickable
  //                     child: Stack(
  //                       clipBehavior: Clip.none,
  //                       children: [
  //
  //                         // Your Main Card/Container sits here safely
  //                         Container(
  //                           decoration: BoxDecoration(
  //                             color: cs.primary,
  //                             borderRadius: BorderRadius.circular(12),
  //                           ),
  //                           padding: const EdgeInsets.all(16),
  //                           child: Column(
  //                             mainAxisSize: MainAxisSize.min,
  //                             children: [
  //                               Text('Form Fields', style: TextStyle(color: cs.onPrimary)),
  //                             ],
  //                           ),
  //                         ),
  //
  //                         // The Button sits at 0, 0 relative to the outer padding area
  //                         Positioned(
  //                           top: -45, // Adjusted so it sits perfectly on the corner rim
  //                           right: -12,
  //                           child: CircleAvatar(
  //                             backgroundColor: cs.error,
  //                             radius: 16,
  //                             child: IconButton(
  //                               icon: Icon(Icons.close, size: 16, color: cs.onError),
  //                               onPressed: () {
  //                                 setState(() {
  //                                   _showFloatingFieldsBar = false;
  //                                 });
  //                               },
  //                               constraints: const BoxConstraints(),
  //                               padding: EdgeInsets.zero,
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Divider(color: cs.onPrimary.withOpacity(0.5), thickness: 1),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildFieldsFloatingBar(ColorScheme cs, BoxConstraints constraints) {
    final showFields = _showFloatingFieldsBar ?? false;
    if (!showFields) return const SizedBox.shrink();

    // The button needs ~20px of extra room to stick out without hit-test clipping
    const double buttonOverhang = 20.0;

    final screenSize = MediaQuery.sizeOf(context);

    final floatingFieldsWidth = screenSize.width * 0.3;
    final floatingFieldsHeight = screenSize.width * 0.6;

    return Positioned(
      top: _floatingFieldsTop,
      left: _floatingFieldsLeft,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            // Adjust constraints to account for the new layout breathing space wrapper
            _floatingFieldsTop = (_floatingFieldsTop + details.delta.dy).clamp(
              0.0,
              constraints.maxHeight - floatingFieldsHeight,
            );
            _floatingFieldsLeft = (_floatingFieldsLeft + details.delta.dx)
                .clamp(0.0, constraints.maxWidth - floatingFieldsWidth);
          });
        },
        child: AnimatedScale(
          scale: showFields ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutBack,
          // FIXED wrapper container ensures the close button is inside the parent box boundaries
          child: Container(
            width: floatingFieldsWidth,
            height: floatingFieldsHeight,
            padding: const EdgeInsets.only(
              top: buttonOverhang,
              right: buttonOverhang,
            ),
            color: Colors.transparent,
            // Invisible layout padding zone
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Reserve space for the overlapping button.
                Padding(
                  padding: const EdgeInsets.only(top: 12, right: 12),
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: cs.primaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
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
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 0,
                  right: 0,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Material(
                      color: cs.error,
                      shape: const CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {
                          setState(() {
                            _showFloatingFieldsBar = false;
                          });
                        },
                        child: Center(
                          child: Icon(Icons.close, color: cs.onError, size: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Floating Bar 2: Form Settings
  Widget _buildSettingsFloatingBar(ColorScheme cs, BoxConstraints constraints) {
    final showSettings = _showFloatingSettingsBar ?? false;
    // The button needs ~20px of extra room to stick out without hit-test clipping
    const double buttonOverhang = 20.0;

    final screenSize = MediaQuery.sizeOf(context);

    final floatingSettingsWidth = screenSize.width * 0.3;
    final floatingSettingsHeight = screenSize.width * 0.6;

    return Positioned(
      top: _floatingSettingsTop,
      right: _floatingSettingsLeft,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _floatingSettingsTop = (_floatingSettingsTop + details.delta.dy)
                .clamp(0.0, constraints.maxHeight - floatingSettingsHeight);
            _floatingSettingsLeft = (_floatingSettingsLeft + details.delta.dx)
                .clamp(0.0, constraints.maxWidth - floatingSettingsWidth);
          });
        },
        child: AnimatedScale(
          scale: showSettings ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutBack,
          child: Container(
            width: floatingSettingsWidth,
            height: floatingSettingsHeight,
            padding: const EdgeInsets.only(
              top: buttonOverhang,
              right: buttonOverhang,
            ),
            color: Colors.transparent,
            // Invisible layout padding zone
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Reserve space for the overlapping button.
                Padding(
                  padding: const EdgeInsets.only(top: 12, right: 12),
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: cs.primaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.drag_indicator,
                                size: 18,
                                color: cs.onPrimaryContainer,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Field Settings',
                                style: TextStyle(
                                  color: cs.onPrimaryContainer,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 12),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 0,
                  right: 0,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Material(
                      color: cs.error,
                      shape: const CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {
                          setState(() {
                            _showFloatingSettingsBar = false;
                          });
                        },
                        child: Center(
                          child: Icon(Icons.close, color: cs.onError, size: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
