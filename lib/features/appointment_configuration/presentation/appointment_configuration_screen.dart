import 'package:flutter/material.dart';
import 'package:venue_flow_app/core/widgets/responsive.dart';
import 'package:venue_flow_app/features/appointment_configuration/presentation/views/appointment_config_desktop_view.dart'
    deferred as appointment_config_desktop;
import 'package:venue_flow_app/features/appointment_configuration/presentation/views/appointment_config_tablet_view.dart'
    deferred as appointment_config_tablet;
import 'package:venue_flow_app/features/appointment_configuration/presentation/views/appointment_config_mobile_view.dart'
    deferred as appointment_config_mobile;

class AppointmentConfigurationScreen extends StatefulWidget {
  const AppointmentConfigurationScreen({
    super.key,
    this.venueId,
    this.venueName = '',
  });

  final String? venueId;
  final String? venueName;

  @override
  State<AppointmentConfigurationScreen> createState() =>
      _AppointmentConfigurationScreenState();
}

class _AppointmentConfigurationScreenState
    extends State<AppointmentConfigurationScreen> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      loadMobile: appointment_config_mobile.loadLibrary,
      loadTablet: appointment_config_tablet.loadLibrary,
      loadDesktop: appointment_config_desktop.loadLibrary,
      mobile: (_) => appointment_config_mobile.AppointmentConfigMobileView(
        venueName: widget.venueName,
      ),
      tablet: (_) => appointment_config_tablet.AppointmentConfigTabletView(),
      desktop: (_) => appointment_config_desktop.AppointmentConfigDesktopView(),
    );
  }
}
