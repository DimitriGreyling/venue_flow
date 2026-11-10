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
  FormVersion?
  _selectedVersion; // 👈 1. Added state to track the active version
  int? _latestVersion;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadForm();
  }

  Future<void> _loadForm() async {
print('Widget variables ${widget.formId} ${widget.isAdd}');
    if (widget.formId == null || widget.isAdd) return;

    setState(() {
      _isLoading = true;
    });

    // Note: It's safer to use ref.read inside asynchronous event handlers/methods
    final repository = ref.read(formControllerProvider.notifier);

    final response = await repository.loadFormVersionsById(
      formId: widget.formId!,
    );

    setState(() {
      _formVersions = response;
      // 👈 2. Default to the first version if available
      // if (_formVersions.isNotEmpty) {
      //   _selectedVersion = _formVersions.first;
      // }
      // _latestVersion

      if (_formVersions.isNotEmpty) {
        // 1. Find the version object with the maximum version number
        _selectedVersion = _formVersions.reduce(
          (current, next) =>
              (current.versionNumber ?? 0) > (next.versionNumber ?? 0)
              ? current
              : next,
        );

        // Find the latest version number
        _latestVersion = _formVersions
            .reduce(
              (current, next) =>
                  (current.versionNumber ?? 0) > (next.versionNumber ?? 0)
                  ? current
                  : next,
            )
            .versionNumber;
      }
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;
    const _wideBreakpoint = 1000.0;
    final statusBarHeight = MediaQuery.paddingOf(context).top;

    if (!_isPositionsInitialized) {
      _floatingFieldsTop = statusBarHeight + 65.0;
      _floatingFieldsLeft = 20.0;
      _floatingSettingsTop = statusBarHeight + 65.0;
      _floatingSettingsLeft = 20.0;
      _isPositionsInitialized = true;
    }

    // 👈 3. Extracted the core view builder so we don't repeat the Responsive structure
    Widget buildBody() {
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
          child: form_mobile_view.FormMobileView(
            formVersions: _formVersions,
            // Pass _selectedVersion here if your view needs to render data for that specific version
          ),
        ),
        tablet: (_) => Skeletonizer(
          enabled: _isLoading,
          effect: ShimmerEffect(
            baseColor: cs.surfaceContainerLow,
            highlightColor: cs.surface,
          ),
          child: form_tablet_view.FormTabletView(
            selectedFormVersion: _selectedVersion,
            formId: widget.formId,
            latestVersion: _latestVersion,
            refreshUI: (value) {
              _loadForm();
            },
          ),
        ),
        desktop: (_) => Skeletonizer(
          enabled: _isLoading,
          effect: ShimmerEffect(
            baseColor: cs.surfaceContainerLow,
            highlightColor: cs.surface,
          ),
          child: form_desktop_view.FormDesktopView(formVersions: _formVersions),
        ),
      );
    }

    // 👈 4. Wrap with a Scaffold to provide a top navigation/action bar containing the dropdown
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Details'),
        actions: [
          if (_formVersions.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              key: const ValueKey('version_dropdown_padding'),
              child: DropdownButton<FormVersion>(
                value: _selectedVersion,
                underline: const SizedBox.shrink(), // Hides default underline
                items: _formVersions.map((FormVersion version) {
                  return DropdownMenuItem<FormVersion>(
                    value: version,
                    // Replace 'version.name' or 'version.id' with your actual property name
                    child: Text(
                      'Version ${version.versionNumber ?? version.id}',
                    ),
                  );
                }).toList(),
                onChanged: (FormVersion? newValue) {
                  setState(() {
                    _selectedVersion = newValue;
                  });
                  // Optional: Trigger any side-effects here if changing version requires a fresh fetch
                },
              ),
            ),
        ],
      ),
      body: buildBody(),
    );
  }
}
