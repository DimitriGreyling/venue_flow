import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:venue_flow_app/constants/tooltip_message_constants.dart';
import 'package:venue_flow_app/models/dynamic_form_model.dart';
import 'package:venue_flow_app/models/enums.dart';
import 'package:venue_flow_app/models/form_field_model.dart';
import 'package:venue_flow_app/models/user_model.dart';
import 'package:venue_flow_app/providers/auth_provider.dart';
import 'package:venue_flow_app/providers/viewmodel_provider.dart';
import 'package:venue_flow_app/routing/app_router.dart';
import 'package:venue_flow_app/viewmodels/form_builder_viewmodel.dart';
import 'package:venue_flow_app/views/reordeable_form_fields_list.dart';
import 'package:venue_flow_app/views/tooltip_widget.dart';
import '../theme/editorial_theme_data.dart';

class FormBuilderPage extends ConsumerStatefulWidget {
  final String? formId;
  final DynamicFormModel? formModel;

  const FormBuilderPage({super.key, this.formId, this.formModel});

  @override
  ConsumerState<FormBuilderPage> createState() => _FormBuilderPageState();
}

class _FormBuilderPageState extends ConsumerState<FormBuilderPage>
    with TickerProviderStateMixin {
  String selectedFieldType = 'Text Input';
  bool editFormName = false;
  bool editPageName = false;
  TextEditingController formNameController = TextEditingController();
  TextEditingController pageNameController = TextEditingController();

  // Floating Action Button variables
  TabController? _tabController;
  ScrollController _scrollController = ScrollController();
  bool _showFAB = false;
  int _currentTabIndex = 0;

  bool isFieldSelected = true;
  UserModel? user;

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
    const PopupMenuItem(
      value: FieldType.date,
      child: Text('Date'),
    ),
    const PopupMenuItem(
      value: FieldType.textarea,
      child: Text('Text Area'),
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.formId != null) {
        ref.read(formBuilderViewModelProvider.notifier).setForm(
              formId: widget.formId,
              formModel: widget.formModel,
            );
      }

      final currentUser =
          await ref.read(authRepositoryProvider).getCurrentUser();

      if (!mounted) return;

      setState(() {
        user = currentUser;
      });
    });

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _tabController?.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Show FAB when user scrolls down
    final bool shouldShow = _scrollController.offset > 100;
    if (shouldShow != _showFAB) {
      setState(() {
        _showFAB = shouldShow;
      });
    }
  }

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
        ],
      ),
      floatingActionButton: _showFAB &&
              (formBuilderViewState.form.first.schema?.isNotEmpty ?? false)
          ? _buildFloatingAddFieldButton(
              context: context,
              colorScheme: colorScheme,
              editorial: editorial,
              formBuilderState: formBuilderViewState,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildFloatingAddFieldButton({
    required BuildContext context,
    required ColorScheme colorScheme,
    required EditorialThemeData editorial,
    required FormBuilderViewState formBuilderState,
  }) {
    if (user != null && user!.isClient) {
      return const SizedBox.shrink();
    }
    return FloatingActionButton.extended(
      onPressed: formBuilderState.isLoading
          ? null
          : () {
              _showFieldTypeBottomSheet(
                context: context,
                colorScheme: colorScheme,
                editorial: editorial,
              );
            },
      icon: const Icon(Icons.add),
      label: const Text('Add Field'),
      backgroundColor: colorScheme.secondary,
      foregroundColor: colorScheme.onSecondary,
      tooltip: 'Add a new field to the current page',
      elevation: 6,
      heroTag: "addField", // Unique hero tag to avoid conflicts
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required ColorScheme colorScheme,
    required EditorialThemeData editorial,
    required FormBuilderViewState formBuilderState,
  }) {
    if (user != null && user!.isClient) {
      return const SizedBox.shrink();
    }

    return FloatingActionButton.extended(
      onPressed: formBuilderState.isLoading
          ? null
          : () {
              _showFieldTypeBottomSheet(
                context: context,
                colorScheme: colorScheme,
                editorial: editorial,
              );
            },
      icon: const Icon(Icons.add),
      label: const Text('Add Field'),
      backgroundColor: colorScheme.secondary,
      foregroundColor: colorScheme.onSecondary,
      tooltip: 'Add a new field to the current page',
      elevation: 0,
      heroTag: "addField", // Unique hero tag to avoid conflicts
    );
  }

  Future<void> _showFieldTypeBottomSheet({
    required BuildContext context,
    required ColorScheme colorScheme,
    required EditorialThemeData editorial,
  }) async {
    final selectedFieldType = await showModalBottomSheet<FieldType>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        color: colorScheme.primary,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Select Field Type',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ...fieldTypeMenuItems.map((item) {
                    final fieldType = item.value as FieldType;
                    final title = (item.child as Text).data ?? '';
                    return ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          _getIconForFieldType(fieldType),
                          color: colorScheme.primary,
                          size: 20,
                        ),
                      ),
                      title: Text(
                        title,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: colorScheme.onSurface,
                            ),
                      ),
                      subtitle: Text(
                        _getFieldDescription(fieldType),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                      ),
                      onTap: () {
                        Navigator.pop(context, fieldType);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );

    if (selectedFieldType != null) {
      final result = await _showAddFieldDialog(
        context: context,
        editorial: editorial,
        fieldType: selectedFieldType,
      );

      if (result != null) {
        ref.watch(formBuilderViewModelProvider.notifier).addFormField(
              formFieldModel: FormFieldModel(
                label: result['name'],
                placeholder: result['placeholder'],
                type: result['fieldType'],
                required: result['required'] ?? false,
                options: result['options'],
              ),
              index: _currentTabIndex,
            );
      }
    }
  }

  String _getFieldDescription(FieldType fieldType) {
    switch (fieldType) {
      case FieldType.text:
        return 'Single line text input';
      case FieldType.textarea:
        return 'Multi-line text input';
      case FieldType.dropdown:
        return 'Select from dropdown options';
      case FieldType.radio:
        return 'Choose one from multiple options';
      case FieldType.checkbox:
        return 'Check/uncheck option';
      case FieldType.date:
        return 'Date picker input';
      default:
        return 'Form input field';
    }
  }

  PreferredSizeWidget _buildAppBar(
      BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    return AppBar(
      
      backgroundColor: colorScheme.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 64,
      // leading: Row(
      //   children: [
      //     IconButton(onPressed: (){
      //       context.pop();
      //     }, icon: Icon(Icons.back_hand))
      //   ],
      // ),
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

    bool needsOptions = fieldType == FieldType.dropdown ||
        fieldType == FieldType.radio ||
        fieldType == FieldType.checkbox;

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
                                _buildLoadingString(
                                    isLoading: ref
                                        .watch(formBuilderViewModelProvider)
                                        .isLoading,
                                    actualLabel: 'Add Field'),
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
  }

  Future<void> _showDeletePageDialog(
      BuildContext context, int pageIndex) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Page'),
          content: const Text(
              'Are you sure you want to delete this page? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      ref.watch(formBuilderViewModelProvider.notifier).removePage(pageIndex);
    }
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
                            _buildLoadingString(
                                isLoading: formBuilderState.isLoading,
                                actualLabel:
                                    formBuilderState.form.first.name ?? ''),
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
                              label: _buildLoadingString(
                                  isLoading: formBuilderState.isLoading,
                                  actualLabel: 'Form Name'),
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
                          message: editFormName
                              ? TooltipMessageConstants.discardMessage
                              : TooltipMessageConstants.editPageNameMessage,
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
                            message:
                                TooltipMessageConstants.savePageNameMessage,
                            child: IconButton(
                                onPressed: () {
                                  editFormName = false;
                                  ref
                                      .watch(
                                          formBuilderViewModelProvider.notifier)
                                      .updateFormName(
                                          formNameController.text, 0);
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
                    if (user != null && user!.isCoordinator)
                      TooltipWidget(
                        message: TooltipMessageConstants.addPageMessage,
                        child: _buildActionButton(
                          text: _buildLoadingString(
                              isLoading: formBuilderState.isLoading,
                              actualLabel: 'Add Page'),
                          isPrimary: false,
                          isLoading: formBuilderState.isLoading,
                          colorScheme: colorScheme,
                          editorial: editorial,
                          callback: () {
                            ref
                                .watch(formBuilderViewModelProvider.notifier)
                                .addFormPage();
                          },
                        ),
                      ),
                    const SizedBox(width: 12),
                    if (user != null && user!.isCoordinator)
                      TooltipWidget(
                        message: TooltipMessageConstants.saveDraftMessage,
                        child: _buildActionButton(
                          isLoading: formBuilderState.isLoading,
                          isSecondary: true,
                          isElevated: true,
                          text: _buildLoadingString(
                              isLoading: formBuilderState.isLoading,
                              actualLabel: 'Save Draft'),
                          isPrimary: false,
                          colorScheme: colorScheme,
                          editorial: editorial,
                          callback: () {
                            ref
                                .watch(formBuilderViewModelProvider.notifier)
                                .saveForm(
                                  formStatus: FormStatus.draft,
                                );
                          },
                        ),
                      ),
                    const SizedBox(width: 12),
                    if (user != null && user!.isClient)
                      TooltipWidget(
                        message: TooltipMessageConstants.saveDraftMessage,
                        child: _buildActionButton(
                          isLoading: formBuilderState.isLoading,
                          text: _buildLoadingString(
                              isLoading: formBuilderState.isLoading,
                              actualLabel: 'Save'),
                          isPrimary: true,
                          colorScheme: colorScheme,
                          editorial: editorial,
                          // callback:
                          // () {
                          //   ref
                          //       .watch(formBuilderViewModelProvider.notifier)
                          //       .saveForm(
                          //         formStatus: FormStatus.active,
                          //       );
                          // },
                        ),
                      ),
                    if (user != null && user!.isCoordinator)
                      TooltipWidget(
                        message: TooltipMessageConstants.saveDraftMessage,
                        child: _buildActionButton(
                          isLoading: formBuilderState.isLoading,
                          text: _buildLoadingString(
                              isLoading: formBuilderState.isLoading,
                              actualLabel: 'Publish'),
                          isPrimary: true,
                          colorScheme: colorScheme,
                          editorial: editorial,
                          callback: () {
                            ref
                                .watch(formBuilderViewModelProvider.notifier)
                                .saveForm(
                                  formStatus: FormStatus.active,
                                );
                          },
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Canvas Area
            Expanded(
              child: formBuilderState.form.first.schema?.isEmpty ?? true
                  ? Center(
                      child: Text(
                        'No pages available',
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : _buildTabController(
                      context: context,
                      formBuilderState: formBuilderState,
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                      editorial: editorial,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabController({
    required BuildContext context,
    required FormBuilderViewState formBuilderState,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
    required EditorialThemeData editorial,
  }) {
    // Initialize tab controller if not already done or if length changed
    if (_tabController == null ||
        _tabController!.length != formBuilderState.form.first.schema!.length) {
      _tabController?.dispose();
      _tabController = TabController(
        length: formBuilderState.form.first.schema!.length,
        vsync: this,
      );
      _tabController!.addListener(() {
        if (!_tabController!.indexIsChanging) {
          setState(() {
            _currentTabIndex = _tabController!.index;
          });
        }
      });
    }

    return Column(
      children: [
        // TAB BAR
        IgnorePointer(
          ignoring: ref.watch(formBuilderViewModelProvider).isLoading,
          child: Container(
            alignment: Alignment.centerLeft,
            height: 50,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicatorColor: colorScheme.primary,
                labelColor: colorScheme.primary,
                unselectedLabelColor: colorScheme.onSurfaceVariant,
                labelStyle: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                labelPadding: const EdgeInsets.symmetric(horizontal: 16),
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 8),
                tabs: formBuilderState.form.first.schema!
                    .asMap()
                    .entries
                    .map((entry) {
                  final index = entry.key;
                  final page = entry.value;
                  return Tab(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: colorScheme.outlineVariant.withOpacity(0.5),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _buildLoadingString(
                                isLoading: formBuilderState.isLoading,
                                actualLabel: page.title ?? 'Page ${index + 1}'),
                          ),
                          const SizedBox(width: 8),
                          if (formBuilderState.form.first.schema!.length > 1)
                            GestureDetector(
                              onTap: formBuilderState.isLoading
                                  ? null
                                  : () {
                                      _showDeletePageDialog(context, index);
                                    },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: colorScheme.errorContainer
                                      .withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.close,
                                  size: 14,
                                  color: colorScheme.onErrorContainer,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),

        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: formBuilderState.form.first.schema!
                .asMap()
                .entries
                .map((entry) {
              final index = entry.key;
              final page = entry.value;

              return CustomScrollView(
                controller: _scrollController, // Add scroll controller here
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Page Header with Edit Functionality
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          if (!editPageName)
                                            Flexible(
                                              child: Text(
                                                _buildLoadingString(
                                                    isLoading: formBuilderState
                                                        .isLoading,
                                                    actualLabel: page.title ??
                                                        'Page ${index + 1}'),
                                                style: textTheme.headlineMedium
                                                    ?.copyWith(
                                                  fontWeight: FontWeight.w900,
                                                  color: colorScheme.onSurface,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          if (editPageName)
                                            Flexible(
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                child: _buildTextField(
                                                  context,
                                                  label: _buildLoadingString(
                                                      isLoading:
                                                          formBuilderState
                                                              .isLoading,
                                                      actualLabel: 'Page Name'),
                                                  controller:
                                                      pageNameController,
                                                  focusNode: FocusNode(),
                                                  hint:
                                                      'e.g. Contact Information',
                                                  enabled: true,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  validator: (value) => null,
                                                ),
                                              ),
                                            ),
                                          const SizedBox(width: 15),
                                          TooltipWidget(
                                            message: editPageName
                                                ? TooltipMessageConstants
                                                    .discardMessage
                                                : TooltipMessageConstants
                                                    .editPageNameMessage,
                                            child: IconButton(
                                              onPressed: formBuilderState
                                                      .isLoading
                                                  ? null
                                                  : !editPageName
                                                      ? () {
                                                          pageNameController
                                                                  .text =
                                                              page.title ?? '';
                                                          setState(() {
                                                            editPageName = true;
                                                          });
                                                        }
                                                      : () {
                                                          setState(() {
                                                            editPageName =
                                                                false;
                                                          });
                                                        },
                                              icon: editPageName
                                                  ? const Icon(Icons.close)
                                                  : const Icon(Icons.edit),
                                            ),
                                          ),
                                          if (editPageName)
                                            TooltipWidget(
                                              message: TooltipMessageConstants
                                                  .savePageNameMessage,
                                              child: IconButton(
                                                onPressed: formBuilderState
                                                        .isLoading
                                                    ? null
                                                    : () {
                                                        ref
                                                            .watch(
                                                                formBuilderViewModelProvider
                                                                    .notifier)
                                                            .updatePageName(
                                                              pageNameController
                                                                  .text,
                                                              index,
                                                            );
                                                        setState(() {
                                                          editPageName = false;
                                                        });
                                                      },
                                                icon: const Icon(Icons.check),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    _buildButton(
                                        context: context,
                                        colorScheme: colorScheme,
                                        editorial: editorial,
                                        formBuilderState: formBuilderState),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),

                  // Form Fields List as Sliver
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverToBoxAdapter(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width),
                          child: ReorderableFormFieldsList(
                            pageIndex: index,
                            fields: page.fields ?? [],
                            colorScheme: colorScheme,
                            editorial: editorial,
                            onReorder: (reorderFields) {
                              // Handle field reordering within this page
                              ref
                                  .watch(formBuilderViewModelProvider.notifier)
                                  .updateOrderOfList(
                                    reorderFields,
                                    index,
                                  );
                            },
                            onEditClicked: (field) {
                              // Handle field selection
                            },
                            onFieldDeleted: (field, fieldIndex) {
                              ref
                                  .watch(formBuilderViewModelProvider.notifier)
                                  .removeField(
                                    formFieldModel: field,
                                    index: fieldIndex,
                                  );
                            },
                            onFieldDuplicated: (field) {
                              // Handle field duplication
                              ref
                                  .watch(formBuilderViewModelProvider.notifier)
                                  .duplicateFiel(
                                    field,
                                    index,
                                  );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Add some bottom padding for better scrolling
                  const SliverPadding(
                    padding: EdgeInsets.only(bottom: 100),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String text,
    bool isPrimary = false,
    bool isSecondary = false,
    bool isElevated = false,
    required ColorScheme colorScheme,
    required EditorialThemeData editorial,
    void Function()? callback,
    bool isLoading = false,
  }) {
    return MaterialButton(
      onPressed: isLoading ? null : () => callback?.call(),
      padding: EdgeInsets.symmetric(
        horizontal: isPrimary ? 24 : 20,
        vertical: 12,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: isPrimary ? colorScheme.primaryContainer : colorScheme.surface,
      elevation: isPrimary || isElevated ? 2 : 0,
      child: Text(
        text,
        style: editorial.buttonTextStyle.copyWith(
          color: isPrimary
              ? colorScheme.onPrimary
              : isSecondary
                  ? colorScheme.secondary
                  : colorScheme.onSurfaceVariant,
          fontWeight: isPrimary ? FontWeight.w700 : FontWeight.w600,
        ),
      ),
    );
  }

  String _buildLoadingString(
      {required bool isLoading, required String actualLabel}) {
    return isLoading ? 'Loading...' : actualLabel;
  }
}
