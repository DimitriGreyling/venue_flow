import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/features/invoice/presentation/views/invoice_mobile_view.dart'
    deferred as invoice_mobile_view;
import 'package:venue_flow_app/features/invoice/presentation/views/invoice_tablet_view.dart'
    deferred as invoice_tablet_view;
import 'package:venue_flow_app/features/invoice/presentation/views/invoice_desktop_view.dart'
    deferred as invoice_desktop_view;
import '../../../../core/theme/theme_x.dart';
import '../../../../core/widgets/responsive.dart';

class InvoiceScreen extends ConsumerStatefulWidget {
  const InvoiceScreen({super.key});

  @override
  ConsumerState<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends ConsumerState<InvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;
    const _wideBreakpoint = 1000.0;
    final wide = MediaQuery.of(context).size.width >= _wideBreakpoint;

    return Responsive(
      loadMobile: invoice_mobile_view.loadLibrary,
      loadDesktop: invoice_desktop_view.loadLibrary,
      loadTablet: invoice_tablet_view.loadLibrary,
      mobile: (_) => invoice_mobile_view.InvoiceMobileView(),
      tablet: (_) => invoice_tablet_view.InvoiceTabletView(),
      desktop: (_) => invoice_desktop_view.InvoiceDesktopView(),
    );
  }
}
