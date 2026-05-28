// lib/views/dashboard_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:venue_flow_app/models/dynamic_form_model.dart';
import 'package:venue_flow_app/models/popup_position.dart';
import 'package:venue_flow_app/providers/viewmodel_provider.dart';
import 'package:venue_flow_app/routing/app_routes.dart';
import 'package:venue_flow_app/shared/helpers/global_popup_service.dart';
import 'package:venue_flow_app/views/dialogs/confirm_delete_dialog.dart';
import 'package:venue_flow_app/views/side_nav_widget.dart';
import 'package:venue_flow_app/views/widgets/generic_table_widget.dart';
import '../theme/theme.dart';
import '../theme/spacing.dart';

class FormListPage extends ConsumerStatefulWidget {
  const FormListPage({super.key});

  @override
  ConsumerState<FormListPage> createState() => _FormListPageState();
}

class _FormListPageState extends ConsumerState<FormListPage> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<DynamicFormModel>?> _formsFuture;

  @override
  void initState() {
    super.initState();
    _formsFuture = ref.read(formBuilderViewModelProvider.notifier).loadForms();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _reloadForms() async {
    setState(() {
      _formsFuture = ref.read(formBuilderViewModelProvider.notifier).loadForms();
    });

    await _formsFuture;
  }

  Future<void> _confirmDeleteForm(DynamicFormModel form) async {
    final formId = form.id;
    if (formId == null || formId.isEmpty) {
      GlobalPopupService.showError(
        title: 'Delete failed',
        message: 'This form cannot be deleted because it has no id.',
        position: PopupPosition.bottomRight,
      );
      return;
    }

    final confirmed = await showConfirmDeleteDialog(
      context,
      title: 'Delete Form',
      message:
          'Are you sure you want to delete "${form.name ?? 'this form'}"? This action cannot be undone.',
    );

    if (!confirmed) {
      return;
    }

    try {
      await ref
          .read(formBuilderViewModelProvider.notifier)
          .deleteForm(formId: formId);
      await _reloadForms();

      GlobalPopupService.showSuccess(
        title: 'Form deleted',
        message: '"${form.name ?? 'Form'}" was removed.',
        position: PopupPosition.bottomRight,
      );
    } catch (_) {
      GlobalPopupService.showError(
        title: 'Delete failed',
        message: 'Unable to delete the selected form.',
        position: PopupPosition.bottomRight,
      );
    }
  }

  void _openSearchSheet(
    ColorScheme colorScheme,
    EditorialThemeData editorial,
  ) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: colorScheme.surface,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(22),
              ),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search events, forms, or clients...',
                  hintStyle: editorial.captionStyle,
                  prefixIcon: Icon(
                    Icons.search,
                    size: 18,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: EditorialSpacing.spacing4,
                    vertical: EditorialSpacing.spacing2,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final editorial = context.editorial;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Row(
        children: [
          // Side Navigation
          const SideNavWidget(),
          // Main Content
          Expanded(
            child: Column(
              children: [
                // Top Navigation
                _buildTopNavigation(colorScheme, editorial),
                // Dashboard Content
                Expanded(child: _buildDashboardContent(colorScheme, editorial)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopNavigation(
    ColorScheme colorScheme,
    EditorialThemeData editorial,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTabletOrSmaller =
            constraints.maxWidth < EditorialSpacing.breakpointDesktop;
        final isMobile =
            constraints.maxWidth < EditorialSpacing.breakpointTablet;

        return Container(
          height: 64,
          padding: const EdgeInsets.symmetric(
            horizontal: EditorialSpacing.spacing6,
          ),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border(
              bottom: BorderSide(
                color: colorScheme.outline.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              if (!isMobile)
                Flexible(
                  flex: 6,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search events, forms, or clients...',
                            hintStyle: editorial.captionStyle,
                            prefixIcon: Icon(
                              Icons.search,
                              size: 18,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: EditorialSpacing.spacing4,
                              vertical: EditorialSpacing.spacing2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              if (!isMobile) const SizedBox(width: EditorialSpacing.spacing4),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (isMobile)
                      IconButton(
                        tooltip: 'Search',
                        onPressed: () => _openSearchSheet(colorScheme, editorial),
                        icon: Icon(
                          Icons.search,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    Stack(
                      children: [
                        IconButton(
                          tooltip: 'Notifications',
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications_outlined,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: colorScheme.error,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: colorScheme.surface,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: EditorialSpacing.spacing2),
                    if (!isTabletOrSmaller)
                      Container(
                        width: 1,
                        height: 32,
                        color: colorScheme.outline.withValues(alpha: 0.2),
                      ),
                    if (!isTabletOrSmaller)
                      const SizedBox(width: EditorialSpacing.spacing4),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.primary.withValues(alpha: 0.1),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 16,
                        color: colorScheme.primary,
                      ),
                    ),
                    if (!isTabletOrSmaller) ...[
                      const SizedBox(width: EditorialSpacing.spacing2),
                      Text(
                        'Alex Rivera',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDashboardContent(
    ColorScheme colorScheme,
    EditorialThemeData editorial,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      padding: EdgeInsets.all(
        EditorialResponsiveSpacing.edgeSpacing(screenWidth),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow =
                  constraints.maxWidth < EditorialSpacing.breakpointTablet;

              final titleBlock = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Forms',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Welcome back, Alex. You have 4 forms awaiting review.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              );

              final createButton = OutlinedButton.icon(
                onPressed: () {
                  context.pushNamed(AppRouteNames.formBuilder);
                },
                icon: const Icon(Icons.description_outlined, size: 18),
                label: const Text('Create Form'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colorScheme.onSecondaryContainer,
                  side: BorderSide(
                    color: colorScheme.outline.withValues(alpha: 0.1),
                  ),
                ),
              );

              final refreshButton = IconButton(
                tooltip: 'Refresh forms',
                onPressed: _reloadForms,
                icon: const Icon(Icons.refresh),
              );

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleBlock,
                    const SizedBox(height: EditorialSpacing.spacing4),
                    Row(
                      children: [
                        Expanded(child: createButton),
                        const SizedBox(width: EditorialSpacing.spacing2),
                        refreshButton,
                      ],
                    ),
                  ],
                );
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: titleBlock),
                  const SizedBox(width: EditorialSpacing.spacing4),
                  refreshButton,
                  createButton,
                ],
              );
            },
          ),
          _buildActiveEventsSection(colorScheme, editorial),
        ],
      ),
    );
  }

  Widget _buildActiveEventsSection(
    ColorScheme colorScheme,
    EditorialThemeData editorial,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: EditorialSpacing.spacing6),
        FutureBuilder(
          future: _formsFuture,
          builder: (context, snapshot) {
            final results = snapshot.data;

            return GenericDataTable(
              columns: [
                GenericTableColumn(
                  header: 'Form Name',
                  cellBuilder: (context, row) {
                    row as DynamicFormModel;
                    return Text(row.name ?? 'UNKNOWN');
                  },
                ),
                GenericTableColumn(
                  header: 'Version',
                  cellBuilder: (context, row) {
                    row as DynamicFormModel;
                    return Text(row.version?.toString() ?? 'UNKNOWN');
                  },
                ),
                GenericTableColumn(
                  header: 'Last Modified',
                  cellBuilder: (context, row) {
                    row as DynamicFormModel;
                    final formattedDate =
                        row.modifiedDate != null
                            ? DateFormat('yyyy-MM-dd').format(row.modifiedDate!)
                            : 'UNKNOWN';

                    return Text(formattedDate);
                  },
                ),
                GenericTableColumn(
                  header: 'Status',
                  cellBuilder: (context, row) {
                    row as DynamicFormModel;
                    final status =
                        row.formStatus?.name.toUpperCase() ?? 'UNKNOWN';
                    return Text(status);
                  },
                ),
                GenericTableColumn(
                  header: '',
                  flex: 0,
                  cellBuilder: (context, row) {
                    row as DynamicFormModel;
                    return Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        tooltip: 'Delete form',
                        onPressed: () => _confirmDeleteForm(row),
                        icon: Icon(
                          Icons.delete_outline,
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    );
                  },
                ),
              ],
              rows: results ?? [],
              isLoading: snapshot.connectionState == ConnectionState.waiting,
              onRowTap: (row) {
                row as DynamicFormModel;
                context.pushNamed(
                  AppRouteNames.formBuilder,
                  extra: {'formModel': row},
                  queryParameters: {'id': row.id ?? ''},
                );
              },
              emptyMessage:
                  'No forms found. Click "Create Form" to get started.',
            );
          },
        ),
      ],
    );
  }
}
