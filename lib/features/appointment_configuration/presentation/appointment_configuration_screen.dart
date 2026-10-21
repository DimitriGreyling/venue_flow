import 'package:flutter/material.dart';
import 'package:venue_flow_app/core/widgets/responsive.dart';
import 'package:venue_flow_app/features/appointment_configuration/presentation/views/appointment_config_desktop_view.dart';
import 'package:venue_flow_app/features/appointment_configuration/presentation/views/appointment_config_mobile_view.dart';

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
      mobile: AppointmentConfigMobileView(venueName: widget.venueName),
      desktop: AppointmentConfigDesktopView(),
    );
  }
}
