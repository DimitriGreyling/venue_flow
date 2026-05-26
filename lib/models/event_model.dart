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
      createdAt: json['createdDate'] != null
          ? DateTime.tryParse(json['createdDate'])
          : null,
      modifiedDate: json['modifiedDate'] != null
          ? DateTime.tryParse(json['modifiedDate'])
          : null,
      eventDate: json['eventDate'] != null
          ? DateTime.tryParse(json['eventDate'])
          : null,
      guestCount: json['guestCount'],
      name: json['name'],
      status:
          json['status'] != null ? EventStatus.values[json['status']] : null,
      tenantId: json['tenantId'],
    );

    return object;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      // 'createdDate': createdAt?.toIso8601String(),
      // 'modifiedDate': modifiedDate?.toIso8601String(),
      'eventDate': eventDate?.toUtc().toIso8601String(),
      'guestCount': guestCount,
      'name': name,
      'status': status?.index ?? 0,
      'tenantId': tenantId,
    };
  }

  DateTime? parseEventDate(dynamic value) {
    if (value == null) return null;

    if (value is String) {
      var normalized = value.trim();

      // "2026-05-21 07:19:52.427+02" -> "2026-05-21T07:19:52.427+02:00"
      normalized = normalized.replaceFirst(' ', 'T');
      normalized = normalized.replaceAllMapped(
        RegExp(r'([+-]\d{2})$'),
        (match) => '${match.group(1)}:00',
      );

      return DateTime.tryParse(normalized);
    }

    return null;
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
