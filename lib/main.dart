import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'core/error/error_observer.dart';
import 'core/error/error_service.dart';
import 'features/auth/data/auth_session.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

//Testing
  final errors = ErrorService();

  final container = ProviderContainer(
    observers: [ErrorObserver(errors)],
    overrides: [errorServiceProvider.overrideWithValue(errors)],
  );

  // Read the stored token first, so the router never sees "loading"
  await container.read(authSessionProvider.future);

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    errors.show(details.exception, stack: details.stack);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    errors.show(error, stack: stack);
    return true;
  };

  // Turn on clean URLs (removes the '#' from web routing)
  usePathUrlStrategy();

  runApp(UncontrolledProviderScope(container: container, child: const App()));
}
