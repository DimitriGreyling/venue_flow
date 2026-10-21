import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../../core/domain/paged_response.dart';
import '../../../../core/theme/theme_x.dart';
import '../../../../core/widgets/side_nav.dart';
import '../../../../core/widgets/top_bar.dart';
import '../../domain/member_response.dart';
import '../customer_controller.dart';
import '../customer_data_table.dart';
import '../dialogs/add_customer_dialog.dart';

class CustomerMobileView extends ConsumerStatefulWidget {
  const CustomerMobileView({super.key});

  @override
  ConsumerState<CustomerMobileView> createState() => _CustomerMobileViewState();
}

class _CustomerMobileViewState extends ConsumerState<CustomerMobileView> {
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

  Future<void> _fetchCustomers() async {
    final repository = ref.watch(customerControllerProvider.notifier);
    customers = await repository.getMembersForOrg(
      page: pageNumber,
      pageSize: 10,
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
}
