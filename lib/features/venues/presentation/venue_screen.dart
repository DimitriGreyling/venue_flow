import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/core/widgets/responsive.dart';
import 'package:venue_flow_app/features/venues/presentation/views/venue_desktop_screen.dart'
    deferred as venue_desktop_screen;
import 'package:venue_flow_app/features/venues/presentation/views/venue_mobile_screen.dart'
    deferred as venue_mobile_screen;
import 'package:venue_flow_app/features/venues/presentation/views/venue_tablet_screen.dart'
    deferred as venue_tablet_screen;
import '../../../core/theme/theme_x.dart';
import 'package:flutter/cupertino.dart';

class VenueScreen extends ConsumerStatefulWidget {
  const VenueScreen({super.key});

  @override
  ConsumerState<VenueScreen> createState() => _State();
}

class _State extends ConsumerState<VenueScreen> {
  Future<void>? _loadingFuture;
  bool? _loadingDesktop;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;
    const _wideBreakpoint = 1000.0;
    final wide = MediaQuery.of(context).size.width >= _wideBreakpoint;

    // Load only the library required for the current layout.
    if (_loadingFuture == null || _loadingDesktop != wide) {
      _loadingDesktop = wide;

      _loadingFuture = wide
          ? venue_desktop_screen.loadLibrary()
          : venue_mobile_screen.loadLibrary();
    }

    return FutureBuilder<void>(
      future: _loadingFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Failed to load venue screen.')),
          );
        }

        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Responsive(
          loadMobile: venue_mobile_screen.loadLibrary,
          loadDesktop: venue_desktop_screen.loadLibrary,
          loadTablet: venue_tablet_screen.loadLibrary,
          mobile: (_) => venue_mobile_screen.VenueMobileScreen(),
          tablet: (_) => venue_tablet_screen.VenueTabletScreen(),
          desktop: (_) => venue_desktop_screen.VenueDesktopScreen(),
        );
      },
    );
  }
}
