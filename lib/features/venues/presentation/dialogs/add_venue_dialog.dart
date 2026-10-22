import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/core/enums/venue_type.dart';
import 'package:venue_flow_app/core/theme/app_theme.dart';
import 'package:venue_flow_app/features/venues/domain/create_venue_request.dart';
import 'package:venue_flow_app/features/venues/domain/update_venue_request.dart';
import 'package:venue_flow_app/features/venues/domain/venue_response.dart';
import '../../../../core/theme/theme_x.dart';
import '../../data/venue_repository.dart';

///
/// Dialog popup to edit a venue
///
class AddVenueDialog extends ConsumerStatefulWidget {
  const AddVenueDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(context: context, builder: (_) => AddVenueDialog());
  }

  @override
  ConsumerState<AddVenueDialog> createState() => _EditVenueDialogState();
}

class _EditVenueDialogState extends ConsumerState<AddVenueDialog>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final _venueNameController = TextEditingController();
  final _venueDescriptionController = TextEditingController();
  final _venueTypeController = TextEditingController();
  final _addressLine1Controller = TextEditingController();
  final _addressLine2Controller = TextEditingController();
  final _suburbController = TextEditingController();
  final _cityController = TextEditingController();
  final _provinceController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _countryController = TextEditingController();
  final _minimumCapacityController = TextEditingController();
  final _maximumCapacityController = TextEditingController();
  final _contactNameController = TextEditingController();
  final _contactEmailController = TextEditingController();
  final _contactPhoneController = TextEditingController();

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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

  Future<void> _save({
    required ColorScheme cs,
    required AppSemanticColors sem,
  }) async {
    try {
      if (_isSaving) return;

      setState(() {
        _isSaving = true;
      });

      if (!_formKey.currentState!.validate()) {
        setState(() {
          _isSaving = false;
        });
        return;
      }

      final repo = ref.watch(venueRepositoryProvider);

      await repo.addVenue(
        request: CreateVenueRequest(
          name: _venueNameController.text,
          description: _venueDescriptionController.text,
          venueType: _venueTypeController.text,
          addressLine1: _addressLine1Controller.text,
          addressLine2: _addressLine2Controller.text,
          suburb: _suburbController.text,
          city: _cityController.text,
          province: _provinceController.text,
          postalCode: _postalCodeController.text,
          country: _countryController.text,
          minimumCapacity: int.tryParse(_minimumCapacityController.text) ?? 0,
          maximumCapacity: int.tryParse(_maximumCapacityController.text) ?? 0,
          contactName: _contactNameController.text,
          contactEmail: _contactEmailController.text,
          contactPhone: _contactPhoneController.text,
        ),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: sem.success,
          content: Text('Venue created successfully'),
        ),
      );

      Navigator.of(context).pop(true);
    } catch (e) {
      setState(() {
        _isSaving = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: cs.error,
          content: Text('An error occurred: $e'),
        ),
      );
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

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
          constraints: BoxConstraints(maxHeight: screenSize.height * 0.8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Edit Venue', style: textTheme.headlineSmall),
                const SizedBox(height: 16),

                Flexible(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Animate the height change when the fields appear.
                          AnimatedSize(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            alignment: Alignment.topCenter,
                            child: selectedVenueDetailsView(),
                          ),
                        ],
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
                              child: CircularProgressIndicator(strokeWidth: 2),
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

  Widget selectedVenueDetailsView() {
    return DefaultTabController(
      length: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // Tabs
          IgnorePointer(
            ignoring: _isSaving,
            child: Opacity(
              opacity: _isSaving ? 0.5 : 1.0,
              child: const TabBar(
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                tabs: [
                  Tab(icon: Icon(Icons.store_outlined), text: 'General'),
                  Tab(
                    icon: Icon(Icons.contact_phone_outlined),
                    text: 'Contact',
                  ),
                  Tab(icon: Icon(Icons.location_on_outlined), text: 'Address'),
                  Tab(icon: Icon(Icons.groups_outlined), text: 'Capacity'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: TabBarView(
              children: [
                _buildGeneralTab(),
                _buildContactTab(),
                _buildAddressTab(),
                _buildCapacityTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  enabled: !_isSaving,
                  controller: _venueNameController,
                  decoration: const InputDecoration(
                    labelText: 'Venue Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Venue Type',
                    border: OutlineInputBorder(),
                  ),
                  items: VenueType.values
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toString()),
                        ),
                      )
                      .toList(),
                  onChanged: (venuType) {
                    _venueTypeController.text = venuType.toString();
                  },
                  initialValue: _venueTypeController.text.isNotEmpty
                      ? VenueType.values.firstWhere(
                          (e) => e.toString() == _venueTypeController.text,
                        )
                      : null,
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
    );
  }

  Widget _buildContactTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
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
          ),
        ],
      ),
    );
  }

  Widget _buildAddressTab() {
    return SingleChildScrollView(
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
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  enabled: !_isSaving,
                  controller: _cityController,
                  decoration: const InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                  ),
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
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
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
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  enabled: !_isSaving,
                  controller: _suburbController,
                  decoration: const InputDecoration(
                    labelText: 'Suburb',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCapacityTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
