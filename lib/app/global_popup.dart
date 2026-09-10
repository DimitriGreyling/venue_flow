import 'dart:async';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

enum PopupMode { success, error, info, warning }

class GlobalPopup {
  static OverlayEntry? _entry;
  static Timer? _timer;

  static void show({
    required String message,
    PopupMode mode = PopupMode.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final navigatorState = rootNavigatorKey.currentState;
    final overlayState = navigatorState?.overlay;
    if (overlayState == null) return;

    _removeCurrent();

    final style = _style(mode);
    _entry = OverlayEntry(
      builder: (_) => _TopPopup(
        message: message,
        backgroundColor: style.backgroundColor,
        icon: style.icon,
        onClose: _removeCurrent,
      ),
    );

    overlayState.insert(_entry!);
    _timer = Timer(duration, _removeCurrent);
  }

  static void hide() => _removeCurrent();

  static _PopupStyle _style(PopupMode mode) {
    switch (mode) {
      case PopupMode.success:
        return _PopupStyle(Colors.green.shade600, Icons.check_circle);
      case PopupMode.error:
        return _PopupStyle(Colors.red.shade700, Icons.error);
      case PopupMode.warning:
        return _PopupStyle(Colors.orange.shade700, Icons.warning);
      case PopupMode.info:
        return _PopupStyle(Colors.blue.shade700, Icons.info);
    }
  }

  static void _removeCurrent() {
    _timer?.cancel();
    _timer = null;
    _entry?.remove();
    _entry = null;
  }
}

class _PopupStyle {
  const _PopupStyle(this.backgroundColor, this.icon);

  final Color backgroundColor;
  final IconData icon;
}

class _TopPopup extends StatelessWidget {
  const _TopPopup({
    required this.message,
    required this.backgroundColor,
    required this.icon,
    required this.onClose,
  });

  final String message;
  final Color backgroundColor;
  final IconData icon;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top + 12;

    return Positioned(
      top: top,
      left: 12,
      right: 12,
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
          bottom: false,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: -20, end: 0),
            duration: const Duration(milliseconds: 220),
            builder: (context, offset, child) {
              return Transform.translate(
                offset: Offset(0, offset),
                child: child,
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 14,
                    offset: Offset(0, 8),
                    color: Color(0x33000000),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(icon, color: Colors.white),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      message,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  IconButton(
                    onPressed: onClose,
                    icon: const Icon(Icons.close, color: Colors.white, size: 18),
                    splashRadius: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}