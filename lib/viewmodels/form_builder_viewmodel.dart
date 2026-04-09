// lib/viewmodels/home_viewmodel.dart
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venue_flow_app/models/dynamic_form_model.dart';
import 'package:venue_flow_app/models/form_field_model.dart';
import 'package:venue_flow_app/models/form_page_model.dart';
import 'package:venue_flow_app/repositories/form_repository.dart';
import 'package:venue_flow_app/shared/helpers/storage_helper.dart';

class FormBuilderViewState {
  final List<DynamicFormModel> form;
  final bool isLoading;

  const FormBuilderViewState({
    List<DynamicFormModel>? form,
    this.isLoading = false,
  }) : form = form ?? const [];

  factory FormBuilderViewState.initial() {
    return FormBuilderViewState(
      form: [
        DynamicFormModel(
          name: 'Form Name',
          version: 1,
          pages: [
            FormPageModel(
              title: 'Page 1',
            ),
          ],
        ),
      ],
      isLoading: false,
    );
  }

  FormBuilderViewState copyWith({
    List<DynamicFormModel>? forms,
    bool? isLoading,
    String? error,
  }) {
    return FormBuilderViewState(
      form: forms ?? this.form,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class FormBuilderViewModel extends StateNotifier<FormBuilderViewState> {
  final FormRepository _formRepository;
  final IStorageHelper _storageHelper;

  FormBuilderViewModel({
    required FormRepository formRepo,
    required IStorageHelper storageHelper,
  })  : _formRepository = formRepo,
        _storageHelper = storageHelper,
        super(FormBuilderViewState.initial()) {
    _loadStoredForms();
  }

  // Load stored forms on initialization
  Future<void> _loadStoredForms() async {
    try {
      final storedForms = await loadValuesFromPreferences();
      state = state.copyWith(
        forms: storedForms,
        isLoading: false,
      );
    } catch (e) {
      log('ERROR IN _loadStoredForms: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  Future<List<DynamicFormModel>> loadValuesFromPreferences() async {
    try {      
      final loadedForm = await _storageHelper.loadForm();

      if (loadedForm != null && loadedForm.isNotEmpty) {
        return loadedForm;
      }

      // Return default form if no stored forms exist
      return [
        DynamicFormModel(
          name: 'Form Name',
          version: 1,
          pages: [
            FormPageModel(
              title: 'Page 1',
            ),
          ],
        ),
      ];
    } catch (e) {
      log('ERROR LOADING FORMS: $e');
      // Return default form on error
      return [
        DynamicFormModel(
          name: 'Form Name',
          version: 1,
          pages: [
            FormPageModel(
              title: 'Page 1',
            ),
          ],
        ),
      ];
    }
  }

  // Add a single form field
  void addFormField({
    required FormFieldModel formFieldModel,
  }) async {
    try {
      state = state.copyWith(isLoading: true);
      // Create a new list with the existing forms plus the new field
      final currentForms = state.form ?? [];
      final updatedForms = [...currentForms];

      // If you're adding a field to an existing form, you'd need to specify which form
      // For example, adding to the first form:
      if (updatedForms.isNotEmpty) {
        updatedForms[0].pages?.first.fields ??= [];
        updatedForms[0].pages?.first.fields?.add(formFieldModel);
      } else {
        updatedForms.add(
          DynamicFormModel(
            name: 'Form Name',
            pages: [
              FormPageModel(
                title: 'Page 1',
                fields: [
                  formFieldModel,
                ],
              ),
            ],
          ),
        );
      }

      await _storageHelper.saveForm(state.form.first);

      state = state.copyWith(
        forms: updatedForms,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      // Handle error
    }
  }

  //ADD NEW Page
  void addPage({
    required FormPageModel formPageModel,
  }) {
    try {
      state = state.copyWith(isLoading: true);
      // Create a new list with the existing forms plus the new field
      final currentForms = state.form ?? [];
      final updatedForms = [...currentForms];

      // If you're adding a field to an existing form, you'd need to specify which form
      // For example, adding to the first form:
      if (updatedForms.isNotEmpty) {
        updatedForms[0].pages?.add(formPageModel);
      } else {
        updatedForms.add(
          DynamicFormModel(
            name: 'Form Name',
            pages: [
              formPageModel,
            ],
          ),
        );
      }

      state = state.copyWith(
        forms: updatedForms,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      // Handle error
    }
  }

  //REMOVE FIELD FROM PAGE
  void removeField({
    required FormFieldModel formFieldModel,
    required int index,
  }) async {
    try {
      state = state.copyWith(isLoading: true);
      // Create a new list with the existing forms plus the new field
      final currentForms = state.form ?? [];
      final updatedForms = [...currentForms];

      // If you're adding a field to an existing form, you'd need to specify which form
      // For example, adding to the first form:
      if (updatedForms.isNotEmpty) {
        updatedForms[0].pages?.first.fields?.removeAt(index);
      }

      await _storageHelper.saveForm(state.form.first);

      state = state.copyWith(
        forms: updatedForms,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      // Handle error
    }
  }
}
