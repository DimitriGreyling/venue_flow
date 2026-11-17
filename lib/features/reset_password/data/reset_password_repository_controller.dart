import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:venue_flow_app/features/reset_password/data/reset_password_repository.dart';
import 'package:venue_flow_app/features/reset_password/domain/reset_password_request.dart';

part 'reset_password_repository_controller.g.dart';

@riverpod
class ResetPasswordRepositoryController
    extends _$ResetPasswordRepositoryController {
  @override
  FutureOr<void> build() {}

  Future<void> resetPassword({
    required ResetPasswordRequest resetPasswordRequest,
  }) async {
    final respository = ref.watch(resetPasswordRepositoryProvider);
    await respository.resetPassword(resetPasswordRequest: resetPasswordRequest);
  }
}
