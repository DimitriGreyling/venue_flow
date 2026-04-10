import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime? {
  String toDateString() {
    if (this == null) return '';
    return DateFormat('yyyy-MM-dd').format(this!);
  }
  
  String toShortDate() {
    if (this == null) return '';
    return DateFormat('MMM d, yyyy').format(this!);
  }
  
  String toDisplayDate() {
    if (this == null) return '';
    return DateFormat('MMMM d, yyyy').format(this!);
  }
}