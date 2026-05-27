// lib/views/dashboard_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:venue_flow_app/models/dynamic_form_model.dart';
import 'package:venue_flow_app/models/enums.dart';
import 'package:venue_flow_app/models/event_model.dart';
import 'package:venue_flow_app/providers/viewmodel_provider.dart';
import 'package:venue_flow_app/routing/app_routes.dart';
import 'package:venue_flow_app/views/side_nav_widget.dart';
import 'package:venue_flow_app/views/widgets/generic_table_widget.dart';
import '../theme/theme.dart';
import '../theme/spacing.dart';
import '../theme/elevation.dart';

class FormListPage extends ConsumerStatefulWidget {
  const FormListPage({super.key});

  @override
  ConsumerState<FormListPage> createState() => _FormListPageState();
}

class _FormListPageState extends ConsumerState<FormListPage> {
  String _selectedNavItem = 'Dashboard';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(
        horizontal: EditorialSpacing.spacing8,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Search Bar
          Container(
            width: 320,
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

          const SizedBox(width: EditorialSpacing.spacing8),

          const Spacer(),

          // Right Section
          Row(
            children: [
              // Notifications
              Stack(
                children: [
                  IconButton(
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

              const SizedBox(width: EditorialSpacing.spacing4),

              // Divider
              Container(
                width: 1,
                height: 32,
                color: colorScheme.outline.withOpacity(0.2),
              ),

              const SizedBox(width: EditorialSpacing.spacing4),

              // Profile Section
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorScheme.primary.withOpacity(0.1),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 16,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: EditorialSpacing.spacing2),
                  Text(
                    'Alex Rivera',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(FormStatus formStatus) {
    switch (formStatus) {
      case FormStatus.draft:
        return Theme.of(context).colorScheme.primary;
      default:
        return Theme.of(context).colorScheme.inversePrimary;
    }
  }

  Widget _buildFormRow({
    required DynamicFormModel formModel,
    required ColorScheme colorScheme,
    required EditorialThemeData editorial,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.pushNamed(
              AppRouteNames.formBuilder,
              extra: {'formModel': formModel},
              queryParameters: {'id': formModel.id},
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(EditorialSpacing.spacing6),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.format_align_center,
                          size: 20,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: EditorialSpacing.spacing3),
                      Text(
                        formModel.name ?? '',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                // Expanded(
                //   flex: 2,
                //   child: Text(
                //     '',
                //     // event['client'] as String,
                //     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                //           color: colorScheme.onSurfaceVariant,
                //         ),
                //   ),
                // ),
                Expanded(
                  child: Text(
                    formModel.createdAt != null
                        ? DateFormat(
                          'yyyy-MM-dd',
                        ).format(formModel.modifiedDate!)
                        : '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: EditorialSpacing.spacing3,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: (_getStatusColor(
                        formModel.formStatus ?? FormStatus.draft,
                      )).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      formModel.formStatus?.name.toUpperCase() ?? '',
                      style: editorial.metadataStyle.copyWith(
                        color: _getStatusColor(
                          formModel.formStatus ?? FormStatus.draft,
                        ),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_vert,
                      color: colorScheme.onSurfaceVariant,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardContent(
    ColorScheme colorScheme,
    EditorialThemeData editorial,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(EditorialSpacing.spacing8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
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
              ),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      context.pushNamed(AppRouteNames.formBuilder);
                    },
                    icon: const Icon(Icons.description_outlined, size: 18),
                    label: const Text('Create Form'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colorScheme.onSecondaryContainer,
                      side: BorderSide(
                        color: colorScheme.outline.withOpacity(0.1),
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
          future: ref.watch(formBuilderViewModelProvider.notifier).loadForms(),
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
              ],
              rows: results ?? [],
              isLoading: snapshot.connectionState == ConnectionState.waiting,
            );
          },
        ),
      ],
    );
  }
}
