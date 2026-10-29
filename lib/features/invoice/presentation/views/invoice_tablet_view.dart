import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/features/invoice/data/invoice_controller.dart';
import 'package:venue_flow_app/features/invoice/presentation/dialogs/add_invoice_dialog.dart';
import 'package:venue_flow_app/features/invoice/presentation/invoice_data_table.dart';
import '../../../../core/domain/paged_response.dart';
import '../../../../core/theme/theme_x.dart';
import '../../../../core/widgets/responsive.dart';
import '../../../../core/widgets/side_nav.dart';
import '../../../../core/widgets/top_bar.dart';
import '../../domain/list_invoice_response.dart';

class InvoiceTabletView extends ConsumerStatefulWidget {
  const InvoiceTabletView({super.key});

  @override
  ConsumerState<InvoiceTabletView> createState() => _InvoiceTabletViewState();
}

class _InvoiceTabletViewState extends ConsumerState<InvoiceTabletView> {
  bool isLoading = true;
  PagedResponse<ListInvoiceResponse> invoices = PagedResponse(
    items: [],
    totalCount: 0,
    page: 1,
    pageSize: 1,
    totalPages: 1,
  );

  int pageNumber = 1;

  List<DataColumn> columns = [
    DataColumn(label: Text('Name')),
    DataColumn(label: Text('Email')),
    DataColumn(label: Text('Status')),
    DataColumn(label: Text('')),
  ];

  @override
  void initState() {
    super.initState();
    _fetchInvoices();
  }

  Future<void> _fetchInvoices() async {
    final repository = ref.watch(invoiceControllerProvider.notifier);
    invoices = await repository.getInvoicesForOrganization(
      page: pageNumber,
      pageSize: 10,
    );

    setState(() {
      isLoading = false; // Turn off loading when data arrives
    });
  }

  Future<void> _refresh() async {
    print('Triggered refresh');
    ref.invalidate(invoiceControllerProvider);
    ref.invalidate(invoiceDetailsProvider);
    await _fetchInvoices();
  }

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
              child: SideNav(activePath: '/invoices'),
            ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              TopBar(wide: wide),
              Padding(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(50),
                      child: CircleAvatar(
                        child: IconButton(
                          onPressed: () async {
                            await AddInvoiceDialog.show(context);
                            _refresh();
                          },
                          icon: Icon(Mdi.accountPlusOutline),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(50),
                      child: CircleAvatar(
                        backgroundColor: cs.tertiary,
                        child: IconButton(
                          onPressed: () {
                            _refresh();
                          },
                          tooltip: 'Refresh',
                          icon: Icon(Mdi.refresh),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.all(16),
                child: InvoiceDataTable(
                  columns: columns,
                  invoices: invoices,
                  constraints: constraints,
                  isLoading: isLoading,
                  requiresRefresh: (value) {
                    _refresh();
                  },
                  onPageChanged: (page) {
                    pageNumber = page;
                    _fetchInvoices();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
