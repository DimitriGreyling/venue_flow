import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:venue_flow_app/features/customers/presentation/dialogs/delete_customer_dialog.dart';

import '../../../core/theme/theme_x.dart';
import '../data/member_response.dart';
import '../domain/customer.dart';
import 'customer_controller.dart';

class CustomerDataTable extends ConsumerStatefulWidget {
  const CustomerDataTable({
    super.key,
    required this.columns,
    required this.customers,
    required this.constraints,
    required this.isLoading,
    this.requiresRefresh,
  });

  final List<DataColumn> columns;
  final List<MemberResponse> customers;
  final BoxConstraints constraints;
  final bool isLoading;
  final ValueChanged<bool>? requiresRefresh;

  @override
  ConsumerState<CustomerDataTable> createState() => _CustomerDataTableState();
}

class _CustomerDataTableState extends ConsumerState<CustomerDataTable> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;

    return Container(
      height: widget.constraints.maxHeight * 0.8,
      child: Card(
        elevation: 2,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: widget.constraints.maxWidth),
          child: DataTable(
            columns: widget.columns,
            rows: widget.isLoading
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
                        DataCell(
                          Skeletonizer(
                            enabled: true,
                            effect: ShimmerEffect(
                              baseColor: cs.surfaceContainerLow,
                              highlightColor: cs.surface,
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Mdi.accountEdit),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]
                : widget.customers.map((customer) {
                    return buildAsyncDataRow(
                      cs: cs,
                      value: ref.watch(
                        customerDetailsProvider(customer.userId),
                      ),
                      cellCount: widget.columns.length,
                      buildCells: (customer) => [
                        DataCell(Text(customer.fullName)),
                        DataCell(Text(customer.email ?? '')),
                        DataCell(Text(customer.email ?? '')),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                onPressed: () async {},
                                tooltip: 'Edit ${customer.fullName}',
                                icon: Icon(Mdi.accountEdit),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await DeleteCustomerDialog.show(
                                    context,
                                    customer,
                                  );

                                  if (widget.requiresRefresh != null) {
                                    widget.requiresRefresh?.call(true);
                                  }
                                },
                                tooltip: 'Remove ${customer.fullName}',
                                icon: Icon(Mdi.delete, color: cs.error),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
          ),
        ),
      ),
    );
  }

  DataRow buildAsyncDataRow<T>({
    required AsyncValue<T> value,
    required int cellCount,
    required List<DataCell> Function(T data) buildCells,
    required ColorScheme cs,
  }) {
    return value.when(
      loading: () => DataRow(
        cells: List.generate(
          cellCount,
          (_) => DataCell(
            Skeletonizer(
              effect: ShimmerEffect(
                baseColor: cs.surfaceContainerLow,
                highlightColor: cs.surface,
              ),
              enabled: true,
              child: Text('Loading placeholder'),
            ),
          ),
        ),
      ),
      error: (error, stackTrace) => DataRow(
        cells: List.generate(
          cellCount,
          (index) => DataCell(Text(index == 0 ? 'Failed to load' : '-')),
        ),
      ),
      data: (data) => DataRow(cells: buildCells(data)),
    );
  }
}
