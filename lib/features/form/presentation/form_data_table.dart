import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:venue_flow_app/core/widgets/status_badge.dart';
import 'package:venue_flow_app/features/form/data/form_controller.dart';
import 'package:venue_flow_app/features/form/presentation/dialogs/delete_form_dialog.dart';
import '../../../core/domain/paged_response.dart';
import '../../../core/enums/badge_status.dart';
import '../domain/form_list_id.dart';
import '../domain/form_list_item.dart';

class FormDataTable extends ConsumerStatefulWidget {
  const FormDataTable({
    super.key,
    required this.columns,
    required this.forms,
    required this.constraints,
    required this.isLoading,
    required this.onPageChanged,
    this.requiresRefresh,
  });

  final List<DataColumn> columns;
  final PagedResponse<FormListId> forms;
  final BoxConstraints constraints;
  final bool isLoading;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<bool>? requiresRefresh;

  @override
  ConsumerState<FormDataTable> createState() => _FormDataTableState();
}

class _FormDataTableState extends ConsumerState<FormDataTable> {
  final formDetailsProvider = FutureProvider.family<FormListItem, String>((
    ref,
    formId,
  ) async {
    final controller = ref.read(formControllerProvider.notifier);

    return controller.getFormById(formId: formId);
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SizedBox(
      height: widget.constraints.maxHeight * 0.8,
      width: widget.constraints.maxWidth,
      child: Container(
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              // Extremely soft shadow
              blurRadius: 10,
              // Makes the shadow smooth
              spreadRadius: 0,
              // Prevents it from looking harsh
              offset: const Offset(0, 4), // Pushes the shadow down slightly
            ),
          ],
        ),
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
                          : widget.forms.items.map((form) {
                              return buildAsyncDataRow<FormListItem>(
                                cs: cs,
                                value: ref.watch(formDetailsProvider(form.id)),
                                cellCount: widget.columns.length,
                                buildCells: (form) => [
                                  DataCell(Text(form.name)),
                                  DataCell(
                                    SizedBox(
                                      width: 200,
                                      child: Tooltip(
                                        message: form.description?.isNotEmpty == true
                                            ? form.description!
                                            : 'Not provided',
                                        child: Text(
                                          form.description?.isNotEmpty == true
                                              ? form.description!
                                              : 'Not provided',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    StatusBadge(
                                      label: form.formType ?? '',
                                      status: BadgeStatus.info,
                                    ),
                                  ),
                                  DataCell(
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            context.push('/forms/${form.id}');
                                          },
                                          tooltip: 'Edit ${form.name}',
                                          icon: Icon(
                                            Mdi.pencil,
                                            color: cs.secondary,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            await DeleteFormDialog.show(
                                              context,
                                              form,
                                            );

                                            if (!mounted) return;

                                            widget.requiresRefresh?.call(true);

                                            ref.invalidate(
                                              formDetailsProvider(form.id),
                                            );
                                            ref.invalidate(
                                              formControllerProvider,
                                            );
                                          },
                                          tooltip: 'Remove ${form.name}',
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
      widget.forms.pageSize.clamp(1, 5),
      (_) => DataRow(
        cells: List.generate(
          widget.columns.length,
          (_) => DataCell(
            Skeletonizer(
              enabled: true,
              effect: ShimmerEffect(
                baseColor: cs.surfaceContainer,
                highlightColor: cs.surfaceContainerLow,
              ),
              child: const Text('Loading placeholder'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaginationControls(ColorScheme cs) {
    final result = widget.forms;
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
