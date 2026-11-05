import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/theme_x.dart';
import '../../../core/widgets/responsive.dart';
import 'package:venue_flow_app/features/form/presentation/views/table_view/table_desktop_view.dart'
    deferred as table_desktop_view;
import 'package:venue_flow_app/features/form/presentation/views/table_view/table_mobile_view.dart'
    deferred as table_mobile_view;
import 'package:venue_flow_app/features/form/presentation/views/table_view/table_tablet_view.dart'
    deferred as table_tablet_view;

class FormTableScreen extends ConsumerStatefulWidget {
  const FormTableScreen({super.key});

  @override
  ConsumerState<FormTableScreen> createState() => _FormTableScreenState();
}

class _FormTableScreenState extends ConsumerState<FormTableScreen> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;
    const _wideBreakpoint = 1000.0;
    final wide = MediaQuery.of(context).size.width >= _wideBreakpoint;

    return Responsive(
      loadMobile: table_mobile_view.loadLibrary,
      loadDesktop: table_desktop_view.loadLibrary,
      loadTablet: table_tablet_view.loadLibrary,
      mobile: (_) => table_mobile_view.TableMobileView(),
      tablet: (_) => table_tablet_view.TableTabletView(),
      desktop: (_) => table_desktop_view.TableDesktopView(),
    );
  }
}
