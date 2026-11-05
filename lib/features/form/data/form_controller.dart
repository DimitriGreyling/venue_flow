import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:venue_flow_app/features/form/domain/create_form_response.dart';

import '../domain/create_form_request.dart';
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
}
