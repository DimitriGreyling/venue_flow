import 'package:flutter/material.dart';

class TooltipWidget extends StatelessWidget {
  final Widget? child;
  final String? message;

  const TooltipWidget({super.key, this.child, this.message});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message ?? '',
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      child: child,
    );
  }
}
