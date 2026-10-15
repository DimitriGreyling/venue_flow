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
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;
    const _wideBreakpoint = 1000.0;

    //Switch between mobile and desktop view for better usability
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
      body: Row(
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
                          maxHeight: MediaQuery.sizeOf(context).height * 0.89,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Left Block (Takes 30% of remaining space)
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Card(
                                  color: cs.inverseSurface.withValues(
                                    alpha: 0.1,
                                  ),
                                  child: const Text('Block 1'),
                                ),
                              ),
                            ),

                            // Middle Block (Takes 40% of remaining space - wider)
                            Expanded(
                              flex: 4,
                              child: Container(
                                color: cs.surfaceContainerHighest,
                                child: const Text('Block 2'),
                              ),
                            ),

                            // Right Block (Takes 30% of remaining space)
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Card(
                                  color: cs.inverseSurface.withValues(
                                    alpha: 0.1,
                                  ),
                                  child: const Text('Block 3'),
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
      body: Row(
        children: [
          Expanded(
            child: Column(children: [TopBar(wide: wide)]),
          ),
        ],
      ),
    );
  }
}
