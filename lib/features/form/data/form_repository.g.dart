// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(formRepository)
final formRepositoryProvider = FormRepositoryProvider._();

final class FormRepositoryProvider
    extends $FunctionalProvider<FormRepository, FormRepository, FormRepository>
    with $Provider<FormRepository> {
  FormRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'formRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$formRepositoryHash();

  @$internal
  @override
  $ProviderElement<FormRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FormRepository create(Ref ref) {
    return formRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FormRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FormRepository>(value),
    );
  }
}

String _$formRepositoryHash() => r'1e8e38ef3f255a37d076afb762a0b57d45c69ecb';
