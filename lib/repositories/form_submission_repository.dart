import 'package:venue_flow_app/constants/api_contract.dart';
import 'package:venue_flow_app/models/form_submission_model.dart';
import 'package:venue_flow_app/shared/helpers/api_client.dart';

abstract class IFormSubmissionRepository {
   Future<FormSubmission?> saveFormSubmission({
    required FormSubmission submittedForm,
  });
}

class FormSubmissionRepository extends IFormSubmissionRepository {
  final ApiClient _apiClient;

  FormSubmissionRepository({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<FormSubmission?> saveFormSubmission({
    required FormSubmission submittedForm,
  }) async {
    final response = await _apiClient.dio.post(
      ApiEndpoints.formSubmissions,
      data: submittedForm.toJson(),
    );

    final body = response.data;
    if (body is Map<String, dynamic>) {
      if (body['data'] is Map<String, dynamic>) {
        return FormSubmission.fromJson(body['data'] as Map<String, dynamic>);
      }
      return FormSubmission.fromJson(body);
    }

    if (body is List && body.isNotEmpty && body.first is Map<String, dynamic>) {
      return FormSubmission.fromJson(body.first as Map<String, dynamic>);
    }

    return null;
  }
}
