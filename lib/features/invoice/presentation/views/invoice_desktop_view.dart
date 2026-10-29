import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme_x.dart';
import '../../../../core/widgets/responsive.dart';

class InvoiceDesktopView extends ConsumerStatefulWidget {
  const InvoiceDesktopView({super.key});

  @override
  ConsumerState<InvoiceDesktopView> createState() => _InvoiceDesktopViewState();
}

class _InvoiceDesktopViewState extends ConsumerState<InvoiceDesktopView> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;
    const _wideBreakpoint = 1000.0;
    final wide = MediaQuery.of(context).size.width >= _wideBreakpoint;

    return Placeholder();
  }
}
