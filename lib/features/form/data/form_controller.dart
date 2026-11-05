import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:venue_flow_app/features/form/domain/create_form_response.dart';

import '../../../core/domain/paged_response.dart';
import '../domain/create_form_request.dart';
import '../domain/form_list_id.dart';
import '../domain/form_list_item.dart';
import 'form_repository.dart';

part 'form_controller.g.dart';

@riverpod
class FormController extends _$FormController {
  @override
  FutureOr<void> build() {}

  Future<CreateFormResponse> createForm({required CreateFormRequest request}) async {
    final respository = ref.watch(formRepositoryProvider);
    return await respository.createForm(request: request);
  }

  Future<PagedResponse<FormListId>> getForms({
    required int page,
    required int pageSize,
  }) async {
    final respository = ref.watch(formRepositoryProvider);
    return await respository.getForms(page: page, pageSize: pageSize);
  }

  Future<FormListItem> getFormById({
    required String formId,
  }) async {
    final respository = ref.watch(formRepositoryProvider);
    return await respository.getFormById(formId: formId);
  }
}

@riverpod
class FormDetails extends _$FormDetails {
  @override
  Future<FormListItem> build(String formId) async {
    final respository = ref.watch(formRepositoryProvider);
    return await respository.getFormById(formId: formId);
  }
}