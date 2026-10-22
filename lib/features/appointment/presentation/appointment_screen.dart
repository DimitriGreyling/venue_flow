import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/core/widgets/responsive.dart';
import 'package:venue_flow_app/features/appointment/presentation/views/appointment_mobile_screen.dart'
    deferred as appointment_mobile_screen;
import 'package:venue_flow_app/features/appointment/presentation/views/appointment_tablet_screen.dart'
    deferred as appointment_tablet_screen;
import 'package:venue_flow_app/features/appointment/presentation/views/appointment_desktop_screen.dart'
    deferred as appointment_desktop_screen;

class AppointmentScreen extends ConsumerStatefulWidget {
  const AppointmentScreen({super.key});

  @override
  ConsumerState<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends ConsumerState<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      loadMobile: appointment_mobile_screen.loadLibrary,
      loadDesktop: appointment_desktop_screen.loadLibrary,
      loadTablet: appointment_tablet_screen.loadLibrary,
      mobile: (_) => appointment_mobile_screen.AppointmentMobileScreen(),
      tablet: (_) => appointment_tablet_screen.AppointmentTabletScreen(),
      desktop: (_) => appointment_desktop_screen.AppointmentDesktopScreen(),
    );
  }
}
