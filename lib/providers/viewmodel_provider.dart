import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/providers/sotrage_provider.dart';
import 'package:venue_flow_app/viewmodels/form_builder_viewmodel.dart';
import 'package:venue_flow_app/viewmodels/home_viewmodel.dart';
import 'package:venue_flow_app/providers/repository_provider.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel,HomeViewState>((ref) {
  final formRepository = ref.watch(formRepositoryProvider);
  return HomeViewModel(formRepo: formRepository);
});


final formBuilderViewModelProvider = StateNotifierProvider<FormBuilderViewModel,FormBuilderViewState>((ref) {
  final formRepository = ref.watch(formRepositoryProvider);
  final storageHelper = ref.watch(storageHelperProvider);

  return FormBuilderViewModel(formRepo: formRepository,storageHelper: storageHelper);
});
