import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/core/enums/form_type.dart';
import 'package:venue_flow_app/features/form/data/form_controller.dart';
import 'package:venue_flow_app/features/form/domain/form_details_model.dart';
import '../../../../core/theme/theme_x.dart' show ThemeX;

///
/// Dialog popup to edit a form name
///
class EditFormNameDialog extends ConsumerStatefulWidget {
  const EditFormNameDialog({
    super.key,
    this.formName,
    this.formDescription,
    this.formType,
    this.onChanged,
  });

  final String? formName;
  final String? formDescription;
  final FormType? formType;
  final ValueChanged<FormDetailsModel?>? onChanged;

  static Future<bool?> show(
    BuildContext context, {
    String? formName,
    String? formDescription,
    FormType? formType,
    ValueChanged<FormDetailsModel?>? onChanged,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (_) => EditFormNameDialog(
        formName: formName,
        formDescription: formDescription,
        formType: formType,
        onChanged: onChanged,
      ),
    );
  }

  @override
  ConsumerState<EditFormNameDialog> createState() => _EditFormNameDialogState();
}

class _EditFormNameDialogState extends ConsumerState<EditFormNameDialog>
    with TickerProviderStateMixin {
  //form keys
  final _formNameFormKey = GlobalKey<FormState>();

  final TextEditingController _formNameController = TextEditingController();
  final TextEditingController _formDescriptionController =
      TextEditingController();
  late FormType _selectedFormType;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    _formNameController.text = widget.formName ?? '';
    _formDescriptionController.text = widget.formDescription ?? '';
    _selectedFormType = widget.formType ?? FormType.Food;
  }

  @override
  void dispose() {
    _formNameController.dispose();
    _formDescriptionController.dispose();
    _formNameFormKey.currentState?.dispose();
    super.dispose();
  }

  void _save({required ColorScheme cs, required dynamic sem}) async {
    try {
      if (_isSaving) return;

      setState(() {
        _isSaving = true;
      });

      FormDetailsModel formDetails = FormDetailsModel();

      formDetails = formDetails.copyWith(
        name: _formNameController.text,
        description: _formDescriptionController.text,
        type: _selectedFormType,
      );

      widget.onChanged?.call(formDetails);

      Navigator.of(context).pop(true);
    } catch (e, stackTrace) {
      print('$stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: cs.error,
          content: Text('Failed to update form details: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
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
          constraints: BoxConstraints(maxHeight: screenSize.height * 0.4),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Edit Form Name', style: textTheme.titleLarge),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formNameFormKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<FormType>(
                                  initialValue: _selectedFormType,
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    labelText: 'Form Type',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  items: FormType.values.map((formType) {
                                    return DropdownMenuItem<FormType>(
                                      value: formType,
                                      child: Text(formType.label),
                                    );
                                  }).toList(),
                                  onChanged: (FormType? newValue) {
                                    setState(() {
                                      _selectedFormType = newValue ?? FormType.Food;
                                    });
                                  },
                                )
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _formNameController,
                            decoration: const InputDecoration(
                              labelText: 'Form Name',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a form name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            maxLines: 5,
                            minLines: 3,
                            keyboardType: TextInputType.multiline,
                            controller: _formDescriptionController,
                            decoration: const InputDecoration(
                              labelText: 'Form Description',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a form description';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: cs.error,
                //         foregroundColor: cs.onError,
                //       ),
                //       onPressed: _isSaving
                //           ? null
                //           : () => Navigator.of(context).pop(false),
                //       child: const Text('Cancel'),
                //     ),
                //     ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: cs.primary,
                //         foregroundColor: cs.onPrimary,
                //       ),
                //       onPressed: _isSaving
                //           ? null
                //           : () => _save(cs: cs, sem: sem),
                //       child: _isSaving
                //           ? const SizedBox(
                //               width: 16,
                //               height: 16,
                //               child: CircularProgressIndicator(strokeWidth: 2),
                //             )
                //           : const Text('Save'),
                //     ),
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        // Removes solid background
                        shadowColor: Colors.transparent,
                        // Removes shadow elevation
                        side: BorderSide(color: cs.error, width: 1.5),
                        // Adds outline
                        foregroundColor: cs.onError, // Text colour
                      ),
                      onPressed: _isSaving
                          ? null
                          : () => Navigator.of(context).pop(false),
                      child: Text('Cancel', style: TextStyle(color: cs.error)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        // Removes solid background
                        shadowColor: Colors.transparent,
                        // Removes shadow elevation
                        side: BorderSide(color: cs.primary, width: 1.5),
                        // Adds outline
                        foregroundColor: cs.onPrimary, // Text colour
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
                          : Text('Update', style: TextStyle(color: cs.primary)),
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
