import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:venue_flow_app/constants/supabase_table_names.dart';
import 'package:venue_flow_app/models/dynamic_form_model.dart';

abstract class IFormRepository {
  Future<List<DynamicFormModel>?> getForms();
  Future<List<DynamicFormModel>?> getFormNames();
  Future<DynamicFormModel?> addForm({
    required DynamicFormModel formModel,
  });
  Future<DynamicFormModel?> updateForm({
    required DynamicFormModel formModel,
  });
  Future<List<DynamicFormModel>?> getFormById({
    String? formId,
  });
}

class FormRepository extends IFormRepository {
  //CONSTRUCTOR
  FormRepository({
    required SupabaseClient client,
  }) : _client = client;

  //VARIABLES
  final SupabaseClient _client;
  final String _tableName = SupabaseTableNames.formTable;

  @override
  Future<List<DynamicFormModel>?> getFormById({
    String? formId,
  }) async {
    try {
      if (formId == null) return null;

      final response =
          await _client.from(_tableName).select().eq('id', formId ?? '');

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

  @override
  Future<List<DynamicFormModel>?> getFormNames() async {
    try {
      final response = await _client.from(_tableName).select('id, name');

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

  @override
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

  @override
  Future<DynamicFormModel?> addForm({
    required DynamicFormModel formModel,
  }) async {
    try {
      final test = formModel.toJson();
      final result = await _client
          .from(_tableName)
          .insert(
            formModel.toJson(),
          )
          .select();

      log('testing');
      return DynamicFormModel.fromJson(result[0]);
    } catch (error, stackTrace) {
      log('ERROR :: ${error}');
      throw Exception(error);
    }
  }

  @override
  Future<DynamicFormModel?> updateForm({
    required DynamicFormModel formModel,
  }) async {
    try {
      final result = await _client
          .from(_tableName)
          .update(
            formModel.toJson(),
          )
          .eq('id', formModel.id ?? '')
          .select();

      log('testing');
      return DynamicFormModel.fromJson(result[0]);
    } catch (error, stackTrace) {
      throw Exception(error);
    }
  }
}
