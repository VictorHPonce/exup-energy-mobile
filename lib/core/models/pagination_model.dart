class PaginationModel<T> {
  final int pageIndex;
  final int pageSize;
  final int totalCount;
  final int totalPages;
  final bool hasNextPage;
  final List<T> data;

  PaginationModel({
    required this.pageIndex,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasNextPage,
    required this.data,
  });

  PaginationModel<T> copyWith({
    int? pageIndex,
    int? pageSize,
    int? totalCount,
    int? totalPages,
    bool? hasNextPage,
    List<T>? data,
  }) {
    return PaginationModel<T>(
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
      totalCount: totalCount ?? this.totalCount,
      totalPages: totalPages ?? this.totalPages,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      data: data ?? this.data,
    );
  }

  factory PaginationModel.fromJson(
    Map<String, dynamic> json, 
    T Function(Map<String, dynamic>) fromJsonT
  ) {
    // Extraemos los valores primero para que sea más limpio
    final int pageIndex = json['pageIndex'] as int;
    final int totalPages = json['totalPages'] as int;

    return PaginationModel<T>(
      pageIndex: pageIndex,
      pageSize: json['pageSize'] as int,
      totalCount: json['totalCount'] as int,
      totalPages: totalPages,
      hasNextPage: pageIndex < totalPages, 
      data: (json['data'] as List)
          .map((item) => fromJsonT(item as Map<String, dynamic>))
          .toList(),
    );
  }
}