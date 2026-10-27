import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/core/enums/venue_type.dart';
import 'package:venue_flow_app/features/venues/domain/update_venue_request.dart';
import 'package:venue_flow_app/features/venues/domain/venue_response.dart';

import '../../../../core/theme/theme_x.dart';
import '../../data/venue_repository.dart';

///
/// Dialog popup to edit a venue.
///
class EditVenueDialog extends ConsumerStatefulWidget {
  const EditVenueDialog({super.key, required this.venue});

  final VenueResponse venue;

  static Future<bool?> show(
      BuildContext context, {
        required VenueResponse venue,
      }) {
    return showDialog<bool>(
      context: context,
      builder: (_) => EditVenueDialog(venue: venue),
    );
  }

  @override
  ConsumerState<EditVenueDialog> createState() => _EditVenueDialogState();
}

class _EditVenueDialogState extends ConsumerState<EditVenueDialog>
    with TickerProviderStateMixin {
  // One form key per tab.
  final _generalFormKey = GlobalKey<FormState>();
  final _contactFormKey = GlobalKey<FormState>();
  final _addressFormKey = GlobalKey<FormState>();
  final _capacityFormKey = GlobalKey<FormState>();

  late final TabController _tabController;

  // General
  final _venueNameController = TextEditingController();
  final _venueDescriptionController = TextEditingController();
  final _venueTypeController = TextEditingController();

  // Address
  final _addressLine1Controller = TextEditingController();
  final _addressLine2Controller = TextEditingController();
  final _suburbController = TextEditingController();
  final _cityController = TextEditingController();
  final _provinceController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _countryController = TextEditingController();

  // Capacity
  final _minimumCapacityController = TextEditingController();
  final _maximumCapacityController = TextEditingController();

  // Contact
  final _contactNameController = TextEditingController();
  final _contactEmailController = TextEditingController();
  final _contactPhoneController = TextEditingController();

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);

    _venueNameController.text = widget.venue.name;
    _venueDescriptionController.text = widget.venue.description ?? '';
    _venueTypeController.text = widget.venue.venueType ?? '';

    _addressLine1Controller.text = widget.venue.addressLine1;
    _addressLine2Controller.text = widget.venue.addressLine2 ?? '';
    _suburbController.text = widget.venue.suburb;
    _cityController.text = widget.venue.city;
    _provinceController.text = widget.venue.province;
    _postalCodeController.text = widget.venue.postalCode ?? '';
    _countryController.text = widget.venue.country;

    _minimumCapacityController.text =
        widget.venue.minimumCapacity?.toString() ?? '';
    _maximumCapacityController.text =
        widget.venue.maximumCapacity?.toString() ?? '';

    _contactNameController.text = widget.venue.contactName ?? '';
    _contactEmailController.text = widget.venue.contactEmail ?? '';
    _contactPhoneController.text = widget.venue.contactPhone ?? '';
  }

  @override
  void dispose() {
    _tabController.dispose();

    _venueNameController.dispose();
    _venueDescriptionController.dispose();
    _venueTypeController.dispose();

    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _suburbController.dispose();
    _cityController.dispose();
    _provinceController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();

    _minimumCapacityController.dispose();
    _maximumCapacityController.dispose();

    _contactNameController.dispose();
    _contactEmailController.dispose();
    _contactPhoneController.dispose();

    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Validation
  // ---------------------------------------------------------------------------

  /// Validates every tab, including tabs that the user has not opened.
  ///
  /// Returns true only if all four forms are valid.
  bool _validateAllTabs() {
    final formKeys = <GlobalKey<FormState>>[
      _generalFormKey,
      _contactFormKey,
      _addressFormKey,
      _capacityFormKey,
    ];

    int? firstInvalidTab;

    for (var i = 0; i < formKeys.length; i++) {
      final formState = formKeys[i].currentState;

      if (formState == null || !formState.validate()) {
        firstInvalidTab ??= i;
      }
    }

    if (firstInvalidTab != null) {
      _tabController.animateTo(firstInvalidTab);
      return false;
    }

    return true;
  }

  String? _requiredValidator(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    return null;
  }

  String? _emailValidator(String? value) {
    // Contact email is optional, but must be valid when provided.
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final email = value.trim();
    final emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

    if (!emailPattern.hasMatch(email)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  String? _capacityValidator(String? value, String fieldName) {
    // Capacity is optional.
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final capacity = int.tryParse(value.trim());

    if (capacity == null) {
      return '$fieldName must be a whole number';
    }

    if (capacity < 0) {
      return '$fieldName cannot be negative';
    }

    return null;
  }

  String? _maximumCapacityValidator(String? value) {
    final basicError = _capacityValidator(value, 'Maximum capacity');

    if (basicError != null) {
      return basicError;
    }

    final minimumText = _minimumCapacityController.text.trim();
    final maximumText = value?.trim() ?? '';

    if (minimumText.isEmpty || maximumText.isEmpty) {
      return null;
    }

    final minimum = int.tryParse(minimumText);
    final maximum = int.tryParse(maximumText);

    if (minimum != null && maximum != null && maximum < minimum) {
      return 'Maximum must be at least the minimum';
    }

    return null;
  }

  // ---------------------------------------------------------------------------
  // Save
  // ---------------------------------------------------------------------------

  Future<void> _save({
    required ColorScheme cs,
    required dynamic sem,
  }) async {
    if (_isSaving) return;

    // Validate before starting the save operation.
    if (!_validateAllTabs()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final repo = ref.read(venueRepositoryProvider);

      await repo.updateVenueDetails(
        request: UpdateVenueRequest(
          id: widget.venue.id,
          name: _venueNameController.text.trim(),
          venueType: _venueTypeController.text,
          addressLine1: _addressLine1Controller.text.trim(),
          addressLine2: _addressLine2Controller.text.trim(),
          suburb: _suburbController.text.trim(),
          city: _cityController.text.trim(),
          province: _provinceController.text.trim(),
          postalCode: _postalCodeController.text.trim(),
          country: _countryController.text.trim(),
          minimumCapacity: int.tryParse(
            _minimumCapacityController.text.trim(),
          ),
          maximumCapacity: int.tryParse(
            _maximumCapacityController.text.trim(),
          ),
          contactName: _contactNameController.text.trim(),
          contactEmail: _contactEmailController.text.trim(),
          contactPhone: _contactPhoneController.text.trim(),
          isPublished: widget.venue.isPublished,
          isActive: widget.venue.isActive,
        ),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: sem.success,
          content: const Text('Venue updated successfully'),
        ),
      );

      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: cs.error,
          content: Text('An error occurred: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Dialog layout
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final cs = Theme.of(context).colorScheme;
    final sem = context.semantic;
    final textTheme = Theme.of(context).textTheme;

    final dialogWidth = screenSize.width > 800
        ? screenSize.width * 0.6
        : screenSize.width * 0.9;

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: SizedBox(
        width: dialogWidth,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: screenSize.height * 0.8,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Edit Venue',
                  style: textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),

                Flexible(
                  child: SingleChildScrollView(
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      alignment: Alignment.topCenter,
                      child: selectedCustomerDetailsView(
                        venue: widget.venue,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cs.error,
                        foregroundColor: cs.onError,
                      ),
                      onPressed: _isSaving
                          ? null
                          : () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cs.primary,
                        foregroundColor: cs.onPrimary,
                      ),
                      onPressed: _isSaving
                          ? null
                          : () => _save(cs: cs, sem: sem),
                      child: _isSaving
                          ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                          : const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Tabs
  // ---------------------------------------------------------------------------

  Widget selectedCustomerDetailsView({VenueResponse? venue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),

        IgnorePointer(
          ignoring: _isSaving,
          child: Opacity(
            opacity: _isSaving ? 0.5 : 1,
            child: TabBar(
              controller: _tabController,
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              tabs: const [
                Tab(
                  icon: Icon(Icons.store_outlined),
                  text: 'General',
                ),
                Tab(
                  icon: Icon(Icons.contact_phone_outlined),
                  text: 'Contact',
                ),
                Tab(
                  icon: Icon(Icons.location_on_outlined),
                  text: 'Address',
                ),
                Tab(
                  icon: Icon(Icons.groups_outlined),
                  text: 'Capacity',
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.5,

          // IndexedStack keeps every form mounted. This is important because
          // _validateAllTabs() must validate forms on inactive tabs as well.
          child: AnimatedBuilder(
            animation: _tabController,
            builder: (context, child) {
              return IndexedStack(
                index: _tabController.index,
                children: [
                  _buildGeneralTab(),
                  _buildContactTab(),
                  _buildAddressTab(),
                  _buildCapacityTab(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // General tab
  // ---------------------------------------------------------------------------

  Widget _buildGeneralTab() {
    return Form(
      key: _generalFormKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    enabled: !_isSaving,
                    controller: _venueNameController,
                    decoration: const InputDecoration(
                      labelText: 'Venue Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        _requiredValidator(value, 'Venue name'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<VenueType>(
                    decoration: const InputDecoration(
                      labelText: 'Venue Type',
                      border: OutlineInputBorder(),
                    ),
                    items: VenueType.values
                        .map(
                          (type) => DropdownMenuItem<VenueType>(
                        value: type,
                        child: Text(type.toString()),
                      ),
                    )
                        .toList(),
                    initialValue: _venueTypeController.text.isNotEmpty
                        ? VenueType.values.cast<VenueType?>().firstWhere(
                          (type) =>
                      type.toString() ==
                          _venueTypeController.text,
                      orElse: () => null,
                    )
                        : null,
                    onChanged: _isSaving
                        ? null
                        : (venueType) {
                      _venueTypeController.text =
                          venueType?.toString() ?? '';
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Venue type is required';
                      }

                      return null;
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            TextFormField(
              enabled: !_isSaving,
              controller: _venueDescriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Venue Description',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Contact tab
  // ---------------------------------------------------------------------------

  Widget _buildContactTab() {
    return Form(
      key: _contactFormKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    enabled: !_isSaving,
                    controller: _contactNameController,
                    decoration: const InputDecoration(
                      labelText: 'Contact Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    enabled: !_isSaving,
                    controller: _contactPhoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Contact Phone',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            TextFormField(
              enabled: !_isSaving,
              controller: _contactEmailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Contact Email',
                border: OutlineInputBorder(),
              ),
              validator: _emailValidator,
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Address tab
  // ---------------------------------------------------------------------------

  Widget _buildAddressTab() {
    return Form(
      key: _addressFormKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextFormField(
              enabled: !_isSaving,
              controller: _addressLine1Controller,
              decoration: const InputDecoration(
                labelText: 'Address Line 1',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  _requiredValidator(value, 'Address line 1'),
            ),

            const SizedBox(height: 16),

            TextFormField(
              enabled: !_isSaving,
              controller: _addressLine2Controller,
              decoration: const InputDecoration(
                labelText: 'Address Line 2',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              enabled: !_isSaving,
              controller: _suburbController,
              decoration: const InputDecoration(
                labelText: 'Suburb',
                border: OutlineInputBorder(),
              ),
              validator: (value) => _requiredValidator(value, 'Suburb'),
            ),

            const SizedBox(height: 16),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    enabled: !_isSaving,
                    controller: _cityController,
                    decoration: const InputDecoration(
                      labelText: 'City',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        _requiredValidator(value, 'City'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    enabled: !_isSaving,
                    controller: _provinceController,
                    decoration: const InputDecoration(
                      labelText: 'Province',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        _requiredValidator(value, 'Province'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    enabled: !_isSaving,
                    controller: _postalCodeController,
                    decoration: const InputDecoration(
                      labelText: 'Postal Code',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    enabled: !_isSaving,
                    controller: _countryController,
                    decoration: const InputDecoration(
                      labelText: 'Country',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        _requiredValidator(value, 'Country'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Capacity tab
  // ---------------------------------------------------------------------------

  Widget _buildCapacityTab() {
    return Form(
      key: _capacityFormKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    enabled: !_isSaving,
                    controller: _minimumCapacityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Minimum Capacity',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        _capacityValidator(value, 'Minimum capacity'),
                    onChanged: (_) {
                      // Revalidate maximum capacity when minimum changes.
                      _capacityFormKey.currentState?.validate();
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    enabled: !_isSaving,
                    controller: _maximumCapacityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Maximum Capacity',
                      border: OutlineInputBorder(),
                    ),
                    validator: _maximumCapacityValidator,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}