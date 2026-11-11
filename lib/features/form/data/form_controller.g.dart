// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FormController)
final formControllerProvider = FormControllerProvider._();

final class FormControllerProvider
    extends $AsyncNotifierProvider<FormController, void> {
  FormControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'formControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$formControllerHash();

  @$internal
  @override
  FormController create() => FormController();
}

String _$formControllerHash() => r'e01cf13f6ef2114e50d4888fd5514bec78e964e6';

abstract class _$FormController extends $AsyncNotifier<void> {
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
