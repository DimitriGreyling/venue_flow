// lib/viewmodels/home_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/models/dynamic_form_model.dart';
import 'package:venue_flow_app/repositories/form_repository.dart';
import 'package:venue_flow_app/providers/repository_provider.dart';

class HomeViewState {
  final List<DynamicFormModel>? forms;
  final bool isLoading;
  final String? error;

  const HomeViewState({
    this.forms,
    this.isLoading = false,
    this.error,
  });

  HomeViewState copyWith({
    List<DynamicFormModel>? forms,
    bool? isLoading,
    String? error,
  }) {
    return HomeViewState(
      forms: forms ?? this.forms,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class HomeViewModel extends StateNotifier<HomeViewState> {
  final FormRepository _formRepository;

  HomeViewModel({
    required FormRepository formRepo,
  })  : _formRepository = formRepo,
        super(const HomeViewState());

  Future<void> loadForms() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final forms = await _formRepository.getForms();
      state = state.copyWith(forms: forms, isLoading: false);
    } catch (error) {
      state = state.copyWith(error: error.toString(), isLoading: false);
    }
  }

  void refreshForms() => loadForms();
}
