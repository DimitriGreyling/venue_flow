import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:venue_flow_app/providers/supbase_provider.dart';
import 'package:venue_flow_app/repositories/form_repository.dart';

final formRepositoryProvider = Provider<FormRepository>((ref) {
  final supabaseClient = ref.watch(supabaseProvider);
  return FormRepository(client: supabaseClient);
});