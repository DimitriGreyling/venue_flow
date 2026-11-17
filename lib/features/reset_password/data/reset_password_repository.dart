import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:venue_flow_app/features/reset_password/domain/reset_password_request.dart';

import '../../../core/network/dio_client.dart';

part 'reset_password_repository.g.dart';

class ResetPasswordRepository {
  final Dio _dio;

  ResetPasswordRepository(this._dio);

  Future<void> resetPassword({
    required ResetPasswordRequest resetPasswordRequest,
  }) async {
    final response = await this._dio.post(
      '/auth/reset-password',
      data: resetPasswordRequest.toJson(),
    );

    // return response.data as bool?;
  }
}

@riverpod
ResetPasswordRepository resetPasswordRepository(Ref ref){
  return ResetPasswordRepository(ref.watch(dioProvider));
}