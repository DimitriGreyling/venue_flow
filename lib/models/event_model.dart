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

  EventModel({
    this.id,
    this.createdAt,
    this.modifiedDate,
    this.eventDate,
    this.guestCount,
    this.name,
    this.status,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      createdAt: json['created_at'],
      modifiedDate: json['modified_date'],
      eventDate: json['event_date'],
      guestCount: json['guest_count'],
      name: json['name'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'modified_date': modifiedDate,
      'event_date': eventDate,
      'guest_count': guestCount,
      'name': name,
      'status': status,
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
