import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme_x.dart';
import '../../../../core/widgets/responsive.dart';

class DynamicFieldGenerator extends ConsumerStatefulWidget {
  const DynamicFieldGenerator({super.key});

  @override
  ConsumerState<DynamicFieldGenerator> createState() => _DynamicFieldGeneratorState();
}

class _DynamicFieldGeneratorState extends ConsumerState<DynamicFieldGenerator> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme
        .of(context)
        .colorScheme;
    final sem = context.semantic;
    const _wideBreakpoint = 1000.0;
    final wide = MediaQuery
        .of(context)
        .size
        .width >= _wideBreakpoint;

    // return const Responsive(
    //   loadMobile:, //invoice_mobile_view.loadLibrary,
    //   loadDesktop:, //venue_desktop_screen.loadLibrary,
    //   loadTablet:, //venue_tablet_screen.loadLibrary,
    //   mobile: (_) =>, //invoice_mobile_view.VenueMobileScreen(),
    //   tablet: (_) =>, //venue_tablet_screen.VenueTabletScreen(),
    //   desktop: (_) =>, //venue_desktop_screen.VenueDesktopScreen(),
    // );
    return const SizedBox.shrink();
  }
}