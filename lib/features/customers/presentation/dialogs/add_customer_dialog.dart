import 'package:flutter/material.dart';

import '../../../../core/theme/theme_x.dart';
import '../../../../core/widgets/customer_auto_complete.dart';

class AddCustomerDialog extends StatelessWidget {
  AddCustomerDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AddCustomerDialog(),
    );
  }

  bool isNewCustomer = false;

  @override
  Widget build(BuildContext context) {
    // Get total screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;

    // return AlertDialog(
    //   title: const Text('Delete appointment'),
    //   content: Text('Are you sure you want to delete ?'),
    //   actions: [
    //     TextButton(
    //       onPressed: () => Navigator.of(context).pop(false),
    //       child: const Text('Cancel'),
    //     ),
    //     FilledButton(
    //       onPressed: () => Navigator.of(context).pop(true),
    //       child: const Text('Delete'),
    //     ),
    //   ],
    // );

    // showDialog(
    // barrierDismissible: false,
    // context: context,
    // builder: (context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: screenWidth > 800 ? screenWidth * 0.6 : screenWidth * 0.9,
            // 1. Cap the Dialog's overall absolute height limit relative to the viewport
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight:
                    screenHeight * 0.8, // Caps dialog at 80% screen height
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  // 2. Shrinks the dialog window to wrap content tightly
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header (Stays fixed at the top)
                    Text(
                      'Add Customer',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),

                    // 3. Flexible + SingleChildScrollView lets the form wrap tightly
                    // but automatically handles scrolling when the form grows too large.
                    Flexible(
                      child: SingleChildScrollView(
                        child: Form(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomerAutoComplete(isDisabled: isNewCustomer),
                              CheckboxListTile(
                                value: isNewCustomer,
                                onChanged: (value) {
                                  setState(() {
                                    isNewCustomer = value!;
                                  });
                                },
                                title: const Text('Register new customer'),
                              ),
                              if (isNewCustomer) const SizedBox(height: 16),
                              if (isNewCustomer)
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'First Name',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              if (isNewCustomer) const SizedBox(height: 16),
                              if (isNewCustomer)
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Surname',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              if (isNewCustomer) const SizedBox(height: 16),
                              if (isNewCustomer)
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Footer Actions (Stays fixed at the bottom)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: cs.error,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: cs.onError),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: cs.primary,
                          ),
                          onPressed: () {},
                          child: Text(
                            'Save',
                            style: TextStyle(color: cs.onPrimary),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      //   );
      // },
    );
  }
}
