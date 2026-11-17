// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_repository_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ResetPasswordRepositoryController)
final resetPasswordRepositoryControllerProvider =
    ResetPasswordRepositoryControllerProvider._();

final class ResetPasswordRepositoryControllerProvider
    extends $AsyncNotifierProvider<ResetPasswordRepositoryController, void> {
  ResetPasswordRepositoryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resetPasswordRepositoryControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$resetPasswordRepositoryControllerHash();

  @$internal
  @override
  ResetPasswordRepositoryController create() =>
      ResetPasswordRepositoryController();
}

String _$resetPasswordRepositoryControllerHash() =>
    r'cc3fb2a91ffce8c5dd5de15905cd4ff5ce8e20a1';

abstract class _$ResetPasswordRepositoryController
    extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
