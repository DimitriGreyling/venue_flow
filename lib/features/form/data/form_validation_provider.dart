import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/features/form/domain/services/form_validation_service.dart';

final formValidationServiceProvider = Provider<FormValidationService>((ref) {
  return const FormValidationService();
});