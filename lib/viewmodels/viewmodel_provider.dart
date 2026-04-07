import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venue_flow_app/viewmodels/home_viewmodel.dart';
import 'package:venue_flow_app/viewmodels/repository_provider.dart';

final homeViewModelProvider = Provider<HomeViewModel>((ref) {
  final formRepository = ref.watch(formRepositoryProvider);
  return HomeViewModel(formRepo: formRepository);
});
