import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GenericTableColumn<T> {
  final String header;
  final int flex;
  final Widget Function(BuildContext context, T row) cellBuilder;
  final Widget Function(BuildContext context)? skeletonCellBuilder;

  const GenericTableColumn({
    required this.header,
    required this.cellBuilder,
    this.flex = 1,
    this.skeletonCellBuilder,
  });
}

class GenericDataTable<T> extends StatelessWidget {
  final List<GenericTableColumn<T>> columns;
  final List<T> rows;
  final bool isLoading;
  final int skeletonRowCount;
  final double rowHeight;
  final double maxBodyHeight;
  final double minTableWidth;
  final void Function(T row)? onRowTap;
  final String emptyMessage;

  const GenericDataTable({
    super.key,
    required this.columns,
    required this.rows,
    required this.isLoading,
    this.skeletonRowCount = 6,
    this.rowHeight = 64,
    this.maxBodyHeight = 420,
    this.minTableWidth = 640,
    this.onRowTap,
    this.emptyMessage = 'No data available',
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.hasBoundedWidth
            ? constraints.maxWidth
            : minTableWidth;
        final tableWidth = availableWidth < minTableWidth
            ? minTableWidth
            : availableWidth;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: tableWidth,
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: 0.05),
                ),
              ),
              child: Column(
                children: [
                  _buildHeader(context),
                  SizedBox(
                    height: maxBodyHeight,
                    child: isLoading
                        ? Skeletonizer(
                            enabled: true,
                            child: ListView.builder(
                              itemCount: skeletonRowCount,
                              itemBuilder: (context, index) =>
                                  _buildSkeletonRow(context),
                            ),
                          )
                        : rows.isEmpty
                            ? Center(
                                child: Text(
                                  emptyMessage,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: rows.length,
                                itemBuilder: (context, index) {
                                  final row = rows[index];

                                  return _HoverableTableRow<T>(
                                    row: row,
                                    rowHeight: rowHeight,
                                    onTap: onRowTap == null
                                        ? null
                                        : () => onRowTap!(row),
                                    child: _buildDataRow(context, row),
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        children: columns
            .map(
              (col) => Expanded(
                flex: col.flex,
                child: Text(
                  col.header,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildDataRow(BuildContext context, T row) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: rowHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.08),
          ),
        ),
      ),
      child: Row(
        children: columns
            .map(
              (col) => Expanded(
                flex: col.flex,
                child: col.cellBuilder(context, row),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildSkeletonRow(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: rowHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.08),
          ),
        ),
      ),
      child: Row(
        children: columns
            .map(
              (col) => Expanded(
                flex: col.flex,
                child: col.skeletonCellBuilder?.call(context) ??
                    _defaultSkeletonCell(context),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _defaultSkeletonCell(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 120,
        height: 14,
        decoration: BoxDecoration(
          color:
              Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}

class _HoverableTableRow<T> extends StatefulWidget {
  final T row;
  final double rowHeight;
  final Widget child;
  final VoidCallback? onTap;

  const _HoverableTableRow({
    required this.row,
    required this.rowHeight,
    required this.child,
    this.onTap,
  });

  @override
  State<_HoverableTableRow<T>> createState() => _HoverableTableRowState<T>();
}

class _HoverableTableRowState<T> extends State<_HoverableTableRow<T>> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      opaque: true,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onTap == null
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        width: double.infinity,
        color: _isHovered
            ? colorScheme.primary.withValues(alpha: 0.06)
            : Colors.transparent,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            child: SizedBox(
              width: double.infinity,
              height: widget.rowHeight,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
