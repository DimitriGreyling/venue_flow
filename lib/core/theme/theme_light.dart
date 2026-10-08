import 'package:flutter/material.dart';
import 'app_theme.dart';

extension ThemeX on BuildContext {
  AppSemanticColors get semantic => Theme.of(this).extension<AppSemanticColors>()!;
}