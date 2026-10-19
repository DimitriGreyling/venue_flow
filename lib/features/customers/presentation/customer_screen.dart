import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:venue_flow_app/core/widgets/customer_auto_complete.dart';
import 'package:venue_flow_app/core/widgets/responsive.dart';
import 'package:venue_flow_app/core/widgets/top_bar.dart';
import 'package:venue_flow_app/features/customers/presentation/customer_controller.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/theme/theme_x.dart';
import '../../../core/widgets/side_nav.dart';
import '../data/customer_repository.dart';
import '../domain/customer.dart';

class CustomerScreen extends ConsumerStatefulWidget {
  const CustomerScreen({super.key});

  @override
  ConsumerState<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends ConsumerState<CustomerScreen> {
  bool isNewCustomer = false;
  bool isLoading = true;
  List<Customer> customers = [];

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
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 10));
    final repository = ref.read(customerRepositoryProvider);
    customers = await repository.getMembersForOrg();

    setState(() {
      // customers = [
      //   Customer(
      //     fullName: 'Alice Smith',
      //     email: 'alice@example.com',
      //     userId: '',
      //   ),
      //   Customer(fullName: 'Bob Jones', email: 'bob@example.com', userId: ''),
      //   Customer(
      //     fullName: 'Charlie Brown',
      //     email: 'charlie@express.com',
      //     userId: '',
      //   ),
      // ];
      isLoading = false; // Turn off loading when data arrives
    });
  }

  //Dialog For Adding a new customer to the list
  Future<void> addCustomer({required ColorScheme cs}) async {
    // Get total screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              insetPadding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: screenWidth > 800
                    ? screenWidth * 0.6
                    : screenWidth * 0.9,
                // 1. Cap the Dialog's overall absolute height limit relative to the viewport
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight:
                        screenHeight * 0.8, // Caps dialog at 80% screen height
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      // 2. Shrinks the dialog window to wrap content tightly
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header (Stays fixed at the top)
                        Text(
                          'Add Customer',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 16),

                        // 3. Flexible + SingleChildScrollView lets the form wrap tightly
                        // but automatically handles scrolling when the form grows too large.
                        Flexible(
                          child: SingleChildScrollView(
                            child: Form(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomerAutoComplete(
                                    isDisabled: isNewCustomer,
                                  ),
                                  CheckboxListTile(
                                    value: isNewCustomer,
                                    onChanged: (value) {
                                      setState(() {
                                        isNewCustomer = value!;
                                      });
                                    },
                                    title: const Text('Register new customer'),
                                  ),
                                  if (isNewCustomer) const SizedBox(height: 16),
                                  if (isNewCustomer)
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        labelText: 'First Name',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  if (isNewCustomer) const SizedBox(height: 16),
                                  if (isNewCustomer)
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        labelText: 'Surname',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  if (isNewCustomer) const SizedBox(height: 16),
                                  if (isNewCustomer)
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        labelText: 'Email',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Footer Actions (Stays fixed at the bottom)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: cs.error,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: cs.onError),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: cs.primary,
                              ),
                              onPressed: () {},
                              child: Text(
                                'Save',
                                style: TextStyle(color: cs.onPrimary),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
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
                    ElevatedButton.icon(
                      onPressed: () async {
                        await addCustomer(cs: cs);
                      },
                      label: Text('Add Customer'),
                      icon: Icon(Mdi.accountPlusOutline),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {},
                      label: Text('Refresh'),
                      icon: Icon(Mdi.refresh),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.all(16),
                child: Card(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Email')),
                        DataColumn(label: Text('Status')),
                      ],
                      rows: isLoading
                          ? <DataRow>[
                              DataRow(
                                cells: [
                                  DataCell(
                                    Skeletonizer(
                                      enabled: true,
                                      effect: ShimmerEffect(
                                        baseColor: cs.surfaceContainerLow,
                                        highlightColor: cs.surface,
                                      ),
                                      child: Text('Loading...'),
                                    ),
                                  ),
                                  DataCell(
                                    Skeletonizer(
                                      enabled: true,
                                      effect: ShimmerEffect(
                                        baseColor: cs.surfaceContainerLow,
                                        highlightColor: cs.surface,
                                      ),
                                      child: Text('Loading...'),
                                    ),
                                  ),
                                  DataCell(
                                    Skeletonizer(
                                      enabled: true,
                                      effect: ShimmerEffect(
                                        baseColor: cs.surfaceContainerLow,
                                        highlightColor: cs.surface,
                                      ),
                                      child: Text('Loading...'),
                                    ),
                                  ),
                                ],
                              ),
                            ]
                          : customers.map((customer) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(customer.fullName)),
                                  DataCell(Text(customer.email ?? '')),
                                  DataCell(
                                    Chip(
                                      label: Text(
                                        customer.userId != null
                                            ? 'New'
                                            : 'Returning',
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                    ),
                  ),
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
