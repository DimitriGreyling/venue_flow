import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'error_service.dart';

final class ErrorObserver extends ProviderObserver {
  ErrorObserver(this.errors);
  final ErrorService errors;

  @override
  void providerDidFail(
      ProviderObserverContext context,
      Object error,
      StackTrace stackTrace,
      ) {
    errors.show(error, stack: stackTrace);
  }
}