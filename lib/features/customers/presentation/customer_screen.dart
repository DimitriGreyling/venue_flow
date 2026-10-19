import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/core/widgets/responsive.dart';
import 'package:venue_flow_app/core/widgets/top_bar.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/theme/theme_x.dart';
import '../../../core/widgets/side_nav.dart';

class CustomerScreen extends ConsumerStatefulWidget {
  const CustomerScreen({super.key});

  @override
  ConsumerState<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends ConsumerState<CustomerScreen> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;
    const _wideBreakpoint = 1000.0;

    return Responsive(
      mobile: viewMobile(cs: cs, sem: sem, wideBreakpoint: _wideBreakpoint),
      desktop: viewDesktop(cs: cs, sem: sem, wideBreakpoint: _wideBreakpoint),
    );
  }

  Widget viewMobile({
    required ColorScheme cs,
    required AppSemanticColors sem,
    required double wideBreakpoint,
  }) {
    final wide = MediaQuery.of(context).size.width >= wideBreakpoint;
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
          return Column(
            children: [
              TopBar(wide: wide),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    label: Text('Add Customer'),
                    icon: Icon(Mdi.accountPlusOutline),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    label: Text('Refresh'),
                    icon: Icon(Mdi.refresh),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget viewDesktop({
    required ColorScheme cs,
    required AppSemanticColors sem,
    required double wideBreakpoint,
  }) {
    final wide = MediaQuery.of(context).size.width >= wideBreakpoint;
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
          return Column(children: [TopBar(wide: wide)]);
        },
      ),
    );
  }
}
