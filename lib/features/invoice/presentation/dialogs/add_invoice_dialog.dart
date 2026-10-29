import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:venue_flow_app/core/theme/app_theme.dart';
import 'package:venue_flow_app/features/customers/domain/register_customer.dart';
import 'package:venue_flow_app/features/customers/presentation/customer_controller.dart';
import 'package:venue_flow_app/features/invoice/data/invoice_controller.dart';
import 'package:venue_flow_app/features/invoice/domain/invoice_item.dart';
import 'package:venue_flow_app/features/invoice/domain/invoice_number_reservation_response.dart';
import 'package:venue_flow_app/features/invoice/presentation/widgets/invoice_line_items_editor.dart';
import '../../../../core/theme/theme_x.dart' show ThemeX;
import '../../../../core/widgets/customer_auto_complete.dart';
import '../../../customers/domain/customer.dart';
import '../../domain/add_invoice_request.dart';

///
/// Dialog popup to add a invoice to a organization
///
class AddInvoiceDialog extends ConsumerStatefulWidget {
  const AddInvoiceDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (_) => const AddInvoiceDialog(),
    );
  }

  @override
  ConsumerState<AddInvoiceDialog> createState() => _AddInvoiceDialogState();
}

class _AddInvoiceDialogState extends ConsumerState<AddInvoiceDialog>
    with TickerProviderStateMixin {
  //form keys
  final _customerFormKey = GlobalKey<FormState>();
  final _invoiceDetailsKey = GlobalKey<FormState>();

  //Tab Controller for invoices
  late final TabController _tabController;

  bool _isSaving = false;

  Customer? _selectedCustomer;
  bool _isCustomerSelected = false;

  //Invoice line items array
  List<InvoiceItem> _invoiceItems = [];
  InvoiceNumberReservationResponse? _invoiceNumber;

  //Text Controllers
  final _invoiceDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  ///
  /// Saves the invoice to the database
  ///
  Future<void> _save({
    required ColorScheme cs,
    required AppSemanticColors sem,
  }) async {
    try {
      final repo = ref.watch(invoiceControllerProvider.notifier);

      await repo.createInvoice(
        addInvoiceRequest: AddInvoiceRequest(
          customerId: _selectedCustomer?.userId ?? '',
          venueId: '3fa85f64-5717-4562-b3fc-2c963f66afa6',
          invoiceDate: DateTime.now(),
          invoiceNumber: _invoiceNumber?.invoiceNumber ?? '',
          totalAmount: 0,
          isDeleted: false,
          email: _selectedCustomer?.email ?? '',
          notes: 'Notes',
        ),
        reservationId: _invoiceNumber?.reservationId ?? '',
      );

      // if (_isSaving) return;
      //
      // setState(() {
      //   _isSaving = true;
      // });
      //
      // if (!_formKey.currentState!.validate()) {
      //   setState(() {
      //     _isSaving = false;
      //   });
      //   return;
      // }
      //
      // final repo = ref.watch(customerControllerProvider.notifier);

      // if (_isNewCustomer) {
      //   await repo.registerCustomer(
      //     /// Password will be over written by the system and sent to the user via email
      //     RegisterCustomer(
      //       firstName: _firstNameController.text,
      //       lastName: _surnameController.text,
      //       email: _emailController.text,
      //     ),
      //   );
      // } else {
      //   // await repo.linkCustomer(
      //   //   LinkCustomerToOrg(userId: _selectedCustomer!.userId, roleId: ''),
      //   // );
      // }

      // if (!mounted) return;
      //
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     backgroundColor: sem.success,
      //     content: Text('Invoice added successfully'),
      //   ),
      // );
      //
      // Navigator.of(context).pop(true);
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

  String? _requiredValidator(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    return null;
  }

  void _onCustomerSelected(Customer? selectedCustomer) {
    if (selectedCustomer == null) {
      setState(() {
        _selectedCustomer = null;
        _isCustomerSelected = false;
      });
    } else {
      setState(() {
        _selectedCustomer = selectedCustomer;
        _isCustomerSelected = true;
      });
    }
  }

  void _onInvoiceItemsChanged(List<InvoiceItem> items) {
    setState(() {
      _invoiceItems = List<InvoiceItem>.from(items);
    });
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
    final loadingInvNumber = ref.watch(invoiceNumberProvider);

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: SizedBox(
        width: dialogWidth,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: screenSize.height * 0.8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: loadingInvNumber.when(
              data: (invoiceData) {
                _invoiceNumber = invoiceData;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Create Invoice', style: textTheme.headlineSmall),
                    Text(
                      invoiceData.invoiceNumber,
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),

                    Flexible(
                      child: SingleChildScrollView(
                        child: AnimatedSize(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          alignment: Alignment.topCenter,
                          child: tabView(cs: cs, sem: sem),
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
                );
              },
              error: (error, stack) {
                return Text('Error: $error');
              },
              loading: () {
                return Skeletonizer(
                  enabled: true,
                  effect: ShimmerEffect(
                    baseColor: cs.surfaceContainerLow,
                    highlightColor: cs.surface,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Loading...', style: textTheme.headlineSmall),
                      const SizedBox(height: 16),

                      Flexible(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ...List.generate(3, (index) {
                                return Skeleton.leaf(
                                  child: ListTile(
                                    title: Text('Loading $index'),
                                  ),
                                );
                              }),
                            ],
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget tabView({required ColorScheme cs, required AppSemanticColors sem}) {
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
                Tab(icon: Icon(Icons.store_outlined), text: 'Customer'),
                Tab(
                  icon: Icon(Icons.contact_phone_outlined),
                  text: 'Invoice Details',
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
                  _buildCustomerTab(cs: cs, sem: sem),
                  _buildInvoiceDetails(cs: cs, sem: sem),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerTab({
    required ColorScheme cs,
    required AppSemanticColors sem,
  }) {
    return Form(
      key: _customerFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomerAutoComplete(
            onCustomerSelected: _onCustomerSelected,
            isDisabled: _isSaving || _isCustomerSelected,
          ),
          if (_selectedCustomer != null && _isCustomerSelected)
            const SizedBox(height: 8),
          if (_selectedCustomer != null && _isCustomerSelected)
            Text('Customer information:'),
          if (_selectedCustomer != null && _isCustomerSelected)
            const SizedBox(height: 8),
          if (_selectedCustomer != null && _isCustomerSelected)
            Text(
              'Name: ${_selectedCustomer?.firstName ?? ''} ${_selectedCustomer?.lastName ?? ''}',
            ),
          if (_selectedCustomer != null && _isCustomerSelected)
            const SizedBox(height: 8),
          if (_selectedCustomer != null && _isCustomerSelected)
            Text('Email: ${_selectedCustomer?.email ?? ''}'),
        ],
      ),
    );
  }

  Widget _buildInvoiceDetails({
    required ColorScheme cs,
    required AppSemanticColors sem,
  }) {
    return Form(
      key: _invoiceDetailsKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              enabled: !_isSaving,
              controller: _invoiceDescriptionController,
              decoration: const InputDecoration(
                labelText: 'Invoice description',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  _requiredValidator(value, 'Invoice description'),
            ),
            InvoiceLineItemsEditor(
              onChanged: _onInvoiceItemsChanged,
              currencySymbol: 'R',
            ),
          ],
        ),
      ),
    );
  }
}
