import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/providers/auth_provider.dart';
import 'package:venue_flow_app/providers/sotrage_provider.dart';
import 'package:venue_flow_app/repositories/form_submission_repository.dart';
import 'package:venue_flow_app/viewmodels/form_builder_viewmodel.dart';
import 'package:venue_flow_app/viewmodels/form_view_builder_view_model.dart';
import 'package:venue_flow_app/viewmodels/home_viewmodel.dart';
import 'package:venue_flow_app/providers/repository_provider.dart';

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, HomeViewState>((ref) {
  final formRepository = ref.watch(formRepositoryProvider);
  return HomeViewModel(formRepo: formRepository);
});

final formBuilderViewModelProvider =
    StateNotifierProvider<FormBuilderViewModel, FormBuilderViewState>((ref) {
  final formRepository = ref.watch(formRepositoryProvider);
  final storageHelper = ref.watch(storageHelperProvider);
  final currentUser = ref.watch(currentUserProvider);

  return FormBuilderViewModel(
    formRepo: formRepository,
    storageHelper: storageHelper,
    getCurrentUser: () => ref.read(currentUserProvider),
  );
});

final formViewBuilderViewModelProvider =
    StateNotifierProvider<FormViewBuilderViewModel, FormViewBuilderViewState>(
        (ref) {
  final formRepository = ref.watch(formRepositoryProvider);
  final storageHelper = ref.watch(storageHelperProvider);
  final formSubmissionRepository = ref.watch(formSubmissionRepositoryProvider);

  return FormViewBuilderViewModel(
    formRepo: formRepository,
    storageHelper: storageHelper,
    formSubmissionRepository: formSubmissionRepository,
    getCurrentUser: () => ref.read(currentUserProvider),
  );
});
