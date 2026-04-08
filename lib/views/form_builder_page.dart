import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/models/enums.dart';
import 'package:venue_flow_app/models/form_field_model.dart';
import 'package:venue_flow_app/providers/viewmodel_provider.dart';
import 'package:venue_flow_app/theme/components.dart';
import 'package:venue_flow_app/viewmodels/form_builder_viewmodel.dart';
import 'package:venue_flow_app/views/reordeable_form_fields_list.dart';
import '../theme/editorial_theme_data.dart';
import '../theme/spacing.dart';

class FormBuilderPage extends ConsumerStatefulWidget {
  const FormBuilderPage({super.key});

  @override
  ConsumerState<FormBuilderPage> createState() => _FormBuilderPageState();
}

class _FormBuilderPageState extends ConsumerState<FormBuilderPage> {
  String selectedFieldType = 'Text Input';
  bool isFieldSelected = true;
  final List<PopupMenuItem> fieldTypeMenuItems = [
    const PopupMenuItem(
      child: Text('Text Input'),
      value: FieldType.text,
    ),
    const PopupMenuItem(child: Text('Dropdown'), value: FieldType.dropdown),
    const PopupMenuItem(child: Text('Checkbox'), value: FieldType.checkbox),
    const PopupMenuItem(child: Text('Radio Button'), value: FieldType.radio),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final editorial = context.editorial;

    final formBuilderViewState = ref.watch(formBuilderViewModelProvider);
    final formBuilderViewModel =
        ref.watch(formBuilderViewModelProvider.notifier);

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

  Widget _buildComponentSidebar(BuildContext context, ColorScheme colorScheme,
      EditorialThemeData editorial) {
    return Container(
      width: 288,
      color: colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FORM ELEMENTS',
              style: editorial.labelUppercase.copyWith(
                color: colorScheme.onSurfaceVariant,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Column(
                children: [
                  _buildFormElements(colorScheme, editorial),
                  const SizedBox(height: 32),
                  Text(
                    'ADVANCED',
                    style: editorial.labelUppercase.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildAdvancedElements(colorScheme, editorial),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormElements(
      ColorScheme colorScheme, EditorialThemeData editorial) {
    final elements = [
      {'icon': Icons.short_text, 'title': 'Text Input'},
      {'icon': Icons.list, 'title': 'Select Menu'},
      {'icon': Icons.check_box_outlined, 'title': 'Checkbox Group'},
      {'icon': Icons.calendar_month, 'title': 'Date Picker'},
      {'icon': Icons.upload_file, 'title': 'File Upload'},
    ];

    return Column(
      children: elements
          .map(
            (element) => _buildDraggableElement(
              element['icon'] as IconData,
              element['title'] as String,
              colorScheme.secondary,
              colorScheme,
              editorial,
            ),
          )
          .toList(),
    );
  }

  Widget _buildAdvancedElements(
      ColorScheme colorScheme, EditorialThemeData editorial) {
    final elements = [
      {'icon': Icons.draw, 'title': 'E-Signature'},
      {'icon': Icons.payments, 'title': 'Payment Link'},
    ];

    return Column(
      children: elements
          .map(
            (element) => _buildDraggableElement(
              element['icon'] as IconData,
              element['title'] as String,
              colorScheme.tertiary,
              colorScheme,
              editorial,
            ),
          )
          .toList(),
    );
  }

  Widget _buildDraggableElement(
    IconData icon,
    String title,
    Color iconColor,
    ColorScheme colorScheme,
    EditorialThemeData editorial,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () async {
            TextEditingController nameController = TextEditingController();

            final result = await showDialog(
              context: context,
              builder: (context) {
                final screenSize = MediaQuery.of(context).size;
                final dialogWidth = screenSize.width > 768
                    ? screenSize.width * 0.7
                    : screenSize.width * 0.9;
                final dialogHeight = screenSize.height * 0.8;

                return Dialog(
                  child: SizedBox(
                    width: dialogWidth,
                    height: dialogHeight,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            'Add New Field',
                            style: editorial.labelBold,
                          ),
                          const Divider(),
                          TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              hintText: 'Name',
                              label: Text('Name'),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Submit')),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );

            ref.watch(formBuilderViewModelProvider.notifier).addFormField(
                    formFieldModel: FormFieldModel(
                  label: nameController.text,
                  placeholder: nameController.text,
                  required: true,
                  type: FieldType.text,
                ));
            // setState(() {
            //   selectedFieldType = title;
            // });
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.transparent),
            ),
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 20),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: editorial.navigationLabel.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
    List<String> dropDownOptions = [];

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible: false, // Prevent dismiss by tapping outside
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                            onPressed: () =>
                                Navigator.pop(dialogContext), // Cancel
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

                              // Placeholder Text
                              _buildTextField(
                                context,
                                label: 'Placeholder Text',
                                controller: placeholderController,
                                focusNode: FocusNode(),
                                hint: 'e.g., Enter your first name',
                                enabled: true,
                                textInputAction: TextInputAction.done,
                                validator: (value) {
                                  // Optional field
                                  return null;
                                },
                              ),

                              const SizedBox(height: 24),

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
                              onPressed: () => Navigator.pop(
                                  dialogContext), // Return null (cancel)
                              style: OutlinedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                style: editorial.buttonTextStyle,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Validate form
                                if (formKey.currentState?.validate() ?? false) {
                                  // Return the form data
                                  Navigator.pop(dialogContext, {
                                    'name': nameController.text.trim(),
                                    'placeholder':
                                        placeholderController.text.trim(),
                                    'required': isRequired,
                                    'fieldType': fieldType,
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

    //TODO :: dispose controllers properly
    // Dispose controllers
    // nameController.dispose();
    // placeholderController.dispose();

    return result; // This will be null if canceled, or Map<String, dynamic> if submitted
  }

  IconData _getIconForFieldType(FieldType fieldType) {
    switch (fieldType) {
      case FieldType.text:
        return Icons.short_text;
      // case FieldType.text:
      //   return Icons.list;
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
                    Text(
                      formBuilderState.form?.first.name ?? '',
                      style: textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: colorScheme.onSurface,
                      ),
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
                              placeholder: result!['placeholder'],
                              type: result['fieldType'],
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Text(
                                  page?.title ?? '',
                                  style: textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: colorScheme.onSurface,
                                  ),
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

  Widget _buildSectionHeader(ColorScheme colorScheme, TextTheme textTheme,
      EditorialThemeData editorial) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          left: BorderSide(color: colorScheme.primary, width: 4),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Event Essentials',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Basic information regarding the requested venue date and party size.',
                style: editorial.captionStyle.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          Icon(Icons.drag_indicator, color: colorScheme.outline),
        ],
      ),
    );
  }

  Widget _buildSelectedField(ColorScheme colorScheme, TextTheme textTheme,
      EditorialThemeData editorial) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.secondary, width: 2),
        boxShadow: [
          BoxShadow(
            color: colorScheme.secondary.withOpacity(0.05),
            blurRadius: 8,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Selected Badge
          Positioned(
            top: -48,
            left: -4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: colorScheme.secondary,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'SELECTED',
                style: editorial.labelUppercase.copyWith(
                  color: colorScheme.onSecondary,
                  fontSize: 10,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Full Name of Primary Contact',
                    style: editorial.labelBold.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.content_copy, size: 18),
                        color: colorScheme.outline,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete_outline, size: 18),
                        color: colorScheme.error,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: colorScheme.outlineVariant),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'e.g. Johnathan Smith',
                    style: editorial.placeholderStyle.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(
    String label,
    String placeholder,
    IconData? trailingIcon,
    bool isSelected,
    ColorScheme colorScheme,
    TextTheme textTheme,
    EditorialThemeData editorial,
  ) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? colorScheme.secondary : Colors.transparent,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: editorial.labelBold.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              Icon(Icons.drag_indicator, color: colorScheme.outlineVariant),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  placeholder,
                  style: editorial.placeholderStyle.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                if (trailingIcon != null)
                  Icon(trailingIcon, color: colorScheme.onSurfaceVariant),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropZone(ColorScheme colorScheme, EditorialThemeData editorial) {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outlineVariant,
          width: 2,
          style: BorderStyle.solid,
        ),
        color: colorScheme.surfaceContainerLow,
      ),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.surfaceContainer,
            ),
            child: Icon(
              Icons.add,
              color: colorScheme.outline,
              size: 24,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Drag a component here or click to add a field',
            style: editorial.labelSubtle.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertiesPanel(BuildContext context, ColorScheme colorScheme,
      TextTheme textTheme, EditorialThemeData editorial) {
    return Container(
      width: 320,
      color: colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.settings,
                    size: 16, color: colorScheme.onSurfaceVariant),
                const SizedBox(width: 8),
                Text(
                  'FIELD PROPERTIES',
                  style: editorial.labelUppercase.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPropertyField(
                    'Label',
                    'Full Name of Primary Contact',
                    colorScheme,
                    editorial,
                  ),
                  const SizedBox(height: 24),
                  _buildPropertyField(
                    'Placeholder Text',
                    'e.g. Johnathan Smith',
                    colorScheme,
                    editorial,
                  ),
                  const SizedBox(height: 32),

                  // Validation Toggles
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: colorScheme.outlineVariant.withOpacity(0.3),
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 24),
                    child: Column(
                      children: [
                        _buildToggleOption(
                            'Required Field', true, colorScheme, editorial),
                        const SizedBox(height: 16),
                        _buildToggleOption(
                            'Unique Answer', false, colorScheme, editorial),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Conditional Logic
                  Text(
                    'CONDITIONAL LOGIC',
                    style: editorial.labelUppercase.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildAddRuleButton(colorScheme, editorial),

                  const SizedBox(height: 32),

                  // Helper Info
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: colorScheme.tertiary,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Helper Text',
                                style: editorial.labelBold.copyWith(
                                  fontSize: 12,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Provide context to your guests for why this field is required.',
                                style: editorial.captionStyle.copyWith(
                                  fontSize: 10,
                                  color: colorScheme.onSurfaceVariant,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyField(
    String label,
    String value,
    ColorScheme colorScheme,
    EditorialThemeData editorial,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: editorial.labelBold.copyWith(
            fontSize: 12,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: colorScheme.surfaceContainerLowest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.secondary, width: 2),
            ),
            contentPadding: const EdgeInsets.all(12),
            hintText: value,
          ),
          style: editorial.formFieldStyle,
        ),
      ],
    );
  }

  Widget _buildToggleOption(
    String title,
    bool value,
    ColorScheme colorScheme,
    EditorialThemeData editorial,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: editorial.labelSubtle.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        GestureDetector(
          onTap: () {
            // Toggle functionality
          },
          child: Container(
            width: 40,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: value
                  ? colorScheme.primaryContainer
                  : colorScheme.outlineVariant,
            ),
            child: AnimatedAlign(
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              duration: const Duration(milliseconds: 200),
              child: Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.surface,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddRuleButton(
      ColorScheme colorScheme, EditorialThemeData editorial) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline,
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          '+ Add Display Rule',
          style: editorial.labelBold.copyWith(
            fontSize: 12,
            color: colorScheme.outline,
          ),
        ),
      ),
    );
  }
}
