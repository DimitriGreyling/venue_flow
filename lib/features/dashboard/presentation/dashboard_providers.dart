import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DashRange {
  d30('Last 30 Days', 30),
  d90('Last 90 Days', 90);

  const DashRange(this.label, this.days);
  final String label;
  final int days;
}

class DashRangeNotifier extends Notifier<DashRange> {
  @override
  DashRange build() => DashRange.d30;

  void select(DashRange range) => state = range;
}

final dashRangeProvider =
NotifierProvider<DashRangeNotifier, DashRange>(DashRangeNotifier.new);

/// TODO: replace the sample data below with real API data.
final eventsSeriesProvider = Provider<List<double>>((ref) {
  switch (ref.watch(dashRangeProvider)) {
    case DashRange.d30:
      return const [22, 18, 20, 30, 26, 34, 40, 38, 45, 42, 52, 48];
    case DashRange.d90:
      return const [14, 18, 16, 22, 28, 25, 30, 36, 33, 41, 39, 52];
  }
});

const _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

/// 5 evenly spaced labels ending today.
final eventsAxisLabelsProvider = Provider<List<String>>((ref) {
  final range = ref.watch(dashRangeProvider);
  final now = DateTime.now();
  return List.generate(5, (i) {
    final d = now.subtract(Duration(days: range.days * (4 - i) ~/ 4));
    return '${_months[d.month - 1]} ${d.day.toString().padLeft(2, '0')}';
  });
});