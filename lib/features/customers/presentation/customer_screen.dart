import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/core/domain/paged_response.dart';
import 'package:venue_flow_app/core/widgets/responsive.dart';
import 'package:venue_flow_app/core/widgets/top_bar.dart';
import 'package:venue_flow_app/features/customers/data/member_response.dart';
import 'package:venue_flow_app/features/customers/presentation/customer_controller.dart';
import 'package:venue_flow_app/features/customers/presentation/customer_data_table.dart';
import 'package:venue_flow_app/features/customers/presentation/dialogs/add_customer_dialog.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/theme_x.dart';
import '../../../core/widgets/side_nav.dart';

class CustomerScreen extends ConsumerStatefulWidget {
  const CustomerScreen({super.key});

  @override
  ConsumerState<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends ConsumerState<CustomerScreen> {
  bool isLoading = true;
  PagedResponse<MemberResponse> customers = PagedResponse(
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
    _fetchCustomers();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;
    const _wideBreakpoint = 1000.0;

    return Responsive(
      mobile: viewMobile(cs: cs, sem: sem, wideBreakpoint: _wideBreakpoint),
      desktop: viewDesktop(cs: cs, sem: sem, wideBreakpoint: _wideBreakpoint),
    );
  }

  Future<void> _fetchCustomers() async {
    final repository = ref.watch(customerControllerProvider.notifier);
    customers = await repository.getMembersForOrg(
      page: pageNumber,
      pageSize: 1,
    );

    setState(() {
      isLoading = false; // Turn off loading when data arrives
    });
  }

  Future<void> _refresh() async {
    print('Triggered refresh');
    ref.invalidate(customerControllerProvider);
    ref.invalidate(customerDetailsProvider);
    await _fetchCustomers();
  }

  Widget viewMobile({
    required ColorScheme cs,
    required AppSemanticColors sem,
    required double wideBreakpoint,
  }) {
    final wide = MediaQuery.of(context).size.width >= wideBreakpoint;
    return Scaffold(
      drawer: wide
          ? null
          : Drawer(
              width: 240,
              backgroundColor: cs.surface,
              child: SideNav(activePath: '/forms'),
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
                            await AddCustomerDialog.show(context);
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
                child: CustomerDataTable(
                  columns: columns,
                  customers: customers,
                  constraints: constraints,
                  isLoading: isLoading,
                  requiresRefresh: (value) {
                    _refresh();
                  },
                  onPageChanged: (page) {
                    pageNumber = page;
                    _fetchCustomers();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget viewDesktop({
    required ColorScheme cs,
    required AppSemanticColors sem,
    required double wideBreakpoint,
  }) {
    final wide = MediaQuery.of(context).size.width >= wideBreakpoint;
    return Scaffold(
      drawer: wide
          ? null
          : Drawer(
              width: 240,
              backgroundColor: cs.surface,
              child: SideNav(activePath: '/forms'),
            ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(children: [TopBar(wide: wide)]);
        },
      ),
    );
  }
}
