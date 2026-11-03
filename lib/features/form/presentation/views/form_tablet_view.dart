import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:venue_flow_app/core/enums/form_field_type.dart';
import 'package:venue_flow_app/core/enums/tool_bar_options.dart';
import 'package:venue_flow_app/core/theme/app_theme.dart';
import 'package:venue_flow_app/core/theme/theme_x.dart';
import 'package:venue_flow_app/core/widgets/side_nav.dart';
import 'package:venue_flow_app/core/widgets/top_bar.dart';

import 'package:venue_flow_app/features/form/domain/create_form_request.dart';
import 'package:venue_flow_app/features/form/domain/form_field_data.dart';
import 'package:venue_flow_app/features/form/domain/form_field_schema.dart';
import 'package:venue_flow_app/features/form/domain/form_page_schema.dart';
import 'package:venue_flow_app/features/form/domain/form_schema.dart';
import 'package:venue_flow_app/features/form/presentation/dialogs/edit_form_field_dialog.dart';

import 'package:venue_flow_app/features/form/presentation/dialogs/edit_form_name_dialog.dart';
import 'package:venue_flow_app/features/form/presentation/widgets/form_field_widget.dart';

class FormTabletView extends ConsumerStatefulWidget {
  const FormTabletView({super.key});

  @override
  ConsumerState<FormTabletView> createState() => _FormTabletViewState();
}

class _FormTabletViewState extends ConsumerState<FormTabletView> {
  final Uuid _uuid = const Uuid();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CreateFormRequest _createFormRequest = CreateFormRequest(
    name: 'Form Name',
    description: '',
    schema: const FormSchema(
      pages: [FormPageSchema(id: 'page-1', title: 'Page 1', orderNumber: 0)],
    ),
  );

  String _selectedPageId = 'page-1';

  // Floating fields toolbar position.
  double _floatingFieldsTop = 120;
  double _floatingFieldsLeft = 20;

  // Floating settings toolbar position.
  double _floatingSettingsTop = 120;
  double _floatingSettingsLeft = 20;

  bool _isPositionsInitialized = false;
  bool _showFloatingFieldsBar = false;
  bool _showFloatingSettingsBar = false;
  bool _isExpanded = false;

  FormFieldSchema? _selectedFieldForEdit;
  int? _selectedOrderNumber;

  List<FormFieldData> _formFields = [
    FormFieldData(
      fieldType: FormFieldType.Text,
      leadingIcon: Icons.text_fields,
      title: 'Text Field',
      // onTap: (value) {},
      subtitle: 'Single-line text input',
      trailingIcon: Icons.add,
      trailingTooltip: 'Add text field',
    ),
    FormFieldData(
      fieldType: FormFieldType.TextArea,
      leadingIcon: Icons.text_fields,
      title: 'Text Area Field',
      // onTap: (value) {},
      subtitle: 'Multi-line text input',
      trailingIcon: Icons.add,
      trailingTooltip: 'Add text area field',
    ),
    FormFieldData(
      fieldType: FormFieldType.DatePicker,
      leadingIcon: Icons.date_range,
      title: 'Date Picker Field',
      // onTap: (value) {},
      subtitle: 'Select a date',
      trailingIcon: Icons.add,
      trailingTooltip: 'Add date picker field',
    ),
    FormFieldData(
      fieldType: FormFieldType.IntField,
      leadingIcon: Icons.numbers,
      title: 'Int Field',
      // onTap: (value) {},
      subtitle: 'Enter an integer',
      trailingIcon: Icons.add,
      trailingTooltip: 'Add number field',
    ),
  ];

  @override
  void dispose() {
    super.dispose();
  }

  FormSchema get _schema => _createFormRequest.schema ?? const FormSchema();

  List<FormPageSchema> get _pages => _schema.pages;

  FormPageSchema? get _selectedPage {
    for (final page in _pages) {
      if (page.id == _selectedPageId) {
        return page;
      }
    }

    return null;
  }

  void _updateRequest(CreateFormRequest request) {
    setState(() {
      _createFormRequest = request;
    });
  }

  void _updateSchema(FormSchema schema) {
    _updateRequest(_createFormRequest.copyWith(schema: schema));
  }

  void _selectPage(String pageId) {
    if (pageId == _selectedPageId) return;

    setState(() {
      _selectedPageId = pageId;
    });
  }

  void _addPage() {
    final newPage = FormPageSchema(
      id: _uuid.v4(),
      title: 'Page ${_pages.length + 1}',
      orderNumber: _pages.length,
    );

    _updateSchema(_schema.copyWith(pages: [..._pages, newPage]));

    setState(() {
      _selectedPageId = newPage.id;
    });
  }

  void _renameSelectedPage(String title) {
    final page = _selectedPage;
    final trimmedTitle = title.trim();

    if (page == null || trimmedTitle.isEmpty) return;

    _updateSchema(
      _schema.copyWith(
        pages: [
          for (final item in _pages)
            if (item.id == page.id)
              item.copyWith(title: trimmedTitle)
            else
              item,
        ],
      ),
    );
  }

  void _deleteSelectedPage() {
    if (_pages.length <= 1) return;

    final remainingPages = _pages
        .where((page) => page.id != _selectedPageId)
        .toList();

    final reorderedPages = [
      for (var i = 0; i < remainingPages.length; i++)
        remainingPages[i].copyWith(orderNumber: i),
    ];

    _updateSchema(_schema.copyWith(pages: reorderedPages));

    setState(() {
      _selectedPageId = reorderedPages.first.id;
    });
  }

  void _addField(FormFieldType fieldType) {
    final page = _selectedPage;
    if (page == null) return;

    final field = FormFieldSchema(
      fieldType: fieldType,
      title: _defaultFieldTitle(fieldType),
      hintText: _defaultFieldHint(fieldType),
      orderNumber: page.fields.length,
    );

    _updateSchema(
      _schema.copyWith(
        pages: [
          for (final item in _pages)
            if (item.id == page.id)
              item.copyWith(fields: [...item.fields, field])
            else
              item,
        ],
      ),
    );
  }

  String _defaultFieldTitle(FormFieldType type) {
    switch (type) {
      case FormFieldType.Text:
        return 'Text field';
      default:
        return 'New field';
    }
  }

  String _defaultFieldHint(FormFieldType type) {
    switch (type) {
      case FormFieldType.Text:
        return 'Enter your answer';
      default:
        return '';
    }
  }

  ///
  /// Open Edit dialog to edit the users form field details
  ///
  Future<void> _openEditField(int orderNumber) async {
    final page = _selectedPage;
    if (page == null) return;

    setState(() {
      _selectedOrderNumber = orderNumber;
      _selectedFieldForEdit = page.fields.firstWhere(
        (field) => field.orderNumber == orderNumber,
      );
      // _showFloatingSettingsBar = !_showFloatingSettingsBar;
    });

    await EditFormFieldDialog.show(
      context,
      formFieldSchema: _selectedFieldForEdit,
      onFormFieldSchemaChanged: (value) {
        _selectedFieldForEdit = value;
        _updateField(orderNumber);
      },
    );
  }

  ///
  /// Update call to update the users edit form field with latest details
  ///
  void _updateField(int orderNumber) {
    final page = _selectedPage;
    if (page == null) return;

    //Update field data in schema
    final foundField = _selectedFieldForEdit;

    setState(() {
      _updateSchema(
        _schema.copyWith(
          pages: [
            for (final item in _pages)
              if (item.id == page.id)
                item.copyWith(
                  fields: [
                    for (final field in item.fields)
                      if (field.orderNumber == orderNumber &&
                          foundField != null)
                        foundField.copyWith(
                          title:
                              _selectedFieldForEdit?.title ?? foundField.title,
                          hintText:
                              _selectedFieldForEdit?.hintText ??
                              foundField.hintText,
                        )
                      else
                        field,
                  ],
                )
              else
                item,
          ],
        ),
      );
    });
  }

  void _deleteField(int orderNumber) {
    final page = _selectedPage;
    if (page == null) return;

    final remainingFields = page.fields
        .where((field) => field.orderNumber != orderNumber)
        .toList();

    final reorderedFields = [
      for (var i = 0; i < remainingFields.length; i++)
        remainingFields[i].copyWith(orderNumber: i),
    ];

    _updateSchema(
      _schema.copyWith(
        pages: [
          for (final item in _pages)
            if (item.id == page.id)
              item.copyWith(fields: reorderedFields)
            else
              item,
        ],
      ),
    );
  }

  Future<void> _editFormDetails() async {
    await EditFormNameDialog.show(
      context,
      formName: _createFormRequest.name,
      formDescription: _createFormRequest.description ?? '',
      onFormNameChanged: (value) {
        if (value == null || value.trim().isEmpty) return;

        _updateRequest(_createFormRequest.copyWith(name: value.trim()));
      },
      onFormDescriptionChanged: (value) {
        if (value == null) return;

        _updateRequest(_createFormRequest.copyWith(description: value));
      },
    );
  }

  Future<void> _showRenamePageDialog() async {
    final page = _selectedPage;
    if (page == null) return;

    final controller = TextEditingController(text: page.title);

    final title = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Rename page'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Page title'),
            onSubmitted: (value) {
              Navigator.of(dialogContext).pop(value);
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(controller.text);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    controller.dispose();

    if (title != null) {
      _renameSelectedPage(title);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;

    const wideBreakpoint = 1000.0;

    final wide = MediaQuery.sizeOf(context).width >= wideBreakpoint;
    final statusBarHeight = MediaQuery.paddingOf(context).top;

    if (!_isPositionsInitialized) {
      _floatingFieldsTop = statusBarHeight + 65;
      _floatingFieldsLeft = 20;
      _floatingSettingsTop = statusBarHeight + 65;
      _floatingSettingsLeft = 20;
      _isPositionsInitialized = true;
    }

    return Scaffold(
      drawer: wide
          ? null
          : Drawer(
              width: 240,
              backgroundColor: cs.surface,
              child: SideNav(activePath: '/forms'),
            ),
      floatingActionButton: PopupMenuButton<FormToolbarOptions>(
        tooltip: 'Toolbar',
        offset: const Offset(-50, -50),
        position: PopupMenuPosition.over,
        icon: Icon(Mdi.toolbox),
        iconSize: 28,
        style: IconButton.styleFrom(
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          fixedSize: const Size(56, 56),
          shape: const CircleBorder(),
        ),
        onSelected: (value) {
          switch (value) {
            case FormToolbarOptions.FormFields:
              setState(() {
                _showFloatingFieldsBar = !_showFloatingFieldsBar;
                if (_showFloatingFieldsBar) {
                  _showFloatingSettingsBar = false;
                }
              });
              break;
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: FormToolbarOptions.FormFields,
            child: Row(
              children: [
                Icon(Mdi.formSelect, color: sem.textMuted),
                const SizedBox(width: 8),
                const Text('Form Fields'),
              ],
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TopBar(wide: wide),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.all(wide ? 24 : 16),
                            child: Center(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 1440,
                                ),
                                child: Card(
                                  child: Container(
                                    constraints: BoxConstraints(
                                      minHeight:
                                          MediaQuery.sizeOf(context).height *
                                          0.75,
                                    ),
                                    padding: const EdgeInsets.all(24),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                _createFormRequest.name,
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.titleLarge,
                                              ),
                                            ),
                                            IconButton(
                                              tooltip: 'Edit form details',
                                              onPressed: _editFormDetails,
                                              icon: const Icon(Icons.edit),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          _createFormRequest
                                                      .description
                                                      ?.isNotEmpty ==
                                                  true
                                              ? _createFormRequest.description!
                                              : 'Add a description for your form.',
                                          maxLines: _isExpanded ? null : 2,
                                          overflow: _isExpanded
                                              ? TextOverflow.visible
                                              : TextOverflow.ellipsis,
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                _isExpanded = !_isExpanded;
                                              });
                                            },
                                            child: Text(
                                              _isExpanded
                                                  ? 'Show less'
                                                  : 'Show more',
                                            ),
                                          ),
                                        ),
                                        const Divider(height: 24),
                                        _buildPageSelector(cs),
                                        const SizedBox(height: 20),
                                        _buildPageEditor(cs, sem),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (_showFloatingFieldsBar)
                _buildFieldsFloatingBar(cs, constraints),
              if (_showFloatingSettingsBar)
                _buildSettingsFloatingBar(cs, constraints),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPageSelector(ColorScheme cs) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final page in _pages)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(page.title),
                      selected: page.id == _selectedPageId,
                      onSelected: (_) => _selectPage(page.id),
                    ),
                  ),
              ],
            ),
          ),
        ),
        IconButton(
          tooltip: 'Add page',
          onPressed: _addPage,
          icon: const Icon(Icons.add),
        ),
        IconButton(
          tooltip: 'Rename page',
          onPressed: _showRenamePageDialog,
          icon: const Icon(Icons.edit_outlined),
        ),
        IconButton(
          tooltip: 'Delete selected page',
          onPressed: _pages.length > 1 ? _deleteSelectedPage : null,
          icon: const Icon(Icons.delete_outline),
        ),
      ],
    );
  }

  Widget _buildPageEditor(ColorScheme cs, AppSemanticColors sem) {
    final page = _selectedPage;

    if (page == null) {
      return const Center(child: Text('Select or create a page.'));
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  page.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Text(
                '${page.fields.length} fields',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (page.fields.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: cs.surfaceContainerHighest.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: cs.outlineVariant),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.dynamic_form,
                    size: 36,
                    color: cs.onSurfaceVariant,
                  ),
                  const SizedBox(height: 12),
                  const Text('This page has no fields yet.'),
                  const SizedBox(height: 4),
                  Text(
                    'Open the Form Fields toolbar to add a field.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            )
          else
            for (final field in page.fields)
              Padding(
                key: ValueKey('${page.id}-${field.orderNumber}'),
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: FormFieldWidget(
                        key: ValueKey('${page.id}-${field.orderNumber}'),
                        formFieldSchema: field,
                      ),
                    ),
                    IconButton(
                      tooltip: 'Edit field',
                      onPressed: () => _openEditField(field.orderNumber),
                      icon: Icon(Icons.edit, color: cs.primary),
                    ),
                    IconButton(
                      tooltip: 'Remove field',
                      onPressed: () => _deleteField(field.orderNumber),
                      icon: Icon(Icons.delete_outline, color: cs.error),
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildFieldsFloatingBar(ColorScheme cs, BoxConstraints constraints) {
    final screenSize = MediaQuery.sizeOf(context);

    final width = (screenSize.width * 0.32).clamp(250.0, 380.0);
    final height = (screenSize.height * 0.80).clamp(250.0, 380.0);

    return Positioned(
      top: _floatingFieldsTop.clamp(
        0.0,
        (constraints.maxHeight - height).clamp(0.0, double.infinity),
      ),
      left: _floatingFieldsLeft.clamp(
        0.0,
        (constraints.maxWidth - width).clamp(0.0, double.infinity),
      ),
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _floatingFieldsTop = (_floatingFieldsTop + details.delta.dy).clamp(
              0.0,
              (constraints.maxHeight - height).clamp(0.0, double.infinity),
            );

            _floatingFieldsLeft = (_floatingFieldsLeft + details.delta.dx)
                .clamp(
                  0.0,
                  (constraints.maxWidth - width).clamp(0.0, double.infinity),
                );
          });
        },
        child: SizedBox(
          width: width,
          height: height,
          child: Card(
            elevation: 8,
            color: cs.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.drag_indicator, color: cs.onPrimaryContainer),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Form Fields',
                          style: TextStyle(
                            color: cs.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Close',
                        onPressed: () {
                          setState(() {
                            _showFloatingFieldsBar = false;
                          });
                        },
                        icon: Icon(Icons.close, color: cs.onPrimaryContainer),
                      ),
                    ],
                  ),

                  const Divider(),

                  // Scrollable fields section
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: _formFields
                            .expand(
                              (field) => [
                                ListTile(
                                  dense: true,
                                  leading: Icon(
                                    field.leadingIcon,
                                    color: cs.onPrimaryContainer,
                                  ),
                                  title: Text(
                                    field.title ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: cs.onPrimaryContainer,
                                    ),
                                  ),
                                  subtitle: Text(
                                    field.subtitle ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: cs.onPrimaryContainer,
                                    ),
                                  ),
                                  trailing: Tooltip(
                                    message: field.trailingTooltip ?? '',
                                    child: Icon(
                                      field.trailingIcon,
                                      color: cs.onPrimaryContainer,
                                    ),
                                  ),
                                  onTap: () => _addField(
                                    field.fieldType ?? FormFieldType.Text,
                                  ),
                                ),
                                Divider(
                                  color: cs.onPrimaryContainer.withValues(
                                    alpha: 0.5,
                                  ),
                                ),
                              ],
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsFloatingBar(ColorScheme cs, BoxConstraints constraints) {
    final screenSize = MediaQuery.sizeOf(context);

    final width = (screenSize.width * 0.32).clamp(250.0, 380.0);
    const height = 260.0;

    return Positioned(
      top: _floatingSettingsTop.clamp(
        0.0,
        (constraints.maxHeight - height).clamp(0.0, double.infinity),
      ),
      right: _floatingSettingsLeft.clamp(
        0.0,
        (constraints.maxWidth - width).clamp(0.0, double.infinity),
      ),
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _floatingSettingsTop = (_floatingSettingsTop + details.delta.dy)
                .clamp(
                  0.0,
                  (constraints.maxHeight - height).clamp(0.0, double.infinity),
                );
            _floatingSettingsLeft = (_floatingSettingsLeft + details.delta.dx)
                .clamp(
                  0.0,
                  (constraints.maxWidth - width).clamp(0.0, double.infinity),
                );
          });
        },
        child: SizedBox(
          width: width,
          height: height,
          child: Card(
            elevation: 8,
            color: cs.tertiaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.drag_indicator, color: cs.onTertiaryContainer),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Page Settings',
                          style: TextStyle(
                            color: cs.onTertiaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Close',
                        onPressed: () {
                          setState(() {
                            _showFloatingSettingsBar = false;
                          });
                        },
                        icon: Icon(Icons.close, color: cs.onPrimaryContainer),
                      ),
                    ],
                  ),
                  const Divider(),
                  TextFormField(
                    controller: TextEditingController(
                      text: _selectedFieldForEdit?.title ?? '',
                    ),
                    keyboardType: TextInputType.text,
                    decoration: _buildInputDecoration(
                      label: 'Field Title',
                      cs: cs,
                      hintText: _selectedFieldForEdit?.hintText,
                      prefixIcon: Icons.title,
                    ),
                    onChanged: (value) {
                      _selectedFieldForEdit = _selectedFieldForEdit?.copyWith(
                        title: value,
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _updateField(_selectedOrderNumber ?? 0);
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required ColorScheme cs,
    String? hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
    required String label,
  }) {
    return InputDecoration(
      label: Text(label),
      hintText: hintText,
      hintStyle: TextStyle(
        color: cs.onSurface.withValues(alpha: 0.6),
        fontSize: 14,
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: cs.onSurface.withValues(alpha: 0.6),
        size: 20,
      ),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: cs.inversePrimary.withValues(alpha: 0.05),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: cs.onSurface.withValues(alpha: 0.1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: cs.onSurface.withValues(alpha: 0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: cs.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: cs.error, width: 2),
      ),
    );
  }
}
