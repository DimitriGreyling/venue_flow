import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/core/widgets/responsive.dart';
import 'package:venue_flow_app/features/customers/presentation/views/customer_desktop_view.dart';
import 'package:venue_flow_app/features/customers/presentation/views/customer_mobile_view.dart';

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
      mobile: CustomerMobileView(),
      tablet: CustomerMobileView(),
      desktop: CustomerDesktopView(),
    );
  }
}
