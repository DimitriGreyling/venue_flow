import 'package:freezed_annotation/freezed_annotation.dart';

part 'paged_response.freezed.dart';
part 'paged_response.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class PagedResponse<T> with _$PagedResponse<T> {
  const factory PagedResponse({
    required List<T> items,
    required int page,
    required int pageSize,
    required int totalCount,
    required int totalPages,
  }) = _PagedResponse<T>;

  factory PagedResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object?) fromJsonT,
      ) =>
      _$PagedResponseFromJson(json, fromJsonT);
}