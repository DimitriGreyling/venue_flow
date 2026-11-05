import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:venue_flow_app/features/form/domain/create_form_request.dart';
import 'package:venue_flow_app/features/form/domain/create_form_response.dart';

import '../../../core/network/dio_client.dart';

part 'form_repository.g.dart';

class FormRepository {
  final Dio _dio;

  FormRepository(this._dio);

  Future<CreateFormResponse> createForm({required CreateFormRequest request}) async {
    final response = await _dio.post('/forms', data: request.toJson());
    return CreateFormResponse.fromJson(response.data);
  }
}

@riverpod
FormRepository formRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return FormRepository(dio);
}
