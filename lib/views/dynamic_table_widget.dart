import 'package:flutter/material.dart';

class DynamicTableColumn<T> {
  const DynamicTableColumn({
    required this.title,
    required this.minWidth,
    required this.flex,
    required this.cellBuilder,
    this.headerAlignment = Alignment.centerLeft,
    this.cellAlignment = Alignment.centerLeft,
  });

  final String title;
  final double minWidth;
  final int flex;
  final Widget Function(BuildContext context, T row) cellBuilder;
  final Alignment headerAlignment;
  final Alignment cellAlignment;
}

// class DynamicTable<T> extends StatelessWidget {
//   const DynamicTable({
//     super.key,
//     required this.rows,
//     required this.columns,
//     required this.height,
//     this.headerHeight = 56,
//     this.rowHeight = 64,
//     this.borderRadius = 16,
//     this.emptyBuilder,
//   });

//   final List<T> rows;
//   final List<DynamicTableColumn<T>> columns;
//   final double height;
//   final double headerHeight;
//   final double rowHeight;
//   final double borderRadius;
//   final WidgetBuilder? emptyBuilder;

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final totalMinWidth =
//             columns.fold<double>(0, (sum, column) => sum + column.minWidth);
//         final totalFlex =
//             columns.fold<int>(0, (sum, column) => sum + column.flex);

//         final availableHeight = constraints.maxHeight;
//         final availableWidth = constraints.maxWidth;
//         final resolvedTableWidth =
//             availableWidth > totalMinWidth ? availableWidth : totalMinWidth;

//         final extraWidth =
//             resolvedTableWidth > totalMinWidth ? resolvedTableWidth - totalMinWidth : 0;

//         final resolvedWidths = columns.map((column) {
//           if (extraWidth == 0 || totalFlex == 0) {
//             return column.minWidth;
//           }

//           return column.minWidth + (extraWidth * column.flex / totalFlex);
//         }).toList();

//         return Container(
//           height: availableWidth * 0.5,
//           decoration: BoxDecoration(
//             color: colorScheme.surfaceContainerLowest,
//             borderRadius: BorderRadius.circular(borderRadius),
//             border: Border.all(
//               color: colorScheme.outline.withOpacity(0.08),
//             ),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(borderRadius),
//             child: Scrollbar(
//               thumbVisibility: true,
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: SizedBox(
//                   width: resolvedTableWidth,
//                   height: height,
//                   child: Column(
//                     children: [
//                       _TableHeader<T>(
//                         columns: columns,
//                         widths: resolvedWidths,
//                         height: headerHeight,
//                       ),
//                       Expanded(
//                         child: rows.isEmpty
//                             ? (emptyBuilder?.call(context) ??
//                                 const Center(child: Text('No data')))
//                             : ListView.separated(
//                                 itemCount: rows.length,
//                                 separatorBuilder: (_, __) => Divider(
//                                   height: 1,
//                                   color: colorScheme.outline.withOpacity(0.08),
//                                 ),
//                                 itemBuilder: (context, index) {
//                                   return _TableRow<T>(
//                                     row: rows[index],
//                                     columns: columns,
//                                     widths: resolvedWidths,
//                                     height: rowHeight,
//                                   );
//                                 },
//                               ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class DynamicTable<T> extends StatelessWidget {
  const DynamicTable({
    super.key,
    required this.rows,
    required this.columns,
    required this.height,
    this.headerHeight = 56,
    this.rowHeight = 64,
    this.borderRadius = 16,
    this.horizontalPadding = 16,
    this.emptyBuilder,
  });

  final List<T> rows;
  final List<DynamicTableColumn<T>> columns;
  final double height;
  final double headerHeight;
  final double rowHeight;
  final double borderRadius;
  final double horizontalPadding;
  final WidgetBuilder? emptyBuilder;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalMinWidth =
            columns.fold<double>(0, (sum, column) => sum + column.minWidth);
        final totalFlex =
            columns.fold<int>(0, (sum, column) => sum + column.flex);

        final availableWidth = constraints.maxWidth;
        final contentViewportWidth = (availableWidth - (horizontalPadding * 2))
            .clamp(0.0, double.infinity);

        final resolvedContentWidth = contentViewportWidth > totalMinWidth
            ? contentViewportWidth
            : totalMinWidth;

        final extraWidth = resolvedContentWidth > totalMinWidth
            ? resolvedContentWidth - totalMinWidth
            : 0.0;

        final resolvedWidths = columns.map((column) {
          if (extraWidth == 0 || totalFlex == 0) {
            return column.minWidth;
          }

          return column.minWidth + (extraWidth * column.flex / totalFlex);
        }).toList();

        final tableWidth = resolvedContentWidth + (horizontalPadding * 2);

        return Container(
          height: height,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: colorScheme.outline.withOpacity(0.08),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: tableWidth,
                height: height,
                child: Column(
                  children: [
                    _TableHeader<T>(
                      columns: columns,
                      widths: resolvedWidths,
                      height: headerHeight,
                      horizontalPadding: horizontalPadding,
                    ),
                    Expanded(
                      child: rows.isEmpty
                          ? (emptyBuilder?.call(context) ??
                              const Center(child: Text('No data')))
                          : ListView.separated(
                              itemCount: rows.length,
                              separatorBuilder: (_, __) => Divider(
                                height: 1,
                                color: colorScheme.outline.withOpacity(0.08),
                              ),
                              itemBuilder: (context, index) {
                                return _TableRow<T>(
                                  row: rows[index],
                                  columns: columns,
                                  widths: resolvedWidths,
                                  height: rowHeight,
                                  horizontalPadding: horizontalPadding,
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// class _TableHeader<T> extends StatelessWidget {
//   const _TableHeader({
//     required this.columns,
//     required this.widths,
//     required this.height,
//   });

//   final List<DynamicTableColumn<T>> columns;
//   final List<double> widths;
//   final double height;

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     final textStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
//           fontWeight: FontWeight.w700,
//           color: colorScheme.onSurface,
//         );

//     return Container(
//       height: height,
//       color: colorScheme.surfaceContainerLow,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         children: List.generate(columns.length, (index) {
//           final column = columns[index];
//           return SizedBox(
//             width: widths[index],
//             child: Align(
//               alignment: column.headerAlignment,
//               child: Text(column.title, style: textStyle),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

class _TableHeader<T> extends StatelessWidget {
  const _TableHeader({
    required this.columns,
    required this.widths,
    required this.height,
    required this.horizontalPadding,
  });

  final List<DynamicTableColumn<T>> columns;
  final List<double> widths;
  final double height;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
        );

    return Container(
      height: height,
      color: colorScheme.surfaceContainerLow,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        children: List.generate(columns.length, (index) {
          final column = columns[index];
          return SizedBox(
            width: widths[index],
            child: Align(
              alignment: column.headerAlignment,
              child: Text(
                column.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textStyle,
              ),
            ),
          );
        }),
      ),
    );
  }
}

// class _TableRow<T> extends StatelessWidget {
//   const _TableRow({
//     required this.row,
//     required this.columns,
//     required this.widths,
//     required this.height,
//   });

//   final T row;
//   final List<DynamicTableColumn<T>> columns;
//   final List<double> widths;
//   final double height;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: height,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Row(
//           children: List.generate(columns.length, (index) {
//             final column = columns[index];
//             return SizedBox(
//               width: widths[index],
//               child: Align(
//                 alignment: column.cellAlignment,
//                 child: column.cellBuilder(context, row),
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }

class _TableRow<T> extends StatelessWidget {
  const _TableRow({
    required this.row,
    required this.columns,
    required this.widths,
    required this.height,
    required this.horizontalPadding,
  });

  final T row;
  final List<DynamicTableColumn<T>> columns;
  final List<double> widths;
  final double height;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Row(
          children: List.generate(columns.length, (index) {
            final column = columns[index];
            return SizedBox(
              width: widths[index],
              child: Align(
                alignment: column.cellAlignment,
                child: column.cellBuilder(context, row),
              ),
            );
          }),
        ),
      ),
    );
  }
}
