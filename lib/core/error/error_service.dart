import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'app_exception.dart';

part 'error_service.g.dart';

/// Root navigator key -> dialogs go on the ROOT overlay (above everything).
final rootNavigatorKey = GlobalKey<NavigatorState>();

/// Root messenger key -> toasts/snackbars from anywhere.
final rootMessengerKey = GlobalKey<ScaffoldMessengerState>();

class ErrorService {
  bool _dialogOpen = false;
  String? _lastMessage;
  DateTime _lastShown = DateTime.fromMillisecondsSinceEpoch(0);

  /// Call from anywhere: ref.read(errorServiceProvider).show(error)
  void show(Object error, {StackTrace? stack}) {
    final ex = AppException.from(error);
    debugPrint('[ErrorService] $ex\n${stack ?? ''}');

    if (ex.type == AppErrorType.cancelled) return;

    // De-dupe identical errors fired within 2 seconds.
    final now = DateTime.now();
    if (_lastMessage == ex.message &&
        now.difference(_lastShown) < const Duration(seconds: 2)) {
      return;
    }
    _lastMessage = ex.message;
    _lastShown = now;

    // Schedule after the frame so it's safe from build/async contexts.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (ex.type) {
        case AppErrorType.validation:
        case AppErrorType.network:
        case AppErrorType.timeout:
          _toast(ex);
        default:
          _dialog(ex);
      }
    });
  }

  void _toast(AppException ex) {
    final messenger = rootMessengerKey.currentState;
    if (messenger == null) return;
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        backgroundColor: Colors.red.shade700,
        content: Text(ex.message),
        duration: const Duration(seconds: 5),
      ));
  }

  Future<void> _dialog(AppException ex) async {
    // Overlay context sits UNDER the root Navigator, so showDialog works
    // and uses the root navigator -> above all pages, sheets and nested nav.
    final ctx = rootNavigatorKey.currentState?.overlay?.context;
    if (ctx == null || _dialogOpen) return;
    _dialogOpen = true;

    final icon = switch (ex.type) {
      AppErrorType.unauthorized => Icons.lock_clock,
      AppErrorType.forbidden => Icons.block,
      AppErrorType.notFound => Icons.search_off,
      AppErrorType.server => Icons.cloud_off,
      _ => Icons.error_outline,
    };

    await showDialog<void>(
      context: ctx,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (dialogCtx) => AlertDialog(
        icon: Icon(icon, color: Theme.of(dialogCtx).colorScheme.error, size: 32),
        title: Text(ex.title ?? 'Error'),
        content: SelectableText(ex.message),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(dialogCtx, rootNavigator: true).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    _dialogOpen = false;
  }
}

@Riverpod(keepAlive: true)
ErrorService errorService(Ref ref) => ErrorService();