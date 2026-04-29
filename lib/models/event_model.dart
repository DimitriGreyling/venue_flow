import 'dart:convert';
import 'dart:developer';

import 'package:venue_flow_app/models/enums.dart';

class EventModel {
  String? id;
  DateTime? createdAt;
  DateTime? modifiedDate;
  String? name;
  DateTime? eventDate;
  int? guestCount;
  EventStatus? status;
  String? tenantId;

  EventModel({
    this.id,
    this.createdAt,
    this.modifiedDate,
    this.eventDate,
    this.guestCount,
    this.name,
    this.status,
    this.tenantId,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    final object = EventModel(
      id: json['id'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      modifiedDate: json['modified_date'] != null
          ? DateTime.tryParse(json['modified_date'])
          : null,
      eventDate: json['event_date'] != null
          ? DateTime.tryParse(json['event_date'])
          : null,
      guestCount: json['guest_count'],
      name: json['name'],
      status: json['status'] != null
          ? EventStatus.values.byName(json['status'].toString().toLowerCase())
          : null,
      tenantId: json['tenant_id'],
    );

    return object;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'modified_date': modifiedDate?.toIso8601String(),
      'event_date': eventDate?.toIso8601String(),
      'guest_count': guestCount,
      'name': name,
      'status': status,
      'tenant_id': tenantId,
    };
  }

  //toString
  @override
  String toString() => toJsonString();

//toJsonString
  String toJsonString() {
    try {
      return jsonEncode(toJson());
    } catch (error, stackTrace) {
      log('TOJSONSTRING ERROR:: ${error}');
      return '';
    }
  }
}
