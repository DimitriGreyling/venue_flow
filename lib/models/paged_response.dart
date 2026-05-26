import 'dart:math' as math;

class PagedResponse<T> {
  final List<T> data;
  final int pageNumber;
  final int pageSize;
  final int totalRecords;
  final int totalPages;

  const PagedResponse({
    required this.data,
    required this.pageNumber,
    required this.pageSize,
    required this.totalRecords,
    required this.totalPages,
  });

  factory PagedResponse.create({
    required List<T> data,
    required int pageNumber,
    required int pageSize,
    required int totalRecords,
  }) {
    final safePageSize = pageSize <= 0 ? 1 : pageSize;
    final computedTotalPages = (totalRecords / safePageSize).ceil();

    return PagedResponse<T>(
      data: data,
      pageNumber: pageNumber,
      pageSize: pageSize,
      totalRecords: totalRecords,
      totalPages: math.max(1, computedTotalPages),
    );
  }

  bool get hasPreviousPage => pageNumber > 1;
  bool get hasNextPage => pageNumber < totalPages;

  PagedResponse<T> copyWith({
    List<T>? data,
    int? pageNumber,
    int? pageSize,
    int? totalRecords,
    int? totalPages,
  }) {
    return PagedResponse<T>(
      data: data ?? this.data,
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
      totalRecords: totalRecords ?? this.totalRecords,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  Map<String, dynamic> toJson(
    Map<String, dynamic> Function(T item) toJsonT,
  ) {
    return {
      'data': data.map(toJsonT).toList(),
      'page_number': pageNumber,
      'page_size': pageSize,
      'total_records': totalRecords,
      'total_pages': totalPages,
      'has_previous_page': hasPreviousPage,
      'has_next_page': hasNextPage,
    };
  }

  factory PagedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> itemJson) fromJsonT,
  ) {
    final rawData = (json['data']['data'] as List?) ?? const [];

    final parsedData = rawData
        .map((e) => fromJsonT(Map<String, dynamic>.from(e as Map)))
        .toList();

    final pageNumber = (json['page_number'] as num?)?.toInt() ?? 1;
    final pageSize = (json['page_size'] as num?)?.toInt() ?? 0;
    final totalRecords = (json['total_records'] as num?)?.toInt() ?? 0;

    final totalPages = (json['total_pages'] as num?)?.toInt() ??
        ((pageSize <= 0 ? 0 : (totalRecords / pageSize).ceil()));

    return PagedResponse<T>(
      data: parsedData,
      pageNumber: pageNumber,
      pageSize: pageSize,
      totalRecords: totalRecords,
      totalPages: totalPages,
    );
  }
}