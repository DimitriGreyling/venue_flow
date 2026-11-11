import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:venue_flow_app/features/form/data/form_controller.dart';

import '../../../../../core/domain/paged_response.dart';
import '../../../../../core/theme/theme_x.dart';
import '../../../../../core/widgets/side_nav.dart';
import '../../../../../core/widgets/top_bar.dart';
import '../../../domain/form_list_id.dart';
import '../../form_data_table.dart';

class TableMobileView extends ConsumerStatefulWidget {
  const TableMobileView({super.key});

  @override
  ConsumerState<TableMobileView> createState() => _TableMobileViewState();
}

class _TableMobileViewState extends ConsumerState<TableMobileView> {
  bool isLoading = true;
  PagedResponse<FormListId> forms = PagedResponse(
    items: [],
    totalCount: 0,
    page: 1,
    pageSize: 1,
    totalPages: 1,
  );

  int pageNumber = 1;

  List<DataColumn> columns = [
    DataColumn(label: Text('Name')),
    DataColumn(label: Text('Description')),
    DataColumn(label: Text('Type')),
    DataColumn(label: Text('')),
  ];

  @override
  void initState() {
    super.initState();
    _fetchForms();
  }

  Future<void> _fetchForms() async {
    final repository = ref.watch(formControllerProvider.notifier);
    forms = await repository.getForms(page: pageNumber, pageSize: 10);

    setState(() {
      isLoading = false; // Turn off loading when data arrives
    });
  }

  Future<void> _refresh() async {
    ref.invalidate(formControllerProvider);
    ref.invalidate(formDetailsProvider);
    await _fetchForms();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;
    const _wideBreakpoint = 1000.0;
    final wide = MediaQuery.of(context).size.width >= _wideBreakpoint;

    return Scaffold(
      drawer: Drawer(
        width: 240,
        backgroundColor: cs.surface,
        child: SideNav(activePath: '/forms'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              TopBar(wide: wide),
              Padding(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(50),
                      child: CircleAvatar(
                        backgroundColor: cs.primary,
                        child: IconButton(
                          tooltip: 'Add form',
                          onPressed: () async {
                            context.push('/forms/add');
                          },
                          icon: Icon(Mdi.filePlus,color: cs.onPrimary,),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(50),
                      child: CircleAvatar(
                        backgroundColor: cs.tertiary,
                        child: IconButton(
                          onPressed: () {
                            _refresh();
                          },
                          tooltip: 'Refresh table',
                          icon: Icon(Mdi.refresh,color: cs.onTertiary,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: LayoutBuilder(
                    builder: (context, tableConstraints) {
                      return FormDataTable(
                        columns: columns,
                        forms: forms,
                        constraints: tableConstraints,
                        isLoading: isLoading,
                        requiresRefresh: (value) {
                          _refresh();
                        },
                        onPageChanged: (page) {
                          pageNumber = page;
                          _fetchForms();
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
