import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/models/enums.dart';
import 'package:venue_flow_app/models/form_field_model.dart';
import 'package:venue_flow_app/providers/viewmodel_provider.dart';
import 'package:venue_flow_app/viewmodels/form_builder_viewmodel.dart';
import 'package:venue_flow_app/views/reordeable_form_fields_list.dart';
import 'package:venue_flow_app/views/tooltip_widget.dart';
import '../theme/editorial_theme_data.dart';

class FormBuilderPage extends ConsumerStatefulWidget {
  const FormBuilderPage({super.key});

  @override
  ConsumerState<FormBuilderPage> createState() => _FormBuilderPageState();
}

class _FormBuilderPageState extends ConsumerState<FormBuilderPage> {
  String selectedFieldType = 'Text Input';
  bool editFormName = false;
  bool editPageName = false;
  TextEditingController formNameController = TextEditingController();
  TextEditingController pageNameNameController = TextEditingController();

  bool isFieldSelected = true;
  final List<PopupMenuItem> fieldTypeMenuItems = [
    const PopupMenuItem(
      value: FieldType.text,
      child: Text('Text Input'),
    ),
    const PopupMenuItem(
      value: FieldType.dropdown,
      child: Text('Dropdown'),
    ),
    const PopupMenuItem(
      value: FieldType.radio,
      child: Text('Radio Button'),
    ),
    const PopupMenuItem(
      value: FieldType.checkbox,
      child: Text('Checkbox'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final editorial = context.editorial;

    final formBuilderViewState = ref.watch(formBuilderViewModelProvider);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: _buildAppBar(context, colorScheme, textTheme),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Left Sidebar - Form Elements
          // _buildComponentSidebar(context, colorScheme, editorial),

          // Center Canvas - Form Builder
          Expanded(
            child: _buildFormCanvas(
              context: context,
              colorScheme: colorScheme,
              textTheme: textTheme,
              editorial: editorial,
              formBuilderState: formBuilderViewState,
            ),
          ),

          // Right Sidebar - Properties Panel
          //TODO implement hide and show when field is selected
          // _buildPropertiesPanel(context, colorScheme, textTheme, editorial),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
      BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    return AppBar(
      backgroundColor: colorScheme.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 64,
      title: Row(
        children: [
          Text(
            'Venue Flow',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 48),
          _buildNavigation(context, colorScheme),
        ],
      ),
      actions: [
        _buildHeaderActions(context, colorScheme),
      ],
    );
  }

  Widget _buildNavigation(BuildContext context, ColorScheme colorScheme) {
    return Row(
      children: [
        _buildNavItem('Dashboard', false, colorScheme),
        const SizedBox(width: 24),
        _buildNavItem('Forms', true, colorScheme),
        const SizedBox(width: 24),
        _buildNavItem('Events', false, colorScheme),
        const SizedBox(width: 24),
        _buildNavItem('Settings', false, colorScheme),
      ],
    );
  }

  Widget _buildNavItem(String title, bool isActive, ColorScheme colorScheme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            color:
                isActive ? colorScheme.primary : colorScheme.onSurfaceVariant,
          ),
        ),
        if (isActive)
          Container(
            height: 2,
            width: 40,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
      ],
    );
  }

  Widget _buildHeaderActions(BuildContext context, ColorScheme colorScheme) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search, color: colorScheme.onSurfaceVariant),
        ),
        Stack(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_outlined,
                  color: colorScheme.onSurfaceVariant),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: colorScheme.error,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
        CircleAvatar(
          radius: 16,
          backgroundColor: colorScheme.outlineVariant,
          child:
              Icon(Icons.person, size: 18, color: colorScheme.onSurfaceVariant),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Future<Map<String, dynamic>?> _showAddFieldDialog({
    required BuildContext context,
    required EditorialThemeData editorial,
    required FieldType fieldType,
  }) async {
    final nameController = TextEditingController();
    final placeholderController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool isRequired = false;

    // Simple approach - track only what's needed for UI
    List<String> fieldOptions = [''];
    List<TextEditingController> optionControllers = [TextEditingController()];

    bool needsOptions =
        fieldType == FieldType.dropdown || fieldType == FieldType.radio;

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            void addOption() {
              setState(() {
                fieldOptions.add('');
                optionControllers.add(TextEditingController());
              });
            }

            void removeOption(int index) {
              if (optionControllers.length > 1) {
                setState(() {
                  // Don't dispose - just remove from list
                  optionControllers.removeAt(index);
                  fieldOptions.removeAt(index);
                });
              }
            }

            final screenSize = MediaQuery.of(context).size;
            final dialogWidth = screenSize.width > 768
                ? screenSize.width * 0.4
                : screenSize.width * 0.9;
            final dialogHeight = screenSize.height * 0.6;

            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                width: dialogWidth,
                height: dialogHeight,
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        children: [
                          Icon(
                            _getIconForFieldType(fieldType),
                            color: Theme.of(context).colorScheme.primary,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Add $fieldType',
                            style: editorial.labelBold.copyWith(fontSize: 18),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      const Divider(height: 32),

                      // Form Fields
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // Field Name
                              _buildTextField(
                                context,
                                label: 'Field Label',
                                controller: nameController,
                                focusNode: FocusNode(),
                                hint: 'e.g., First Name',
                                enabled: true,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value?.trim().isEmpty ?? true) {
                                    return 'Field label is required';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 16),

                              // Placeholder Text (only for non-option fields)
                              if (!needsOptions) ...[
                                _buildTextField(
                                  context,
                                  label: 'Placeholder Text',
                                  controller: placeholderController,
                                  focusNode: FocusNode(),
                                  hint: 'e.g., Enter your first name',
                                  enabled: true,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) => null,
                                ),
                                const SizedBox(height: 24),
                              ],

                              // Options Management (for dropdown/radio)
                              if (needsOptions) ...[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${fieldType.name.toUpperCase()} Options',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .outline,
                                                fontWeight: FontWeight.w900,
                                                letterSpacing: 1.3,
                                              ),
                                        ),
                                        TextButton.icon(
                                          onPressed: addOption,
                                          icon: const Icon(Icons.add, size: 16),
                                          label: const Text('Add Option'),
                                          style: TextButton.styleFrom(
                                            foregroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    ...optionControllers
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      final index = entry.key;
                                      final controller = entry.value;

                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                controller: controller,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'Option ${index + 1}',
                                                  filled: true,
                                                  fillColor: Theme.of(context)
                                                      .colorScheme
                                                      .surfaceContainerLowest,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    borderSide: BorderSide.none,
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    horizontal: 12,
                                                    vertical: 12,
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value?.trim().isEmpty ??
                                                      true) {
                                                    return 'Option cannot be empty';
                                                  }
                                                  return null;
                                                },
                                                onChanged: (value) {
                                                  fieldOptions[index] = value;
                                                },
                                              ),
                                            ),
                                            if (optionControllers.length > 1)
                                              IconButton(
                                                onPressed: () =>
                                                    removeOption(index),
                                                icon: const Icon(Icons
                                                    .remove_circle_outline),
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .error,
                                              ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                                const SizedBox(height: 24),
                              ],

                              const SizedBox(height: 8),

                              // Required Toggle
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainerLowest,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        'Required Field',
                                        style: editorial.labelSubtle.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                      ),
                                    ),
                                    Switch(
                                      value: isRequired,
                                      onChanged: (value) {
                                        setState(() {
                                          isRequired = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(dialogContext),
                              style: OutlinedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text('Cancel',
                                  style: editorial.buttonTextStyle),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState?.validate() ?? false) {
                                  if (needsOptions) {
                                    final validOptions = optionControllers
                                        .map((controller) =>
                                            controller.text.trim())
                                        .where((option) => option.isNotEmpty)
                                        .toList();

                                    if (validOptions.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: const Text(
                                              'Please add at least one option'),
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .error,
                                        ),
                                      );
                                      return;
                                    }
                                  }

                                  Navigator.pop(dialogContext, {
                                    'name': nameController.text.trim(),
                                    'placeholder': needsOptions
                                        ? null
                                        : placeholderController.text.trim(),
                                    'required': isRequired,
                                    'fieldType': fieldType,
                                    'options': needsOptions
                                        ? optionControllers
                                            .map((controller) =>
                                                controller.text.trim())
                                            .where(
                                                (option) => option.isNotEmpty)
                                            .toList()
                                        : null,
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Add Field',
                                style: editorial.buttonTextStyle.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    return result;
    // NO finally block - let Flutter handle garbage collection
  }

  IconData _getIconForFieldType(FieldType fieldType) {
    switch (fieldType) {
      case FieldType.text:
        return Icons.short_text;
      case FieldType.textarea:
        return Icons.notes;
      case FieldType.dropdown:
        return Icons.arrow_drop_down_circle;
      case FieldType.radio:
        return Icons.radio_button_checked;
      case FieldType.checkbox:
        return Icons.check_box_outlined;
      case FieldType.date:
        return Icons.calendar_month;
      // case 'File Upload':
      //   return Icons.upload_file;
      // case 'E-Signature':
      //   return Icons.draw;
      // case 'Payment Link':
      //   return Icons.payments;
      default:
        return Icons.help;
    }
  }

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hint,
    IconData? icon,
    required bool enabled,
    bool obscureText = false,
    Widget? suffix,
    TextInputAction? textInputAction,
    void Function(String)? onFieldSubmitted,
    String? Function(String?)? validator,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: scheme.outline,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.3,
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          enabled: enabled,
          obscureText: obscureText,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          validator: validator,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: scheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: icon != null
                ? Icon(
                    icon,
                    color: scheme.onSurfaceVariant,
                    size: 20,
                  )
                : null,
            suffixIcon: suffix,
            filled: true,
            fillColor: scheme.surfaceContainerLowest,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
            errorMaxLines: 2,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                color: scheme.primaryContainer.withOpacity(0.50),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                color: scheme.error.withOpacity(0.80),
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                color: scheme.error,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormCanvas({
    required BuildContext context,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
    required EditorialThemeData editorial,
    required FormBuilderViewState formBuilderState,
  }) {
    if (formBuilderState.isLoading) {
      return const CircularProgressIndicator();
    }

    return Container(
      color: colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'INTAKE DESIGNER',
                      style: editorial.labelUppercase.copyWith(
                        color: colorScheme.secondary,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (!editFormName)
                          Text(
                            formBuilderState.form.first.name ?? '',
                            style: textTheme.headlineLarge?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        if (editFormName)
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: _buildTextField(
                              context,
                              label: 'Form Name',
                              controller: formNameController,
                              focusNode: FocusNode(),
                              hint: 'e.g. Meal Options',
                              enabled: true,
                              textInputAction: TextInputAction.done,
                              validator: (value) => null,
                            ),
                          ),
                        const SizedBox(
                          width: 15,
                        ),
                        TooltipWidget(
                          message: 'Change form name',
                          child: IconButton(
                              onPressed: !editFormName
                                  ? () {
                                      setState(() {
                                        editFormName = true;
                                      });
                                    }
                                  : () {
                                      setState(() {
                                        editFormName = false;
                                      });
                                    },
                              icon: editFormName
                                  ? const Icon(Icons.close)
                                  : const Icon(Icons.edit)),
                        ),
                        if (editFormName)
                          TooltipWidget(
                            message: 'Save form name',
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    formBuilderState.form.first.name =
                                        formNameController.text;
                                    editFormName = false;
                                  });
                                },
                                icon: editFormName
                                    ? const Icon(Icons.check)
                                    : const Icon(Icons.check)),
                          ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    PopupMenuButton(
                      tooltip:
                          'Add new fields to your form for clients to fill in.',
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: const Text('Add a field'),
                      ),
                      onSelected: (value) async {
                        final result = await _showAddFieldDialog(
                          context: context,
                          editorial: editorial,
                          fieldType: value,
                        );

                        ref
                            .watch(formBuilderViewModelProvider.notifier)
                            .addFormField(
                                formFieldModel: FormFieldModel(
                              label: result!['name'],
                              placeholder: result['placeholder'],
                              type: result['fieldType'],
                              required: result['required'] ?? false,
                              options: result['options'],
                            ));
                      },
                      itemBuilder: (context) {
                        return fieldTypeMenuItems;
                      },
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    // _buildActionButton(
                    //     'Preview', false, colorScheme, editorial),
                    // const SizedBox(width: 12),
                    _buildActionButton(
                      text: 'Save Draft',
                      isPrimary: false,
                      colorScheme: colorScheme,
                      editorial: editorial,
                    ),
                    // const SizedBox(width: 12),
                    // _buildActionButton(
                    //     'Publish Form', true, colorScheme, editorial),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Canvas Area
            Expanded(
              child: Container(
                // constraints: const BoxConstraints(maxWidth: 768),
                child: PageView.builder(
                  itemBuilder: (context, index) {
                    final page = formBuilderState.form?.first.pages![index];
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                if (!editPageName)
                                  Text(
                                    page?.title ?? '',
                                    style: textTheme.headlineMedium?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                if (editPageName)
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: _buildTextField(
                                      context,
                                      label: 'Page Name',
                                      controller: pageNameNameController,
                                      focusNode: FocusNode(),
                                      hint: 'e.g. Starch Options',
                                      enabled: true,
                                      textInputAction: TextInputAction.done,
                                      validator: (value) => null,
                                    ),
                                  ),
                                const SizedBox(
                                  width: 15,
                                ),
                                TooltipWidget(
                                  message: 'Change page name',
                                  child: IconButton(
                                      onPressed: !editPageName
                                          ? () {
                                              setState(() {
                                                editPageName = true;
                                              });
                                            }
                                          : () {
                                              setState(() {
                                                editPageName = false;
                                              });
                                            },
                                      icon: editPageName
                                          ? const Icon(Icons.close)
                                          : const Icon(Icons.edit)),
                                ),
                                if (editPageName)
                                  TooltipWidget(
                                    message: 'Save form name',
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            page?.title =
                                                pageNameNameController.text;
                                            editPageName = false;
                                          });
                                        },
                                        icon: editFormName
                                            ? const Icon(Icons.check)
                                            : const Icon(Icons.check)),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        // Reorderable Form Fields List
                        ReorderableFormFieldsList(
                          fields: page?.fields ??
                              [], //_getFormFields(formBuilderState),
                          // selectedFieldId: selectedFieldId,
                          colorScheme: colorScheme,
                          editorial: editorial,
                          onReorder: (oldIndex, newIndex) {
                            // _handleFieldReorder(oldIndex, newIndex);
                          },
                          onFieldSelected: (field) {
                            // _handleFieldSelection(field);
                          },
                          onFieldDeleted: (field, fieldIndex) {
                            ref
                                .watch(formBuilderViewModelProvider.notifier)
                                .removeField(
                                  formFieldModel: field,
                                  index: fieldIndex,
                                );
                            // _handleFieldDeletion(field);
                          },
                          onFieldDuplicated: (field) {
                            // _handleFieldDuplication(field);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required bool isPrimary,
    required ColorScheme colorScheme,
    required EditorialThemeData editorial,
    void Function()? callback,
  }) {
    return MaterialButton(
      onPressed: () => callback?.call(),
      padding: EdgeInsets.symmetric(
        horizontal: isPrimary ? 24 : 20,
        vertical: 12,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: isPrimary
          ? colorScheme.primaryContainer
          : colorScheme.surfaceContainerLowest,
      elevation: isPrimary ? 2 : 0,
      child: Text(
        text,
        style: editorial.buttonTextStyle.copyWith(
          color:
              isPrimary ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
          fontWeight: isPrimary ? FontWeight.w700 : FontWeight.w600,
        ),
      ),
    );
  }
}
