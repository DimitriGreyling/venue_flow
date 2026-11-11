import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:venue_flow_app/core/domain/paged_response.dart';
import 'package:venue_flow_app/features/form/domain/create_form_request.dart';
import 'package:venue_flow_app/features/form/domain/create_form_response.dart';
import 'package:venue_flow_app/features/form/domain/form_list_item.dart';
import 'package:venue_flow_app/features/form/domain/form_version.dart';

import '../../../core/enums/form_type.dart';
import '../../../core/network/dio_client.dart';
import '../domain/add_form_version_request.dart';
import '../domain/form_list_id.dart';

part 'form_repository.g.dart';

class FormRepository {
  final Dio _dio;

  FormRepository(this._dio);

  Future<CreateFormResponse> createForm({
    required CreateFormRequest request,
  }) async {
    final response = await _dio.post('/forms', data: request.toJson());
    return CreateFormResponse.fromJson(response.data);
  }

  Future<PagedResponse<FormListId>> getForms({
    required int page,
    required int pageSize,
  }) async {
    final response = await _dio.get(
      '/forms',
      queryParameters: {'page': page, 'pageSize': pageSize},
    );
    return PagedResponse<FormListId>.fromJson(
      response.data as Map<String, dynamic>,
      (json) => FormListId.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<FormListItem> getFormById({required String formId}) async {
    final response = await _dio.get('/forms/${formId}');
    return FormListItem.fromJson(response.data as Map<String, dynamic>);
  }

  Future<List<FormVersion>> loadFormVersionsById({
    required String formId,
  }) async {
    final response = await _dio.get('/forms/$formId/versions');
    final data = response.data;

    // Supports either a direct JSON array or a common wrapped response.
    final List<dynamic> items;

    if (data is List) {
      items = data;
    } else if (data is Map<String, dynamic> && data['items'] is List) {
      items = data['items'] as List<dynamic>;
    } else if (data is Map<String, dynamic> && data['data'] is List) {
      items = data['data'] as List<dynamic>;
    } else {
      throw const FormatException(
        'Unexpected appointments API response format.',
      );
    }

    return items.map((item) => FormVersion.fromJson(item)).toList();
  }

  ///
  /// Add a new form version to an existing form
  ///
  Future<FormVersion> addNewFormVersion({
    required String formId,
    required AddFormVersionRequest addFormVersionRequest,
  }) async {
    final response = await _dio.post(
      '/forms/$formId/form-version',
      data: addFormVersionRequest.toJson(),
    );

    return FormVersion.fromJson(response.data);
  }

  ///
  /// Remove a selected form
  ///
  Future<String> deleteForm({required String formId}) async {
    final response = await _dio.delete('/forms/$formId');

    return response.data;
  }
}

@riverpod
FormRepository formRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return FormRepository(dio);
}
