import 'package:flutter/material.dart';
import '../../features/auth/application/session_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sidebar.dart';

class AppScaffold extends ConsumerWidget {
  final Widget child;
  const AppScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Row(
        children: [
          const SizedBox(width: 240, child: AppSidebar()),
          Expanded(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}