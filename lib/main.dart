import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'core/error/error_observer.dart';
import 'core/error/error_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final errors = ErrorService();

  final container = ProviderContainer(
    observers: [ErrorObserver(errors)],
    overrides: [errorServiceProvider.overrideWithValue(errors)],
  );

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    errors.show(details.exception, stack: details.stack);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    errors.show(error, stack: stack);
    return true;
  };

  runApp(UncontrolledProviderScope(
    container: container,
    child: const App(),
  ));
}