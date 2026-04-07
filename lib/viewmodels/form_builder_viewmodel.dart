// lib/viewmodels/home_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/models/dynamic_form_model.dart';
import 'package:venue_flow_app/models/form_field_model.dart';
import 'package:venue_flow_app/models/form_page_model.dart';
import 'package:venue_flow_app/repositories/form_repository.dart';

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

  FormBuilderViewModel({
    required FormRepository formRepo,
  })  : _formRepository = formRepo,
        super(FormBuilderViewState.initial());

  // Add a single form field
  void addFormField({
    required FormFieldModel formFieldModel,
  }) {
    try {
      state = state.copyWith(isLoading: true);
      // Create a new list with the existing forms plus the new field
      final currentForms = state.form ?? [];
      final updatedForms = [...currentForms];

      // If you're adding a field to an existing form, you'd need to specify which form
      // For example, adding to the first form:
      if (updatedForms.isNotEmpty) {
        updatedForms[0].pages?.first.fields ??=[];
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
}
