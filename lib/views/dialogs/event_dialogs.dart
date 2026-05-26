import 'package:flutter/material.dart';
import 'package:venue_flow_app/models/enums.dart';
import 'package:venue_flow_app/models/event_model.dart';

Future<EventModel?> showEventDialog({
  required BuildContext context,
  EventModel? existingEvent,
  bool isEdit = false,
}) async {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController(text: existingEvent?.name ?? '');
  final guestCountController = TextEditingController(
    text: existingEvent?.guestCount?.toString() ?? '',
  );

  DateTime? selectedDate = existingEvent?.eventDate ?? DateTime.now();
  EventStatus selectedStatus = existingEvent?.status ?? EventStatus.draft;

  return showDialog<EventModel>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          Future<void> pickDate() async {
            final picked = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );

            if (picked != null) {
              setState(() {
                selectedDate = picked;
              });
            }
          }

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            isEdit ? 'Update Event' : 'Add Event',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Event Name',
                          hintText: 'Enter event name',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Event name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: guestCountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Guest Count',
                          hintText: 'Enter expected guests',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Guest count is required';
                          }
                          final parsed = int.tryParse(value);
                          if (parsed == null || parsed < 0) {
                            return 'Guest count must be a valid number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: pickDate,
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Event Date',
                          ),
                          child: Text(
                            selectedDate == null
                                ? 'Select a date'
                                : '${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}',
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<EventStatus>(
                        value: selectedStatus,
                        decoration: const InputDecoration(labelText: 'Status'),
                        items: EventStatus.values.map((status) {
                          return DropdownMenuItem<EventStatus>(
                            value: status,
                            child: Text(status.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedStatus = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            child: const Text('Cancel'),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {
                              if (!formKey.currentState!.validate()) {
                                return;
                              }

                              if (selectedDate == null) {
                                return;
                              }

                              final result = EventModel(
                                id: existingEvent?.id,
                                tenantId: existingEvent?.tenantId,
                                createdAt: existingEvent?.createdAt,
                                modifiedDate: DateTime.now(),
                                name: nameController.text.trim(),
                                guestCount:
                                    int.tryParse(guestCountController.text.trim()),
                                eventDate: selectedDate,
                                status: selectedStatus,
                              );

                              Navigator.pop(dialogContext, result);
                            },
                            child: Text(isEdit ? 'Update' : 'Create'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}