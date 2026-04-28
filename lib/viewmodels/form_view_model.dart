// lib/viewmodels/home_viewmodel.dart
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venue_flow_app/models/dynamic_form_model.dart';
import 'package:venue_flow_app/models/enums.dart';
import 'package:venue_flow_app/models/form_field_model.dart';
import 'package:venue_flow_app/models/form_page_model.dart';
import 'package:venue_flow_app/models/form_submission_model.dart';
import 'package:venue_flow_app/models/user_model.dart';
import 'package:venue_flow_app/repositories/form_repository.dart';
import 'package:venue_flow_app/repositories/form_submission_repository.dart';
import 'package:venue_flow_app/shared/helpers/storage_helper.dart';

class FormViewBuilderViewState {
  final List<DynamicFormModel> form;
  final bool isLoading;

  const FormViewBuilderViewState({
    List<DynamicFormModel>? form,
    this.isLoading = false,
  }) : form = form ?? const [];

  factory FormViewBuilderViewState.initial() {
    return FormViewBuilderViewState(
      form: [
        DynamicFormModel(
          name: 'Form Name',
          version: 1,
          isActive: true,
          formStatus: FormStatus.draft,
          schema: [
            FormPageModel(
              title: 'Page 1',
            ),
          ],
        ),
      ],
      isLoading: false,
    );
  }

  FormViewBuilderViewState copyWith({
    List<DynamicFormModel>? forms,
    bool? isLoading,
    String? error,
  }) {
    return FormViewBuilderViewState(
      form: forms ?? this.form,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class FormViewBuilderViewModel extends StateNotifier<FormViewBuilderViewState> {
  final IFormRepository _formRepository;
  final IStorageHelper _storageHelper;
  final IFormSubmissionRepository _formSubmissionRepository;
  final UserModel? Function() _getCurrentUser;

  FormViewBuilderViewModel({
    required IFormRepository formRepo,
    required IStorageHelper storageHelper,
    required IFormSubmissionRepository formSubmissionRepository,
    required UserModel? Function() getCurrentUser,
  })  : _formRepository = formRepo,
        _storageHelper = storageHelper,
        _getCurrentUser = getCurrentUser,
        _formSubmissionRepository = formSubmissionRepository,
        super(FormViewBuilderViewState(form: [], isLoading: false)) {}

  Future<void> loadForm() async {
    try {
      state = state.copyWith(isLoading: true);

      final result = await _formRepository.getForms();

      state = state.copyWith(
        forms: result,
        isLoading: false,
      );
    } catch (error, stackTrace) {
      state = state.copyWith(isLoading: false);
    }
  }

  UserModel? get currentUser => _getCurrentUser();

  Future<void> handleSubmit({
    required GlobalKey<FormState> formKey,
    required Map<String, dynamic> formValues,
  }) async {
    final formState = formKey.currentState;
    if (formState == null) {
      return;
    }

    if (!formState.validate()) {
      return;
    }

    formState.save();

    // final formViewState = ref.read(formViewBuilderViewModelProvider);
    final currentForm = state.form.first;
    //     formViewState.form.isNotEmpty ? formViewState.form.first : null;
    // final currentUser =
    //     ref.read(formViewBuilderViewModelProvider.notifier).currentUser;

    // if (currentForm == null || currentUser == null) {
    //   return;
    // }

    if (currentUser == null) {
      throw Exception('User cannot be found');
    }

    final submission = FormSubmission.fromFormValues(
      form: currentForm,
      user: currentUser!,
      values: formValues,
    );

    log('FORM VALUES :: $formValues');
    log('FORM SUBMISSION :: ${submission.toJsonString()}');

    final response = await _formSubmissionRepository.saveFormSubmission(submittedForm: submission);

    // if (!mounted) {
    //   return;
    // }

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('Captured ${_formValues.length} field values.')),
    // );
  }
}
