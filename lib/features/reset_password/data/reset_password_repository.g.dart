// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(resetPasswordRepository)
final resetPasswordRepositoryProvider = ResetPasswordRepositoryProvider._();

final class ResetPasswordRepositoryProvider
    extends
        $FunctionalProvider<
          ResetPasswordRepository,
          ResetPasswordRepository,
          ResetPasswordRepository
        >
    with $Provider<ResetPasswordRepository> {
  ResetPasswordRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resetPasswordRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resetPasswordRepositoryHash();

  @$internal
  @override
  $ProviderElement<ResetPasswordRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ResetPasswordRepository create(Ref ref) {
    return resetPasswordRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResetPasswordRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResetPasswordRepository>(value),
    );
  }
}

String _$resetPasswordRepositoryHash() =>
    r'6a7fba10ff76785182bed69a22a5bfacff364ef6';
