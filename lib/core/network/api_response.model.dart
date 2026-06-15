class ApiResponse {
  const ApiResponse({
    this.meta,
    this.data,
  });

  final Meta? meta;
  final dynamic data;

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      meta: json['meta'] is Map<String, dynamic>
          ? Meta.fromJson(json['meta'] as Map<String, dynamic>)
          : null,
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() => {
        'meta': meta?.toJson(),
        'data': data,
      };

  /// Parses a raw HTTP body into [ApiResponse].
  ///
  /// Falls back to wrapping [body] as [data] when it is not a map envelope.
  factory ApiResponse.wrap(dynamic body) {
    if (body is Map<String, dynamic>) {
      return ApiResponse.fromJson(body);
    }
    return ApiResponse(data: body);
  }

  /// Inner `data` when the payload is a JSON object.
  Map<String, dynamic> get payloadMap {
    if (data is Map<String, dynamic>) {
      return data as Map<String, dynamic>;
    }
    return {};
  }

  /// Inner `data` when the payload is a JSON array.
  List<dynamic> get payloadList {
    if (data is List) {
      return data as List<dynamic>;
    }
    return const [];
  }

  /// Shortcut for [ApiResponse.wrap(body).payloadMap].
  static Map<String, dynamic> unwrapMap(dynamic body) =>
      ApiResponse.wrap(body).payloadMap;

  /// Shortcut for [ApiResponse.wrap(body).payloadList].
  static List<dynamic> unwrapList(dynamic body) =>
      ApiResponse.wrap(body).payloadList;
}

class Meta {
  const Meta({
    this.status,
    this.message,
    this.error,
    this.code,
  });

  final String? status;
  final String? message;
  final String? error;
  final int? code;

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      status: json['status'] as String?,
      message: json['message'] as String?,
      error: json['error'] as String?,
      code: json['code'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'error': error,
        'code': code,
      };

  bool get isSuccessful => code != null && code! >= 200 && code! < 300;
}
