import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:venue_flow_app/constants/supabase_table_names.dart';
import 'package:venue_flow_app/models/dynamic_form_model.dart';
import 'package:venue_flow_app/models/form_submission_model.dart';

abstract class IFormSubmissionRepository {
   Future<FormSubmission?> saveFormSubmission({
    required FormSubmission submittedForm,
  });
}

class FormSubmissionRepository extends IFormSubmissionRepository {
  final SupabaseClient _client;

  FormSubmissionRepository({
    required SupabaseClient client,
  }) : _client = client;

  final String _tableName = SupabaseTableNames.formSubmissionTable;

  @override
  Future<FormSubmission?> saveFormSubmission({
    required FormSubmission submittedForm,
  }) async {
    final response =
        await _client.from(_tableName).insert(submittedForm.toJson()).select();

    return response.map((x)=> FormSubmission.fromJson(x)).firstOrNull;
  }
}
