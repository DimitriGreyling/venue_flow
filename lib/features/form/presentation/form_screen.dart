import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:venue_flow_app/core/widgets/responsive.dart';
import 'package:venue_flow_app/features/form/data/form_controller.dart';
import 'package:venue_flow_app/features/form/domain/form_version.dart';
import 'package:venue_flow_app/features/form/presentation/views/form_mobile_view.dart'
    deferred as form_mobile_view;
import 'package:venue_flow_app/features/form/presentation/views/form_tablet_view.dart'
    deferred as form_tablet_view;
import 'package:venue_flow_app/features/form/presentation/views/form_desktop_view.dart'
    deferred as form_desktop_view;
import '../../../core/theme/theme_x.dart';

class FormScreen extends ConsumerStatefulWidget {
  const FormScreen({super.key, this.formId, this.isAdd = false});

  final String? formId;
  final bool isAdd;

  @override
  ConsumerState<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends ConsumerState<FormScreen> {
  // Tracks the X and Y screen coordinates for fields bar
  double _floatingFieldsTop = 120.0;
  double _floatingFieldsLeft = 20.0;

  // Tracks the X and Y screen coordinates for settings bar
  double _floatingSettingsTop = 120.0;
  double _floatingSettingsLeft = 20.0;

  // Track if positioning needs a safe initial layout configuration check
  bool _isPositionsInitialized = false;

  // Track the visibility state of the floating bars
  bool _showFloatingFieldsBar = false;
  bool _showFloatingSettingsBar = false;

  List<FormVersion> _formVersions = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadForm();
  }

  Future<void> _loadForm() async {
    if (widget.formId == null) return;
    setState(() {
      _isLoading = true;
    });
    final respository = ref.watch(formControllerProvider.notifier);

    final response = await respository.loadFormVersionsById(
      formId: widget.formId!,
    );
    print('Loaded values : ${response}');

    _formVersions = response;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;
    const _wideBreakpoint = 1000.0;
    final statusBarHeight = MediaQuery.paddingOf(context).top;

    // Initialize positions dynamically on first build based on screen dimensions
    if (!_isPositionsInitialized) {
      // 1. Fields bar starts at Top Left
      _floatingFieldsTop =
          statusBarHeight + 65.0; // Pushed down past status bar
      _floatingFieldsLeft = 20.0; // Pinned to left edge

      // 2. Settings bar starts at Top Right
      _floatingSettingsTop = statusBarHeight + 65.0;
      //Show settings bar on the right side of the screen
      _floatingSettingsLeft = 20.0;

      _isPositionsInitialized = true;
    }
    //Display mobile of desktop view based on the screen size
    return Responsive(
      loadMobile: form_mobile_view.loadLibrary,
      loadTablet: form_tablet_view.loadLibrary,
      loadDesktop: form_desktop_view.loadLibrary,
      mobile: (_) => Skeletonizer(
        enabled: _isLoading,
        effect: ShimmerEffect(
          baseColor: cs.surfaceContainerLow,
          highlightColor: cs.surface,
        ),
        child: form_mobile_view.FormMobileView(),
      ),
      tablet: (_) => Skeletonizer(
        enabled: _isLoading,
        effect: ShimmerEffect(
          baseColor: cs.surfaceContainerLow,
          highlightColor: cs.surface,
        ),
        child: form_tablet_view.FormTabletView(
          formVersions: _formVersions,
        ),
      ),
      desktop: (_) => Skeletonizer(
        enabled: _isLoading,
        effect: ShimmerEffect(
          baseColor: cs.surfaceContainerLow,
          highlightColor: cs.surface,
        ),
        child: form_desktop_view.FormDesktopView(),
      ),
    );
  }
}
