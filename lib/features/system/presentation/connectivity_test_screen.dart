import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/system_providers.dart';

class ConnectivityTestScreen extends ConsumerWidget {
  const ConnectivityTestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final health = ref.watch(healthCheckProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('BE Connectivity Test')),
      body: Center(
        child: health.when(
          data: (ok) => Text(ok ? '✅ Backend reachable' : '❌ Backend unreachable'),
          loading: () => const CircularProgressIndicator(),
          error: (e, _) => Text('❌ Error: $e'),
        ),
      ),
    );
  }
}