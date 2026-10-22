import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/core/widgets/responsive.dart';
import 'package:venue_flow_app/features/customers/presentation/views/customer_desktop_view.dart'
    deferred as customer_desktop_view;
import 'package:venue_flow_app/features/customers/presentation/views/customer_mobile_view.dart'
    deferred as customer_mobile_view;
import 'package:venue_flow_app/features/customers/presentation/views/customer_tablet_view.dart'
    deferred as customer_tablet_view;

class CustomerScreen extends ConsumerStatefulWidget {
  const CustomerScreen({super.key});

  @override
  ConsumerState<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends ConsumerState<CustomerScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      loadMobile: customer_mobile_view.loadLibrary,
      loadTablet: customer_tablet_view.loadLibrary,
      loadDesktop: customer_desktop_view.loadLibrary,
      mobile: (_) => customer_mobile_view.CustomerMobileView(),
      tablet: (_) => customer_tablet_view.CustomerTabletView(),
      desktop: (_) => customer_desktop_view.CustomerDesktopView(),
    );
  }
}
