import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:venue_flow_app/features/form/domain/create_form_response.dart';

import '../../../core/domain/paged_response.dart';
import '../domain/create_form_request.dart';
import '../domain/form_list_id.dart';
import '../domain/form_list_item.dart';
import '../domain/form_version.dart';
import 'form_repository.dart';

part 'form_controller.g.dart';

@riverpod
class FormController extends _$FormController {
  @override
  FutureOr<void> build() {}

  Future<CreateFormResponse> createForm({
    required CreateFormRequest request,
  }) async {
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

  Future<FormListItem> getFormById({required String formId}) async {
    final respository = ref.watch(formRepositoryProvider);
    return await respository.getFormById(formId: formId);
  }

  Future<List<FormVersion>> loadFormVersionsById({
    required String formId,
  }) async {
    final repository = ref.watch(formRepositoryProvider);
    return await repository.loadFormVersionsById(formId: formId);
  }

  ///
  /// Add a new form version to an existing form
  ///
  Future<FormVersion> addNewFormVersion({
    required String formId,
    required FormVersion formVersion,
  }) async {
    final repository = ref.watch(formRepositoryProvider);

    return await repository.addNewFormVersion(
      formId: formId,
      formVersion: formVersion,
    );
  }

  ///
  /// Remove a selected form
  ///
  Future<String> deleteForm({required String formId}) async {
    final repository = ref.watch(formRepositoryProvider);

    return await repository.deleteForm(formId: formId);
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
