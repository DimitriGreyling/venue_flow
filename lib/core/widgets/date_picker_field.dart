import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Run 'flutter pub add intl' for date formatting

class DatePickerField extends StatefulWidget {
  const DatePickerField({
    super.key,
    this.label = '',
    this.initialValue,
    this.onDateChanged,
  });

  final String? label;
  final DateTime? initialValue;
  final ValueChanged<DateTime>? onDateChanged;

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  // 1. Controller to update the text inside the field
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialValue;
    if (_selectedDate != null) {
      _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
    }
  }

  Future<void> _pickDate() async {
    final DateTime now = DateTime.now();

    // 1. Strip hours, minutes, and seconds to start exactly at 12:00 AM today
    final DateTime today = DateTime(now.year, now.month, now.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      // 2. Fallback to today if the previously selected date is in the past
      initialDate: (_selectedDate != null && _selectedDate!.isAfter(today))
          ? _selectedDate!
          : today,
      // 3. Set the absolute earliest allowable date to today
      firstDate: today,
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TextFormField(
        controller: _dateController,
        readOnly: true,
        // Prevents the on-screen keyboard from popping up
        onTap: _pickDate, // Triggers the calendar when the user taps the field
        decoration: InputDecoration(
          labelText: widget.label ?? 'Select Date',
          hintText: 'YYYY-MM-DD',
          suffixIcon: const Icon(Icons.calendar_today),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
