import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme_x.dart';
import '../../../../core/widgets/side_nav.dart';

class VenueDesktopScreen extends ConsumerStatefulWidget {
  const VenueDesktopScreen({super.key});

  @override
  ConsumerState<VenueDesktopScreen> createState() => _VenueDesktopScreenState();
}

class _VenueDesktopScreenState extends ConsumerState<VenueDesktopScreen> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;
    const _wideBreakpoint = 1000.0;
    final wide = MediaQuery.of(context).size.width >= _wideBreakpoint;

    return Scaffold(
      drawer: wide
          ? null
          : Drawer(
              width: 240,
              backgroundColor: cs.surface,
              child: SideNav(activePath: '/forms'),
            ),
      body: SafeArea(
        child: Center(
          child: Text('Venue Desktop Screen'),
        ),
      ),
    );
  }
}
