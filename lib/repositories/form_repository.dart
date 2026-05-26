import 'dart:developer';

import 'package:venue_flow_app/constants/api_contract.dart';
import 'package:venue_flow_app/models/dynamic_form_model.dart';
import 'package:venue_flow_app/shared/helpers/api_client.dart';

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
  FormRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<List<DynamicFormModel>?> getFormById({
    String? formId,
  }) async {
    try {
      if (formId == null) return null;

      final response = await _apiClient.dio.get(ApiEndpoints.formById(formId));
      final form = _extractForm(response.data);
      if (form == null) {
        return null;
      }

      return [form];
    } catch (error) {
      log('getFormById error: $error');
      return null;
    }
  }

  @override
  Future<List<DynamicFormModel>?> getFormNames() async {
    try {
      final response = await _apiClient.dio.get(ApiEndpoints.forms+"/MenuItems",
      //  queryParameters: {
      //   ApiQueryKeys.fields: 'id,name',
      // }
      );

      return _extractFormList(response.data);
    } catch (error) {
      log('getFormNames error: $error');
      return null;
    }
  }

  @override
  Future<List<DynamicFormModel>?> getForms() async {
    try {
      final response = await _apiClient.dio.get(ApiEndpoints.forms);
      return _extractFormList(response.data);
    } catch (error) {
      log('getForms error: $error');
      return null;
    }
  }

  @override
  Future<DynamicFormModel?> addForm({
    required DynamicFormModel formModel,
  }) async {
    try {
      final response = await _apiClient.dio.post(ApiEndpoints.forms, data: formModel.toJson());
      return _extractForm(response.data);
    } catch (error) {
      log('addForm error: $error');
      throw Exception(error);
    }
  }

  @override
  Future<DynamicFormModel?> updateForm({
    required DynamicFormModel formModel,
  }) async {
    try {
      final formId = formModel.id;
      if (formId == null || formId.isEmpty) {
        throw Exception('Form id is required for updates.');
      }

      final response = await _apiClient.dio.put(ApiEndpoints.formById(formId), data: formModel.toJson());
      return _extractForm(response.data);
    } catch (error) {
      throw Exception(error);
    }
  }

  DynamicFormModel? _extractForm(dynamic body) {
    if (body is Map<String, dynamic>) {
      if (body['data'] is Map<String, dynamic>) {
        return DynamicFormModel.fromJson(body['data'] as Map<String, dynamic>);
      }
      return DynamicFormModel.fromJson(body);
    }

    if (body is List && body.isNotEmpty && body.first is Map<String, dynamic>) {
      return DynamicFormModel.fromJson(body.first as Map<String, dynamic>);
    }

    return null;
  }

  List<DynamicFormModel>? _extractFormList(dynamic body) {
    if (body is List) {
      return body
          .whereType<Map<String, dynamic>>()
          .map(DynamicFormModel.fromJson)
          .toList();
    }

    if (body is Map<String, dynamic> && body['data'] is List) {
      return (body['data'] as List)
          .whereType<Map<String, dynamic>>()
          .map(DynamicFormModel.fromJson)
          .toList();
    }

    return null;
  }
}
