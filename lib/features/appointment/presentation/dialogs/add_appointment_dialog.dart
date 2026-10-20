import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/core/theme/app_theme.dart';
import 'package:venue_flow_app/core/widgets/date_picker_field.dart';
import 'package:venue_flow_app/features/customers/domain/register_customer.dart';
import 'package:venue_flow_app/features/customers/presentation/customer_controller.dart';
import '../../../../core/theme/theme_x.dart' show ThemeX;
import '../../../../core/widgets/customer_auto_complete.dart';
import '../../../customers/domain/customer.dart';

///
/// Dialog popup to add a customer to a organization
///
class AddAppointmentDialog extends ConsumerStatefulWidget {
  const AddAppointmentDialog({super.key});

  static Future<bool?> show({required BuildContext context}) {
    return showDialog<bool>(
      context: context,
      builder: (_) => const AddAppointmentDialog(),
    );
  }

  @override
  ConsumerState<AddAppointmentDialog> createState() =>
      _AddAppointmentDialogState();
}

class _AddAppointmentDialogState extends ConsumerState<AddAppointmentDialog>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  bool _isSaving = false;

  Customer? _selectedCustomer;
  DateTime? _selectedDate;

  final TextEditingController _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _save({
    required ColorScheme cs,
    required AppSemanticColors sem,
  }) async {
    try {
      // if (_isSaving) return;
      //
      // setState(() {
      //   _isSaving = true;
      // });
      //
      // if (!_formKey.currentState!.validate()) {
      //   setState(() {
      //     _isSaving = false;
      //   });
      //   return;
      // }
      //
      // final repo = ref.watch(customerControllerProvider.notifier);
      //
      // if (_isNewCustomer) {
      //   await repo.registerCustomer(
      //     /// Password will be over written by the system and sent to the user via email
      //     RegisterCustomer(
      //       firstName: _firstNameController.text,
      //       lastName: _surnameController.text,
      //       email: _emailController.text,
      //     ),
      //   );
      // } else {
      //   await repo.linkCustomer(
      //     LinkCustomerToOrg(userId: _selectedCustomer!.userId, roleId: ''),
      //   );
      // }
      //
      // if (!mounted) return;
      //
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     backgroundColor: sem.success,
      //     content: Text('Customer added successfully'),
      //   ),
      // );
      //
      Navigator.of(context).pop(true);
    } catch (e) {
      setState(() {
        _isSaving = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: cs.error,
          content: Text('An error occurred: $e'),
        ),
      );
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000), // Earliest allowable date
      lastDate: DateTime(2100), // Latest allowable date
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;

    final textTheme = Theme.of(context).textTheme;

    final dialogWidth = screenSize.width > 800
        ? screenSize.width * 0.6
        : screenSize.width * 0.9;

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: SizedBox(
        width: dialogWidth,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: screenSize.height * 0.8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add Appointment', style: textTheme.headlineSmall),
                const SizedBox(height: 16),

                Flexible(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: _titleController,
                            decoration: const InputDecoration(
                              labelText: 'Appointment Title',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          DatePickerField(
                            initialValue: DateTime.now(),
                            label: 'Appointment Date',
                            onDateChanged: (date) {
                              setState(() {
                                _selectedDate = date;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cs.error,
                        foregroundColor: cs.onError,
                      ),
                      onPressed: _isSaving
                          ? null
                          : () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cs.primary,
                        foregroundColor: cs.onPrimary,
                      ),
                      onPressed: _isSaving
                          ? null
                          : () => _save(cs: cs, sem: sem),
                      child: _isSaving
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
