import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:venue_flow_app/core/domain/paged_response.dart';
import 'package:venue_flow_app/features/form/domain/create_form_request.dart';
import 'package:venue_flow_app/features/form/domain/create_form_response.dart';
import 'package:venue_flow_app/features/form/domain/form_list_item.dart';

import '../../../core/network/dio_client.dart';
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
    print('FormRepository.getForms response: ${response}');
    return PagedResponse<FormListId>.fromJson(
      response.data as Map<String, dynamic>,
      (json) => FormListId.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<FormListItem> getFormById({required String formId}) async {
    final response = await _dio.get('/forms/${formId}');
    return FormListItem.fromJson(response.data as Map<String, dynamic>);
  }
}

@riverpod
FormRepository formRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return FormRepository(dio);
}
