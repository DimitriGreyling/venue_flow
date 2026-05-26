import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/providers/api_client_provider.dart';
import 'package:venue_flow_app/repositories/event_repository.dart';
import 'package:venue_flow_app/repositories/form_repository.dart';
import 'package:venue_flow_app/repositories/form_submission_repository.dart';

final formRepositoryProvider = Provider<IFormRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return FormRepository(apiClient: apiClient);
});

final formSubmissionRepositoryProvider = Provider<IFormSubmissionRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return FormSubmissionRepository(apiClient: apiClient);
});

final eventRepositoryProvider = Provider<IEventRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return EventRepository(apiClient: apiClient);
});