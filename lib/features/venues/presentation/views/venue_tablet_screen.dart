import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/core/widgets/top_bar.dart';
import 'package:venue_flow_app/features/venues/data/venues_controller.dart';
import 'package:venue_flow_app/features/venues/domain/venue_id_response.dart';
import 'package:venue_flow_app/features/venues/presentation/venue_data_table.dart';
import '../../../../core/domain/paged_response.dart';
import '../../../../core/theme/theme_x.dart';
import '../../../../core/widgets/side_nav.dart';

class VenueTabletScreen extends ConsumerStatefulWidget {
  const VenueTabletScreen({super.key});

  @override
  ConsumerState<VenueTabletScreen> createState() => _VenueTabletScreenState();
}

class _VenueTabletScreenState extends ConsumerState<VenueTabletScreen> {
  bool isLoading = true;
  PagedResponse<VenueIdResponse> venues = PagedResponse(
    items: [],
    totalCount: 0,
    page: 1,
    pageSize: 1,
    totalPages: 1,
  );

  int pageNumber = 1;

  List<DataColumn> columns = [
    DataColumn(label: Text('Name')),
    DataColumn(label: Text('Type')),
    DataColumn(label: Text('Contact')),
    DataColumn(label: Text('Capacity')),
    DataColumn(label: Text('')),
  ];

  @override
  void initState() {
    super.initState();
    _fetchVenues();
  }

  Future<void> _fetchVenues() async {
    final repository = ref.watch(venuesControllerProvider.notifier);
    venues = await repository.getVenuesForOrganization(
      page: pageNumber,
      pageSize: 10,
    );

    setState(() {
      isLoading = false; // Turn off loading when data arrives
    });
  }

  Future<void> _refresh() async {
    print('Triggered refresh');
    ref.invalidate(venuesControllerProvider);
    await _fetchVenues();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;
    const _wideBreakpoint = 1000.0;
    final wide = MediaQuery.of(context).size.width >= _wideBreakpoint;

    return Scaffold(
      drawer: wide
          ? null
          : Drawer(
        width: 240,
        backgroundColor: cs.surface,
        child: SideNav(activePath: '/forms'),
      ),
      body: SafeArea(
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  TopBar(wide: wide),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: VenueDataTable(
                      columns: columns,
                      venues: venues,
                      constraints: constraints,
                      isLoading: isLoading,
                      onPageChanged: (page){
                        pageNumber = page;
                        _fetchVenues();
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
