import 'package:flutter/material.dart';

class IconResolver {
  IconResolver._();

  static const Map<String, IconData> _icons = {
    'person': Icons.person,
    'email': Icons.email,
    'phone': Icons.phone,
    'calendar': Icons.calendar_today,
    'location': Icons.location_on,
    'home': Icons.home,
    'search': Icons.search,
    'settings': Icons.settings,
    'description': Icons.description,
    'event': Icons.event,
    'business': Icons.business,
    'attach_money': Icons.attach_money,
    'check': Icons.check,
    'close': Icons.close,
    'add': Icons.add,
    'edit': Icons.edit,
    'delete': Icons.delete,
    'info': Icons.info,
    'warning': Icons.warning,
    'star': Icons.star,
    'person_outline': Icons.person_outline,
    'work': Icons.work,
    'language': Icons.language,
    'calendar_month': Icons.calendar_month,
    'upload': Icons.upload,
    'download': Icons.download,
  };

  static IconData? resolve(String? name) {
    if (name == null || name.isEmpty) return null;

    return _icons[name];
  }

  static String? nameOf(IconData? icon) {
    if (icon == null) return null;

    for (final entry in _icons.entries) {
      if (entry.value == icon) {
        return entry.key;
      }
    }

    return null;
  }

  static List<String> get availableIcons => _icons.keys.toList();
}