import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:venue_flow_app/core/domain/icon_feature.dart';

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
import 'package:venue_flow_app/features/form/domain/form_version.dart';

import 'package:venue_flow_app/features/form/presentation/dialogs/edit_form_field_dialog.dart';
import 'package:venue_flow_app/features/form/presentation/dialogs/edit_form_name_dialog.dart';
import 'package:venue_flow_app/features/form/presentation/widgets/form_field_widget.dart';

import '../../data/form_controller.dart';

class FormTabletView extends ConsumerStatefulWidget {
  const FormTabletView({
    super.key,
    this.selectedFormVersion,
    this.formId,
    this.latestVersion,
    this.refreshUI,
  });

  final FormVersion? selectedFormVersion;
  final int? latestVersion;
  final String? formId;
  final ValueChanged<void>? refreshUI;

  @override
  ConsumerState<FormTabletView> createState() => _FormTabletViewState();
}

class _FormTabletViewState extends ConsumerState<FormTabletView> {
  final Uuid _uuid = const Uuid();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const String _draftStorageKey = 'venue_flow_form_builder_draft_v1';

  Timer? _draftSaveTimer;

  bool _isRestoringDraft = false;

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
      leadingIcon: IconFeature(
        name: 'Text Fields',
        fontFamily: Icons.text_fields.fontFamily,
        codePoint: Icons.text_fields.codePoint,
        icon: 'text_fields',
        iconType: 'MaterialIcons',
      ),
      title: 'Text Field',
      subtitle: 'Single-line text input',
      trailingIcon: IconFeature(
        name: 'Add',
        codePoint: Icons.add.codePoint,
        fontFamily: Icons.add.fontFamily,
        icon: 'add',
        iconType: 'MaterialIcons',
      ),
      trailingTooltip: 'Add text field',
    ),
    FormFieldData(
      fieldType: FormFieldType.TextArea,
      leadingIcon: IconFeature(
        name: 'Text Fields',
        fontFamily: Icons.text_fields.fontFamily,
        codePoint: Icons.text_fields.codePoint,
        icon: 'text_fields',
        iconType: 'MaterialIcons',
      ),
      title: 'Text Area Field',
      subtitle: 'Multi-line text input',
      trailingIcon: IconFeature(
        name: 'Add',
        codePoint: Icons.add.codePoint,
        fontFamily: Icons.add.fontFamily,
        icon: 'add',
        iconType: 'MaterialIcons',
      ),
      trailingTooltip: 'Add text area field',
    ),
    FormFieldData(
      fieldType: FormFieldType.DatePicker,
      leadingIcon: IconFeature(
        name: 'Date Range',
        codePoint: Icons.date_range.codePoint,
        fontFamily: Icons.date_range.fontFamily,
        icon: 'date_range',
        iconType: 'MaterialIcons',
      ),
      title: 'Date Picker Field',
      subtitle: 'Select a date',
      trailingIcon: IconFeature(
        name: 'Add',
        codePoint: Icons.add.codePoint,
        fontFamily: Icons.add.fontFamily,
        icon: 'add',
        iconType: 'MaterialIcons',
      ),
      trailingTooltip: 'Add date picker field',
    ),
    FormFieldData(
      fieldType: FormFieldType.IntField,
      leadingIcon: IconFeature(
        name: 'Numbers',
        codePoint: Icons.numbers.codePoint,
        fontFamily: Icons.numbers.fontFamily,
        icon: 'numbers',
        iconType: 'MaterialIcons',
      ),
      title: 'Int Field',
      subtitle: 'Enter an integer',
      trailingIcon: IconFeature(
        name: 'Add',
        codePoint: Icons.add.codePoint,
        fontFamily: Icons.add.fontFamily,
        icon: 'add',
        iconType: 'MaterialIcons',
      ),
      trailingTooltip: 'Add number field',
    ),
  ];

  @override
  void initState() {
    super.initState();

    // Check that the list is NOT null AND contains at least one item
    if (widget.selectedFormVersion != null) {
      // Safely extract the string, ensuring it isn't empty or blank
      final rawJson = widget.selectedFormVersion!.schemaJson;

      if (rawJson != null && rawJson.trim().isNotEmpty) {
        try {
          final schemaObject = FormSchema.fromJson(jsonDecode(rawJson));

          setState(() {
            _createFormRequest = _createFormRequest.copyWith(
              schema: schemaObject,
            );
          });
          _updateRequest(_createFormRequest);
        } catch (e) {
          // If parsing fails, fall back to restoring draft
          _restoreDraft();
        }
      } else {
        _restoreDraft();
      }
    } else {
      // If formVersions is null or completely empty, safely restore the draft
      _restoreDraft();
    }
  }

  Future<void> _restoreDraft() async {
    _isRestoringDraft = true;

    try {
      final prefs = await SharedPreferences.getInstance();
      final savedDraft = prefs.getString(_draftStorageKey);

      if (savedDraft != null && savedDraft.isNotEmpty) {
        final Map<String, dynamic> data =
            jsonDecode(savedDraft) as Map<String, dynamic>;

        if (data.containsKey('request') && data['request'] is Map) {
          final requestJson = Map<String, dynamic>.from(data['request'] as Map);
          final restoredRequest = CreateFormRequest.fromJson(requestJson);

          // Safely extract pages and guarantee it's not empty before picking a fallback
          final pages = restoredRequest.schema?.pages ?? [];
          final savedPageId = data['selectedPageId'] as String?;

          final selectedPageExists =
              savedPageId != null &&
              pages.any((page) => page.id == savedPageId);

          if (mounted) {
            setState(() {
              _createFormRequest = restoredRequest;

              if (selectedPageExists) {
                _selectedPageId = savedPageId;
              } else if (pages.isNotEmpty) {
                // Hardened Guard: Double check the list actually has items before calling .first
                _selectedPageId = pages.first.id;
              } else {
                // Fallback: Default to empty string or null if no pages exist yet
                _selectedPageId = '';
              }
            });
          }
        }
      }

      // Wrap initialization in a try-catch or safe condition check
      // to prevent it from crashing the entire draft restoration loop
      if (_createFormRequest.schema?.pages.isNotEmpty ?? false) {
        try {
          _initializeFieldIds();
        } catch (e) {
          debugPrint('Warning: _initializeFieldIds encountered an error: $e');
          // Fallback or safe initialization method if needed
        }
      }

      _isRestoringDraft = false;

      // Save the restored state safely
      _scheduleDraftSave();
    } catch (e, stackTrace) {
      debugPrint('Failed to restore form draft: $e');
      debugPrintStack(stackTrace: stackTrace);

      _isRestoringDraft = false;

      // Hardened Guard: Only initialize if the current state can support it safely
      if (_createFormRequest.schema?.pages.isNotEmpty ?? false) {
        _initializeFieldIds();
      }
    }
  }

  void _scheduleDraftSave() {
    if (_isRestoringDraft) return;

    _draftSaveTimer?.cancel();

    _draftSaveTimer = Timer(const Duration(milliseconds: 50), _saveDraft);
  }

  Future<void> _updateDraft() async {
    if (_isRestoringDraft) return;

    try {
      final prefs = await SharedPreferences.getInstance();

      final formController = ref.read(formControllerProvider.notifier);

      await formController.addNewFormVersion(
        formId: widget.formId ?? '',
        formVersion: FormVersion(
          id: widget.formId ?? '',
          formDefinitionId: widget.selectedFormVersion?.formDefinitionId ?? '',
          createdAt: DateTime.now(),
          reviewedAt: DateTime.now(),
          schemaJson: jsonEncode(_createFormRequest.schema?.toJson()),
          status: 'DRAFT',
          submittedAt: DateTime.now(),
          updatedAt: DateTime.now(),
          versionNumber: widget.latestVersion != null
              ? widget.latestVersion! + 1
              : 1,
        ),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Form version created successfully!')),
        );
      }

      if (widget.refreshUI != null) {
        widget.refreshUI?.call(true);
      }
    } catch (e, stackTrace) {
      debugPrint('Failed to save form draft: $e');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<void> _saveDraft() async {
    if (_isRestoringDraft) return;

    try {
      final prefs = await SharedPreferences.getInstance();

      final draft = {
        'request': _createFormRequest.toJson(),
        'selectedPageId': _selectedPageId,
      };

      await prefs.setString(_draftStorageKey, jsonEncode(draft));

      debugPrint('Form draft autosaved.');
    } catch (e, stackTrace) {
      debugPrint('Failed to save form draft: $e');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<void> _clearDraft() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_draftStorageKey);
  }

  Future<void> _createForm() async {
    if (widget.selectedFormVersion != null) {
      await _updateDraft();
      return;
    }

    final formController = ref.read(formControllerProvider.notifier);

    try {
      await formController.createForm(request: _createFormRequest);

      // Clear the draft after successful creation.
      await _clearDraft();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Form created successfully!')),
        );
      }
    } catch (e) {
      debugPrint('Failed to create form: $e');

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Failed to create form.')));
      }
    }
  }

  @override
  void dispose() {
    _draftSaveTimer?.cancel();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // SCHEMA HELPERS
  // ---------------------------------------------------------------------------

  FormSchema get _schema => _createFormRequest.schema ?? const FormSchema();

  List<FormPageSchema> get _pages {
    final pages = [..._schema.pages];

    pages.sort((a, b) => a.orderNumber.compareTo(b.orderNumber));

    return pages;
  }

  FormPageSchema? get _selectedPage {
    for (final page in _pages) {
      if (page.id == _selectedPageId) {
        return page;
      }
    }

    return null;
  }

  List<FormFieldSchema> _sortedFields(FormPageSchema page) {
    final fields = [...page.fields];

    fields.sort((a, b) => a.orderNumber.compareTo(b.orderNumber));

    return fields;
  }

  void _initializeFieldIds() {
    final schema = _schema;

    final updatedPages = [
      for (final page in schema.pages)
        page.copyWith(
          fields: [
            for (final field in page.fields)
              field.copyWith(id: field.id.isEmpty ? _uuid.v4() : field.id),
          ],
        ),
    ];

    _createFormRequest = _createFormRequest.copyWith(
      schema: schema.copyWith(pages: updatedPages),
    );
  }

  void _updateRequest(CreateFormRequest request) {
    setState(() {
      _createFormRequest = request;
    });
    _scheduleDraftSave();
  }

  void _updateSchema(FormSchema schema) {
    _updateRequest(_createFormRequest.copyWith(schema: schema));
  }

  // ---------------------------------------------------------------------------
  // PAGE MANAGEMENT
  // ---------------------------------------------------------------------------

  void _selectPage(String pageId) {
    if (pageId == _selectedPageId) return;

    setState(() {
      _selectedPageId = pageId;
      _selectedFieldForEdit = null;
      _selectedOrderNumber = null;
    });

    _scheduleDraftSave();
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

    _scheduleDraftSave();
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
      _selectedFieldForEdit = null;
      _selectedOrderNumber = null;
    });
  }

  Future<void> _showRenamePageDialog({required ColorScheme cs}) async {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              // Aligns both buttons cleanly to the right side
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      // Removes solid background
                      shadowColor: Colors.transparent,
                      // Removes shadow elevation
                      side: BorderSide(color: cs.error, width: 1.5),
                      // Adds outline
                      foregroundColor: cs.onError, // Text colour
                    ),
                    child: Text('Cancel', style: TextStyle(color: cs.error)),
                  ),
                ),
                const SizedBox(width: 12),
                // Adds a fixed horizontal gap between the two buttons
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop(controller.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      // Removes solid background
                      shadowColor: Colors.transparent,
                      // Removes shadow elevation
                      side: BorderSide(color: cs.secondary, width: 1.5),
                      // Adds outline
                      foregroundColor: cs.onSecondary, // Text colour
                    ),
                    child: Text('Save', style: TextStyle(color: cs.secondary)),
                  ),
                ),
              ],
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

  // ---------------------------------------------------------------------------
  // FIELD MANAGEMENT
  // ---------------------------------------------------------------------------

  void _addField(FormFieldType fieldType) {
    final page = _selectedPage;
    if (page == null) return;

    final fields = _sortedFields(page);

    final newField = FormFieldSchema(
      id: _uuid.v4(),
      fieldType: fieldType,
      title: _defaultFieldTitle(fieldType),
      hintText: _defaultFieldHint(fieldType),
      orderNumber: fields.length,
    );

    _updateSchema(
      _schema.copyWith(
        pages: [
          for (final item in _pages)
            if (item.id == page.id)
              item.copyWith(fields: [...fields, newField])
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

      case FormFieldType.TextArea:
        return 'Text area';

      case FormFieldType.DatePicker:
        return 'Date picker';

      case FormFieldType.IntField:
        return 'Number field';

      default:
        return 'New field';
    }
  }

  String _defaultFieldHint(FormFieldType type) {
    switch (type) {
      case FormFieldType.Text:
        return 'Enter your answer';

      case FormFieldType.TextArea:
        return 'Enter your answer';

      case FormFieldType.DatePicker:
        return 'Select a date';

      case FormFieldType.IntField:
        return 'Enter a number';

      default:
        return '';
    }
  }

  /// Reorders fields on the currently selected page.
  void _reorderFields(int oldIndex, int newIndex) {
    final page = _selectedPage;
    if (page == null) return;

    final fields = _sortedFields(page);

    if (oldIndex < 0 || oldIndex >= fields.length) return;

    // ReorderableListView provides the destination index
    // before removal when moving down.
    if (newIndex > oldIndex) {
      newIndex--;
    }

    if (newIndex < 0 || newIndex >= fields.length) return;

    // Remove the selected field.
    final movedField = fields.removeAt(oldIndex);

    // Insert it at the new position.
    fields.insert(newIndex, movedField);

    // Update all order numbers.
    final reorderedFields = [
      for (var i = 0; i < fields.length; i++)
        fields[i].copyWith(orderNumber: i),
    ];

    // Update the schema.
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

  void _deleteField(int orderNumber) {
    final page = _selectedPage;
    if (page == null) return;

    final remainingFields = _sortedFields(
      page,
    ).where((field) => field.orderNumber != orderNumber).toList();

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

  // ---------------------------------------------------------------------------
  // FIELD EDITING
  // ---------------------------------------------------------------------------

  Future<void> _openEditField(int orderNumber) async {
    final page = _selectedPage;
    if (page == null) return;

    final field = page.fields.firstWhere(
      (field) => field.orderNumber == orderNumber,
    );

    setState(() {
      _selectedOrderNumber = orderNumber;
      _selectedFieldForEdit = field;
    });

    await EditFormFieldDialog.show(
      context,
      formFieldSchema: field,
      onFormFieldSchemaChanged: (value) {
        if (value == null) return;

        _selectedFieldForEdit = value;
        _updateField(orderNumber);
      },
    );
  }

  void _updateField(int orderNumber) {
    final page = _selectedPage;
    final updatedField = _selectedFieldForEdit;

    if (page == null || updatedField == null) return;

    final updatedFields = [
      for (final field in page.fields)
        if (field.id == updatedField.id)
          updatedField.copyWith(orderNumber: field.orderNumber)
        else
          field,
    ];

    _updateSchema(
      _schema.copyWith(
        pages: [
          for (final item in _pages)
            if (item.id == page.id)
              item.copyWith(fields: updatedFields)
            else
              item,
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // FORM DETAILS
  // ---------------------------------------------------------------------------

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

  ///
  /// Reset form to base once method is executed , also cleared shared preferences
  ///
  void _resetForm() {
    setState(() {
      _createFormRequest = CreateFormRequest(
        name: 'Form Name',
        description: '',
        schema: const FormSchema(
          pages: [
            FormPageSchema(id: 'page-1', title: 'Page 1', orderNumber: 0),
          ],
        ),
      );

      // Clear shared preferences
      _clearDraft();
    });
  }

  // ---------------------------------------------------------------------------
  // MAIN BUILD
  // ---------------------------------------------------------------------------

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
        onSelected: (value) async {
          switch (value) {
            case FormToolbarOptions.FormFields:
              setState(() {
                _showFloatingFieldsBar = !_showFloatingFieldsBar;

                if (_showFloatingFieldsBar) {
                  _showFloatingSettingsBar = false;
                }
              });
              break;
            case FormToolbarOptions.Reset:
              await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Reset Form'),
                  icon: Icon(Icons.refresh),
                  content: Text('Are you sure you want to reset the form?'),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: cs.onError),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cs.error,
                        textStyle: TextStyle(color: cs.onError),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _resetForm();
                        // Add your reset logic here
                        Navigator.of(context).pop();
                      },
                      child: Text('Reset', style: TextStyle(color: cs.onError)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cs.primary,
                        textStyle: TextStyle(color: cs.onPrimary),
                      ),
                    ),
                  ],
                ),
              );
              break;
            case FormToolbarOptions.Save:
              await _createForm();
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
          PopupMenuItem(
            value: FormToolbarOptions.Reset,
            child: Container(
              // color: cs.error,
              width: double.infinity,
              // 3. Make it stretch horizontally
              height: kMinInteractiveDimension,
              // 4. Matches standard menu item height
              child: Row(
                children: [
                  Icon(Mdi.restart, color: cs.error),
                  const SizedBox(width: 8),
                  Text('Reset', style: TextStyle(color: cs.error)),
                ],
              ),
            ),
          ),
          PopupMenuItem(
            value: FormToolbarOptions.Save,
            child: Container(
              // color: cs.primary,
              width: double.infinity,
              // 3. Make it stretch horizontally
              height: kMinInteractiveDimension,
              // 4. Matches standard menu item height
              child: Row(
                children: [
                  Icon(Mdi.contentSave, color: cs.primary),
                  const SizedBox(width: 8),
                  Text('Save', style: TextStyle(color: cs.primary)),
                ],
              ),
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
                                        // Form name
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
                                              icon: Icon(
                                                Icons.edit,
                                                color: cs.secondary,
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 8),

                                        // Form description
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

  // ---------------------------------------------------------------------------
  // PAGE SELECTOR
  // ---------------------------------------------------------------------------

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
                      color: page.id == _selectedPageId
                          ? WidgetStateProperty.all(cs.primary)
                          : WidgetStateProperty.all(cs.primaryContainer),
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
          icon: Icon(Icons.add, color: cs.primary),
        ),

        IconButton(
          tooltip: 'Rename page',
          onPressed: () {
            _showRenamePageDialog(cs: cs);
          },
          icon: Icon(Icons.edit_outlined, color: cs.secondary),
        ),

        IconButton(
          tooltip: 'Delete selected page',
          onPressed: _pages.length > 1 ? _deleteSelectedPage : null,
          icon: Icon(Icons.delete_outline, color: cs.error),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // PAGE EDITOR WITH DRAG AND DROP
  // ---------------------------------------------------------------------------

  Widget _buildPageEditor(ColorScheme cs, AppSemanticColors sem) {
    final page = _selectedPage;

    if (page == null) {
      return const Center(child: Text('Select or create a page.'));
    }

    final fields = _sortedFields(page);

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
                '${fields.length} fields',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),

          const SizedBox(height: 16),

          if (fields.isEmpty)
            _buildEmptyFieldsState(cs)
          else
            ReorderableListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              buildDefaultDragHandles: false,
              itemCount: fields.length,
              onReorder: _reorderFields,

              itemBuilder: (context, index) {
                final field = fields[index];

                return Padding(
                  key: ValueKey(field.id),
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Drag handle
                      ReorderableDragStartListener(
                        index: index,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 12,
                          ),
                          child: Tooltip(
                            message: 'Drag to reorder',
                            child: Icon(
                              Icons.drag_indicator,
                              color: cs.onSurfaceVariant.withValues(alpha: 0.5),
                              size: 24,
                            ),
                          ),
                        ),
                      ),

                      // Form field
                      Expanded(
                        child: FormFieldWidget(
                          key: ValueKey('${field.id}-widget'),
                          formFieldSchema: field,
                        ),
                      ),

                      // Edit
                      IconButton(
                        tooltip: 'Edit field',
                        onPressed: () {
                          _openEditField(field.orderNumber);
                        },
                        icon: Icon(Icons.edit, color: cs.secondary),
                      ),

                      // Delete
                      IconButton(
                        tooltip: 'Remove field',
                        onPressed: () {
                          _deleteField(field.orderNumber);
                        },
                        icon: Icon(Icons.delete, color: cs.error),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyFieldsState(ColorScheme cs) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        children: [
          Icon(Icons.dynamic_form, size: 36, color: cs.onSurfaceVariant),
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
    );
  }

  // ---------------------------------------------------------------------------
  // FLOATING FORM FIELDS TOOLBAR
  // ---------------------------------------------------------------------------

  Widget _buildFieldsFloatingBar(ColorScheme cs, BoxConstraints constraints) {
    final screenSize = MediaQuery.sizeOf(context);

    final width = (screenSize.width * 0.32).clamp(250.0, 380.0);

    final height = (screenSize.height * 0.80).clamp(250.0, 380.0);

    final maxTop = (constraints.maxHeight - height).clamp(0.0, double.infinity);

    final maxLeft = (constraints.maxWidth - width).clamp(0.0, double.infinity);

    return Positioned(
      top: _floatingFieldsTop.clamp(0.0, maxTop),
      left: _floatingFieldsLeft.clamp(0.0, maxLeft),

      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _floatingFieldsTop = (_floatingFieldsTop + details.delta.dy).clamp(
              0.0,
              maxTop,
            );

            _floatingFieldsLeft = (_floatingFieldsLeft + details.delta.dx)
                .clamp(0.0, maxLeft);
          });
        },

        child: SizedBox(
          width: width,
          height: height,
          child: Card(
            elevation: 8,
            color: cs.secondaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.drag_indicator,
                        color: cs.onSurface.withValues(alpha: 0.6),
                      ),
                      const SizedBox(width: 8),

                      Expanded(
                        child: Text(
                          'Form Fields',
                          style: TextStyle(
                            color: cs.onSurface,
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
                        icon: Icon(Icons.close, color: cs.error),
                      ),
                    ],
                  ),

                  const Divider(),

                  // Scrollable field selection
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: _formFields.expand((field) {
                          return [
                            ListTile(
                              dense: true,

                              leading: Text(
                                String.fromCharCode(
                                  field.leadingIcon?.codePoint ?? 0,
                                ),
                                style: TextStyle(
                                  fontFamily: field.leadingIcon?.fontFamily,
                                  color: cs.onSurface.withValues(alpha: 0.5),
                                  fontSize: 20
                                ),
                              ),

                              title: Text(
                                field.title ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: cs.onSurface,
                                ),
                              ),

                              subtitle: Text(
                                field.subtitle ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: cs.onSurface.withValues(alpha: 0.5),
                                ),
                              ),

                              trailing: Tooltip(
                                message: field.trailingTooltip ?? '',
                                child: Text(
                                  String.fromCharCode(
                                    field.trailingIcon?.codePoint ?? 0,
                                  ),
                                  style: TextStyle(
                                    fontFamily: field.trailingIcon?.fontFamily,
                                    color: cs.secondary,
                                      fontSize: 25
                                  ),
                                ),
                              ),

                              onTap: () {
                                _addField(
                                  field.fieldType ?? FormFieldType.Text,
                                );
                              },
                            ),

                            Divider(color: cs.onSurface.withValues(alpha: 0.3)),
                          ];
                        }).toList(),
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

  // ---------------------------------------------------------------------------
  // FLOATING PAGE SETTINGS TOOLBAR
  // ---------------------------------------------------------------------------

  Widget _buildSettingsFloatingBar(ColorScheme cs, BoxConstraints constraints) {
    final screenSize = MediaQuery.sizeOf(context);

    final width = (screenSize.width * 0.32).clamp(250.0, 380.0);

    const height = 260.0;

    final maxTop = (constraints.maxHeight - height).clamp(0.0, double.infinity);

    final maxLeft = (constraints.maxWidth - width).clamp(0.0, double.infinity);

    return Positioned(
      top: _floatingSettingsTop.clamp(0.0, maxTop),
      right: _floatingSettingsLeft.clamp(0.0, maxLeft),

      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _floatingSettingsTop = (_floatingSettingsTop + details.delta.dy)
                .clamp(0.0, maxTop);

            _floatingSettingsLeft = (_floatingSettingsLeft + details.delta.dx)
                .clamp(0.0, maxLeft);
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
                        icon: Icon(Icons.close, color: cs.onTertiaryContainer),
                      ),
                    ],
                  ),

                  const Divider(),

                  TextFormField(
                    key: ValueKey(_selectedFieldForEdit?.id),
                    initialValue: _selectedFieldForEdit?.title ?? '',
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

                  const SizedBox(height: 12),

                  ElevatedButton(
                    onPressed: _selectedOrderNumber == null
                        ? null
                        : () {
                            _updateField(_selectedOrderNumber!);
                          },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // INPUT DECORATION
  // ---------------------------------------------------------------------------

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
