import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:venue_flow_app/constants/supabase_table_names.dart';
import 'package:venue_flow_app/models/dynamic_form_model.dart';

class FormRepository {
  
  //CONSTRUCTOR
  FormRepository({
    required SupabaseClient client,
  }) : _client = client;

  //VARIABLES
  final SupabaseClient _client;
  final _tableName = SupabaseTableNames.formTable;

  Future<List<DynamicFormModel>?> getForms() async {
    try {
      final response = await _client.from(_tableName).select();

      final forms = response
          .map(
            (json) => DynamicFormModel.fromJson(json),
          )
          .toList();

      log('done');
      return forms; // Return the transformed data
    } catch (erro, stackTrace) {
      log('assfsd');
      return null;
    }
  }
}
