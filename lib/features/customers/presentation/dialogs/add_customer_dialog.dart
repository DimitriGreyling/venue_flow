import 'package:flutter/material.dart';
import '../../../../core/widgets/customer_auto_complete.dart';
import '../../domain/customer.dart';

class AddCustomerDialog extends StatefulWidget {
  const AddCustomerDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (_) => const AddCustomerDialog(),
    );
  }

  @override
  State<AddCustomerDialog> createState() => _AddCustomerDialogState();
}

class _AddCustomerDialogState extends State<AddCustomerDialog>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();

  bool _isNewCustomer = false;
  bool _hasSelectedCustomer = false;

  Customer? _selectedCustomer;

  @override
  void dispose() {
    _firstNameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _toggleNewCustomer(bool? value) {
    if (value == null || value == _isNewCustomer) return;

    setState(() {
      _isNewCustomer = value;
    });
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    // TODO: Save the customer using your service/provider.
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final cs = Theme.of(context).colorScheme;
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
                Text('Add Customer', style: textTheme.headlineSmall),
                const SizedBox(height: 16),

                Flexible(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomerAutoComplete(
                            isDisabled: _isNewCustomer,
                            onCustomerSelected: (customer) {
                              _selectedCustomer = customer;
                              if (_selectedCustomer != null) {
                                setState(() {
                                  _isNewCustomer = false;
                                  _hasSelectedCustomer = true;
                                });
                              } else {
                                setState(() {
                                  _isNewCustomer = false;
                                  _hasSelectedCustomer = false;
                                });
                              }
                            },
                          ),

                          CheckboxListTile(
                            enabled: !_hasSelectedCustomer,
                            contentPadding: EdgeInsets.zero,
                            value: _isNewCustomer,
                            onChanged: _toggleNewCustomer,
                            title: const Text('Register new customer'),
                            controlAffinity: ListTileControlAffinity.leading,
                          ),

                          // Animate the height change when the fields appear.
                          AnimatedSize(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            alignment: Alignment.topCenter,
                            child: _isNewCustomer
                                ? addNewCustomer()
                                : _hasSelectedCustomer
                                ? selectedCustomerDetailsView(
                                    customer: _selectedCustomer,
                                  )
                                : const SizedBox.shrink(),
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
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cs.primary,
                        foregroundColor: cs.onPrimary,
                      ),
                      onPressed: _save,
                      child: const Text('Save'),
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

  Widget addNewCustomer() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        TextFormField(
          controller: _firstNameController,
          decoration: const InputDecoration(
            labelText: 'First Name',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (_isNewCustomer && (value == null || value.trim().isEmpty)) {
              return 'Enter a first name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _surnameController,
          decoration: const InputDecoration(
            labelText: 'Surname',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (_isNewCustomer && (value == null || value.trim().isEmpty)) {
              return 'Enter a surname';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (!_isNewCustomer) return null;

            final email = value?.trim() ?? '';
            if (email.isEmpty) {
              return 'Enter an email address';
            }

            if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
              return 'Enter a valid email address';
            }

            return null;
          },
        ),
      ],
    );
  }

  Widget selectedCustomerDetailsView({Customer? customer}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Selected Customer:'),
        const SizedBox(height: 16),
        TextFormField(
          controller: TextEditingController(text: customer?.fullName ?? ''),
          decoration: const InputDecoration(
            labelText: 'Full Name',
            border: OutlineInputBorder(),
          ),
          enabled: false,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: TextEditingController(text: customer?.email ?? ''),
          enabled: false,
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
