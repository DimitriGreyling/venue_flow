import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/core/theme/app_theme.dart';
import 'package:venue_flow_app/features/customers/domain/register_customer.dart';
import 'package:venue_flow_app/features/customers/domain/update_customer.dart';
import 'package:venue_flow_app/features/customers/presentation/customer_controller.dart';
import '../../../../core/theme/theme_x.dart';
import '../../../../core/widgets/customer_auto_complete.dart';
import '../../domain/customer.dart';
import '../../domain/link_customer_to_org.dart';

///
/// Dialog popup to edit a customer to a organization
///
class EditCustomerDialog extends ConsumerStatefulWidget {
  const EditCustomerDialog({super.key, required this.customer});

  final UpdateCustomer customer;

  static Future<bool?> show(
    BuildContext context, {
    required UpdateCustomer customer,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (_) => EditCustomerDialog(customer: customer),
    );
  }

  @override
  ConsumerState<EditCustomerDialog> createState() => _EditCustomerDialogState();
}

class _EditCustomerDialogState extends ConsumerState<EditCustomerDialog>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.customer.firstName;
    _surnameController.text = widget.customer.lastName;
    _emailController.text = widget.customer.email ?? '';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _save({
    required ColorScheme cs,
    required AppSemanticColors sem,
  }) async {
    try {
      if (_isSaving) return;

      setState(() {
        _isSaving = true;
      });

      if (!_formKey.currentState!.validate()) {
        setState(() {
          _isSaving = false;
        });
        return;
      }

      final repo = ref.watch(customerControllerProvider.notifier);

      await repo.updateCustomerDetails(
        UpdateCustomer(
          userId: widget.customer.userId,
          firstName: _firstNameController.text,
          lastName: _surnameController.text,
          email: _emailController.text,
        ),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: sem.success,
          content: Text('Customer updated successfully'),
        ),
      );

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
                Text('Edit Customer', style: textTheme.headlineSmall),
                const SizedBox(height: 16),

                Flexible(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Animate the height change when the fields appear.
                          AnimatedSize(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            alignment: Alignment.topCenter,
                            child: selectedCustomerDetailsView(
                              customer: widget.customer,
                            ),
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

  Widget selectedCustomerDetailsView({UpdateCustomer? customer}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Selected Customer:'),
        const SizedBox(height: 16),
        TextFormField(
          enabled: !_isSaving,
          controller: _firstNameController,
          decoration: const InputDecoration(
            labelText: 'Full Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          enabled: !_isSaving,
          controller: _surnameController,
          decoration: const InputDecoration(
            labelText: 'Last Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          enabled: !_isSaving,
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
