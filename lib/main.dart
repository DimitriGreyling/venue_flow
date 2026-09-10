import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/error/failure.dart';
import 'error/isolate_setup_stub.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    GlobalErrorHandler.report(details.exception, details.stack);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    GlobalErrorHandler.report(error, stack);
    return true;
  };

  //! Web does not support isolate
  if (!kIsWeb) {
    setupIsolateErrorListener(GlobalErrorHandler.report);
  }

  runZonedGuarded(
    () {
      runApp(const ProviderScope(child: VenueFlowApp()));
    },
    (error, stack) {
      GlobalErrorHandler.report(error, stack);
    },
  );
}

class GlobalErrorHandler {
  static void report(Object error, StackTrace? stack) {
    debugPrint('Global error: $error');
    if (stack != null) debugPrint('$stack');
    // send to Crashlytics/Sentry here
  }

  static String userMessage(Object error) {
    if (error is Failure) return error.message;
    return 'Something went wrong. Please try again.';
  }
}
