// lib/viewmodels/home_viewmodel.dart
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venue_flow_app/models/dynamic_form_model.dart';
import 'package:venue_flow_app/models/enums.dart';
import 'package:venue_flow_app/models/form_field_model.dart';
import 'package:venue_flow_app/models/form_page_model.dart';
import 'package:venue_flow_app/models/popup_position.dart';
import 'package:venue_flow_app/models/user_model.dart';
import 'package:venue_flow_app/repositories/form_repository.dart';
import 'package:venue_flow_app/shared/helpers/global_popup_service.dart';
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
  final IFormRepository _formRepository;
  final IStorageHelper _storageHelper;
  final UserModel? Function() _getCurrentUser;

  FormBuilderViewModel({
    required IFormRepository formRepo,
    required IStorageHelper storageHelper,
    required UserModel? Function() getCurrentUser,
  })  : _formRepository = formRepo,
        _storageHelper = storageHelper,
        _getCurrentUser = getCurrentUser,
        super(FormBuilderViewState.initial()) {
    _loadStoredForms();
  }

  UserModel? get currentUser => _getCurrentUser();

  Future<List<DynamicFormModel>?> getFormNames() async {
    try {
      final result = _formRepository.getFormNames();

      return result;
    } catch (error) {
      return [];
    }
  }

  Future<List<DynamicFormModel>?> loadForms() async {
    try {
      final result = _formRepository.getForms();

      return result;
    } catch (error) {
      return [];
    }
  }

  Future<void> loadForm({
    required String formId,
  }) async {
    try {
      state = state.copyWith(isLoading: true);
      await Future.delayed(const Duration(seconds: 10));
      final result = await _formRepository.getForms();

      state = state.copyWith(isLoading: false, forms: result);
    } catch (error) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> setForm({
    String? formId,
    DynamicFormModel? formModel,
  }) async {
    try {
      state = state.copyWith(
        isLoading: true,
      );

      if (formModel != null) {
        await _storageHelper.saveForm(formModel);
        state = state.copyWith(
          forms: [formModel],
          isLoading: false,
        );
      } else if (formId != null) {
        final form = await _formRepository.getFormById(formId: formId);
        await _storageHelper.saveForm(form!.first);
        state = state.copyWith(
          forms: form,
          isLoading: false,
        );
      } else {
        final loadedForm = await _storageHelper.loadForm();

        state = state.copyWith(
          forms: loadedForm,
          isLoading: false,
        );
      }
    } catch (error) {}
  }

  // Load stored forms on initialization
  Future<void> _loadStoredForms() async {
    try {
      final storedForms = await _loadValuesFromPreferences();
      state = state.copyWith(
        forms: storedForms,
        isLoading: false,
      );
    } catch (e) {
      log('ERROR IN _loadStoredForms: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  Future<List<DynamicFormModel>> _loadValuesFromPreferences() async {
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
          schema: [
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
          schema: [
            FormPageModel(
              title: 'Page 1',
            ),
          ],
        ),
      ];
    }
  }

  // Add a single form field
  void addFormField(
      {required FormFieldModel formFieldModel, required int index}) async {
    try {
      state = state.copyWith(isLoading: true);
      // Create a new list with the existing forms plus the new field
      final currentForms = state.form;
      final updatedForms = [...currentForms];

      // If you're adding a field to an existing form, you'd need to specify which form
      // For example, adding to the first form:
      if (updatedForms.isNotEmpty) {
        updatedForms[0].schema![index].fields ??= [];
        updatedForms[0].schema![index].fields?.add(formFieldModel);
      } else {
        updatedForms.add(
          DynamicFormModel(
            name: 'Form Name',
            schema: [
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
      final currentForms = state.form;
      final updatedForms = [...currentForms];

      // If you're adding a field to an existing form, you'd need to specify which form
      // For example, adding to the first form:
      if (updatedForms.isNotEmpty) {
        updatedForms[0].schema?.add(formPageModel);
      } else {
        updatedForms.add(
          DynamicFormModel(
            name: 'Form Name',
            schema: [
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
      final currentForms = state.form;
      final updatedForms = [...currentForms];

      // If you're adding a field to an existing form, you'd need to specify which form
      // For example, adding to the first form:
      if (updatedForms.isNotEmpty) {
        updatedForms[0].schema?.first.fields?.removeAt(index);
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

  void updateFormName(String newName, int index) async {
    try {
      state = state.copyWith(isLoading: true);
      // Create a new list with the existing forms plus the new field
      final currentForms = state.form;
      final updatedForms = [...currentForms];

      // If you're adding a field to an existing form, you'd need to specify which form
      // For example, adding to the first form:
      if (updatedForms.isNotEmpty) {
        updatedForms[0].name = newName;
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

  void updatePageName(String newName, int index) async {
    try {
      state = state.copyWith(isLoading: true);
      // Create a new list with the existing forms plus the new field
      final currentForms = state.form;
      final updatedForms = [...currentForms];

      // If you're adding a field to an existing form, you'd need to specify which form
      // For example, adding to the first form:
      if (updatedForms.isNotEmpty) {
        updatedForms[0].schema![index].title = newName;
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

  void addFormPage() async {
    try {
      state = state.copyWith(isLoading: true);
      // Create a new list with the existing forms plus the new field
      final currentForms = state.form;
      final updatedForms = [...currentForms];

      // If you're adding a field to an existing form, you'd need to specify which form
      // For example, adding to the first form:
      if (updatedForms.isNotEmpty) {
        updatedForms[0].schema?.add(
              FormPageModel(
                title: 'Form Page',
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

  void removePage(int index) async {
    try {
      state = state.copyWith(isLoading: true);
      // Create a new list with the existing forms plus the new field
      final currentForms = state.form;
      final updatedForms = [...currentForms];

      // If you're adding a field to an existing form, you'd need to specify which form
      // For example, adding to the first form:
      if (updatedForms.isNotEmpty) {
        updatedForms[0].schema?.removeAt(index);
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

  void duplicateFiel(FormFieldModel formFieldModel, int index) async {
    try {
      state = state.copyWith(isLoading: true);
      // Create a new list with the existing forms plus the new field
      final currentForms = state.form;
      final updatedForms = [...currentForms];

      // If you're adding a field to an existing form, you'd need to specify which form
      // For example, adding to the first form:
      if (updatedForms.isNotEmpty) {
        updatedForms[0].schema![index].fields!.add(formFieldModel);
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

  void updateOrderOfList(
      List<FormFieldModel> reorderedList, int pageIndex) async {
    try {
      state = state.copyWith(isLoading: true);
      // Create a new list with the existing forms plus the new field
      final currentForms = state.form;
      final updatedForms = [...currentForms];

      // If you're adding a field to an existing form, you'd need to specify which form
      // For example, adding to the first form:
      if (updatedForms.isNotEmpty) {
        updatedForms[0].schema![pageIndex].fields = reorderedList;
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

  void saveForm({required FormStatus formStatus}) async {
    try {
      state = state.copyWith(isLoading: true);

      state.form.first.formStatus = formStatus;

      DynamicFormModel? result;

      state.form.first.tenantId = currentUser?.tenantId;

      if (state.form.first.id == null) {
        result = await _formRepository.addForm(formModel: state.form.first);
      } else {
        await incrementVersion();
        result = await _formRepository.updateForm(formModel: state.form.first);
      }

      if (result == null) {
        throw Exception('Something happend when saving form');
      }

      GlobalPopupService.showSuccess(
        title: 'Saved',
        message: 'Form has been saved.',
        position: PopupPosition.bottomRight,
      );

      state = state.copyWith(
        forms: [result],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      // Handle error
    }
  }

  Future<void> incrementVersion() async {
    try {
      state = state.copyWith(isLoading: true);
      final currentForms = [...state.form];

      if (currentForms.isNotEmpty) {
        final currentVersion = currentForms[0].version ?? 1;
        currentForms[0] = currentForms[0].copyWith(version: currentVersion + 1);

        await _storageHelper.saveForm(currentForms[0]);

        state = state.copyWith(forms: currentForms, isLoading: false);
        log('Version incremented to: ${currentVersion + 1}');
      }
    } catch (e) {
      log('Error incrementing version: $e');
      state = state.copyWith(isLoading: false);
    }
  }
}
