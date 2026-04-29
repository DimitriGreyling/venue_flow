import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:venue_flow_app/providers/supbase_provider.dart';
import 'package:venue_flow_app/repositories/event_repository.dart';
import 'package:venue_flow_app/repositories/form_repository.dart';
import 'package:venue_flow_app/repositories/form_submission_repository.dart';

final formRepositoryProvider = Provider<IFormRepository>((ref) {
  final supabaseClient = ref.watch(supabaseProvider);
  return FormRepository(client: supabaseClient);
});

final formSubmissionRepositoryProvider = Provider<IFormSubmissionRepository>((ref) {
  final supabaseClient = ref.watch(supabaseProvider);
  return FormSubmissionRepository(client: supabaseClient);
});

final eventRepositoryProvider = Provider<IEventRepository>((ref) {
  final supabaseClient = ref.watch(supabaseProvider);
  return EventRepository(client: supabaseClient);
});