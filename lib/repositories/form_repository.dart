import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:venue_flow_app/models/dynamic_form_model.dart';

class FormRepository {
  final SupabaseClient _client;

  FormRepository({
    required SupabaseClient client,
  }) : _client = client;

  Future<List<DynamicFormModel>?> getForms() async {
    try {
      final response = await _client.from('forms').select();
      log('VALUES:: ${response.first}');

      final forms = response
          .map(
            (json) => DynamicFormModel.fromJson(json),
          )
          .toList(); // ← .toList() consumes the iterable

      log('done');
      return forms; // Return the transformed data
    } catch (erro, stackTrace) {
      log('assfsd');
      return null;
    }
  }
}
