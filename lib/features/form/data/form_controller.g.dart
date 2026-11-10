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

String _$formControllerHash() => r'50e9b9354e00448a5893c4ebfda0e624d8e8e428';

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

@ProviderFor(FormDetails)
final formDetailsProvider = FormDetailsFamily._();

final class FormDetailsProvider
    extends $AsyncNotifierProvider<FormDetails, FormListItem> {
  FormDetailsProvider._({
    required FormDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'formDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$formDetailsHash();

  @override
  String toString() {
    return r'formDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FormDetails create() => FormDetails();

  @override
  bool operator ==(Object other) {
    return other is FormDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$formDetailsHash() => r'55f4a3662c934c14f5502900ecc01b5fb29d391b';

final class FormDetailsFamily extends $Family
    with
        $ClassFamilyOverride<
          FormDetails,
          AsyncValue<FormListItem>,
          FormListItem,
          FutureOr<FormListItem>,
          String
        > {
  FormDetailsFamily._()
    : super(
        retry: null,
        name: r'formDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FormDetailsProvider call(String formId) =>
      FormDetailsProvider._(argument: formId, from: this);

  @override
  String toString() => r'formDetailsProvider';
}

abstract class _$FormDetails extends $AsyncNotifier<FormListItem> {
  late final _$args = ref.$arg as String;
  String get formId => _$args;

  FutureOr<FormListItem> build(String formId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<FormListItem>, FormListItem>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<FormListItem>, FormListItem>,
              AsyncValue<FormListItem>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
