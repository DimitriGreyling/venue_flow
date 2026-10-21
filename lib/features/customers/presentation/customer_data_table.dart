import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:venue_flow_app/features/customers/domain/update_customer.dart';
import 'package:venue_flow_app/features/customers/presentation/dialogs/delete_customer_dialog.dart';
import 'package:venue_flow_app/features/customers/presentation/dialogs/edit_customer_dialog.dart';
import '../../../core/domain/paged_response.dart';
import '../../../core/theme/theme_x.dart';
import '../domain/member_response.dart';
import '../domain/customer.dart';
import 'customer_controller.dart';

class CustomerDataTable extends ConsumerStatefulWidget {
  const CustomerDataTable({
    super.key,
    required this.columns,
    required this.customers,
    required this.constraints,
    required this.isLoading,
    required this.onPageChanged,
    this.requiresRefresh,
  });

  final List<DataColumn> columns;
  final PagedResponse<MemberResponse> customers;
  final BoxConstraints constraints;
  final bool isLoading;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<bool>? requiresRefresh;

  @override
  ConsumerState<CustomerDataTable> createState() => _CustomerDataTableState();
}

class _CustomerDataTableState extends ConsumerState<CustomerDataTable> {
  final customerDetailsProvider = FutureProvider.family<Customer, String>((
    ref,
    customerId,
  ) async {
    final controller = ref.read(customerControllerProvider.notifier);

    return controller.getMemberDetailsById(customerId);
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SizedBox(
      height: widget.constraints.maxHeight * 0.8,
      width: widget.constraints.maxWidth,
      child: Card(
        elevation: 2,
        // clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: widget.constraints.maxWidth,
                    ),
                    child: DataTable(
                      columns: widget.columns,
                      rows: widget.isLoading
                          ? _buildLoadingRows(cs)
                          : widget.customers.items.map((customer) {
                        return buildAsyncDataRow<Customer>(
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
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      await EditCustomerDialog.show(
                                        context,
                                        customer: UpdateCustomer(
                                          userId: customer.userId,
                                          firstName: customer.firstName,
                                          lastName: customer.lastName,
                                          email: customer.email,
                                        ),
                                      );

                                      if (!mounted) return;

                                      widget.requiresRefresh?.call(true);

                                      ref.invalidate(
                                        customerDetailsProvider(
                                          customer.userId,
                                        ),
                                      );
                                    },
                                    tooltip: 'Edit ${customer.fullName}',
                                    icon: Icon(
                                      Mdi.accountEdit,
                                      color: cs.secondary,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await DeleteCustomerDialog.show(
                                        context,
                                        customer,
                                      );

                                      if (!mounted) return;

                                      widget.requiresRefresh?.call(true);

                                      ref.invalidate(
                                        customerDetailsProvider(
                                          customer.userId,
                                        ),
                                      );
                                    },
                                    tooltip: 'Remove ${customer.fullName}',
                                    icon: Icon(
                                      Mdi.delete,
                                      color: cs.error,
                                    ),
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
              ),
            ),
            const Divider(height: 1),
            _buildPaginationControls(cs),
          ],
        ),
      ),
    );
  }

  List<DataRow> _buildLoadingRows(ColorScheme cs) {
    return List.generate(
      widget.customers.pageSize.clamp(1, 5),
      (_) => DataRow(
        cells: List.generate(
          widget.columns.length,
          (_) => DataCell(
            Skeletonizer(
              enabled: true,
              effect: ShimmerEffect(
                baseColor: cs.surfaceContainerLow,
                highlightColor: cs.surface,
              ),
              child: const Text('Loading placeholder'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaginationControls(ColorScheme cs) {
    final result = widget.customers;
    final page = result.page;
    final pageSize = result.pageSize;
    final totalCount = result.totalCount;
    final totalPages = result.totalPages;

    final start = totalCount == 0 ? 0 : (page - 1) * pageSize + 1;
    final end = (page * pageSize).clamp(0, totalCount);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$start–$end of $totalCount members',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          IconButton(
            tooltip: 'Previous page',
            onPressed: !widget.isLoading && page > 1
                ? () => widget.onPageChanged(page - 1)
                : null,
            icon: const Icon(Icons.chevron_left),
          ),
          Text(
            '${totalPages == 0 ? 0 : page} / $totalPages',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          IconButton(
            tooltip: 'Next page',
            onPressed: !widget.isLoading && page < totalPages
                ? () => widget.onPageChanged(page + 1)
                : null,
            icon: const Icon(Icons.chevron_right),
          ),
        ],
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
              enabled: true,
              effect: ShimmerEffect(
                baseColor: cs.surfaceContainerLow,
                highlightColor: cs.surface,
              ),
              child: const Text('Loading placeholder'),
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
