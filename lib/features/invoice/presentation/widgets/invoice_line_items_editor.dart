import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:venue_flow_app/features/invoice/domain/invoice_item.dart';

class _InvoiceLineItemControllers {
  _InvoiceLineItemControllers()
    : description = TextEditingController(),
      quantity = TextEditingController(text: '1'),
      unitPrice = TextEditingController(text: '0.00');

  final TextEditingController description;
  final TextEditingController quantity;
  final TextEditingController unitPrice;

  int get parsedQuantity => int.tryParse(quantity.text.trim()) ?? 0;

  double get parsedUnitPrice => double.tryParse(unitPrice.text.trim()) ?? 0;

  double get lineTotal => parsedQuantity * parsedUnitPrice;

  InvoiceItem toInput() => InvoiceItem(
    id: '',
    description: description.text.trim(),
    price: parsedUnitPrice,
    quantity: parsedQuantity,
    totalAmount: lineTotal,
    invoiceId: '',
  );

  void dispose() {
    description.dispose();
    quantity.dispose();
    unitPrice.dispose();
  }
}

class InvoiceLineItemsEditor extends StatefulWidget {
  const InvoiceLineItemsEditor({
    super.key,
    required this.onChanged,
    this.currencySymbol = 'R',
  });

  final ValueChanged<List<InvoiceItem>> onChanged;
  final String currencySymbol;

  @override
  State<InvoiceLineItemsEditor> createState() => _InvoiceLineItemsEditorState();
}

class _InvoiceLineItemsEditorState extends State<InvoiceLineItemsEditor> {
  final List<_InvoiceLineItemControllers> _items = [];

  @override
  void initState() {
    super.initState();
    _addItem(notify: false);
  }

  void _addItem({bool notify = true}) {
    setState(() {
      _items.add(_InvoiceLineItemControllers());
    });

    if (notify) _notifyChanged();
  }

  void _removeItem(int index) {
    if (_items.length == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An invoice must have at least one item.'),
        ),
      );
      return;
    }

    final item = _items.removeAt(index);
    item.dispose();

    setState(() {});
    _notifyChanged();
  }

  void _notifyChanged() {
    widget.onChanged(_items.map((item) => item.toInput()).toList());
  }

  double get _subtotal => _items.fold(0, (sum, item) => sum + item.lineTotal);

  String _money(double value) =>
      '${widget.currencySymbol} ${value.toStringAsFixed(2)}';

  @override
  void dispose() {
    for (final item in _items) {
      item.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Invoice items',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text('${_items.length} item(s)'),
          ],
        ),
        const SizedBox(height: 16),

        ...List.generate(_items.length, (index) {
          final item = _items[index];

          return Card(
            key: ObjectKey(item),
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Item ${index + 1}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Remove item',
                        onPressed: () => _removeItem(index),
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  TextFormField(
                    controller: item.description,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText: 'e.g. Venue hire',
                      border: OutlineInputBorder(),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (_) => _notifyChanged(),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter an item description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final fields = [
                        Expanded(
                          child: TextFormField(
                            controller: item.quantity,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d{0,4}'),
                              ),
                            ],
                            decoration: const InputDecoration(
                              labelText: 'Quantity',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (_) {
                              setState(() {});
                              _notifyChanged();
                            },
                            validator: (value) {
                              final quantity = double.tryParse(value ?? '');

                              if (quantity == null || quantity <= 0) {
                                return 'Enter a valid quantity';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: item.unitPrice,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d{0,2}'),
                              ),
                            ],
                            decoration: InputDecoration(
                              labelText:
                                  'Unit price (${widget.currencySymbol})',
                              border: const OutlineInputBorder(),
                            ),
                            onChanged: (_) {
                              setState(() {});
                              _notifyChanged();
                            },
                            validator: (value) {
                              final price = double.tryParse(value ?? '');

                              if (price == null || price < 0) {
                                return 'Enter a valid price';
                              }
                              return null;
                            },
                          ),
                        ),
                      ];

                      return Row(children: fields);
                    },
                  ),
                  const SizedBox(height: 12),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Line total: ${_money(item.lineTotal)}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),

        OutlinedButton.icon(
          onPressed: () => _addItem(),
          icon: const Icon(Icons.add),
          label: const Text('Add invoice item'),
        ),

        const Divider(height: 32),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: Theme.of(context).textTheme.titleMedium),
            Text(
              _money(_subtotal),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ],
    );
  }
}
