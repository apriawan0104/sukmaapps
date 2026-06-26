import 'package:app_core/app_core.dart';

import 'sukma_failure_message.resolver.dart';

/// Decorates [HttpClient] to map Sukma API error messages from `meta.error`.
class SukmaHttpClient implements HttpClient {
  SukmaHttpClient(this._inner);

  final HttpClient _inner;

  Future<Result<NetworkFailure, T>> _mapResult<T>(
    Future<Result<NetworkFailure, T>> future,
  ) async {
    final result = await future;
    return result.fold(
      (failure) => ResultExtension.failure<NetworkFailure, T>(
        SukmaFailureMessageResolver.mapFailure(failure),
      ),
      ResultExtension.success<NetworkFailure, T>,
    );
  }

  @override
  String get baseUrl => _inner.baseUrl;

  @override
  Map<String, dynamic> get defaultHeaders => _inner.defaultHeaders;

  @override
  int get connectTimeout => _inner.connectTimeout;

  @override
  int get receiveTimeout => _inner.receiveTimeout;

  @override
  Future<Result<NetworkFailure, HttpResponseEntity<T>>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    RequestOptionsEntity? options,
  }) {
    return _mapResult(
      _inner.get<T>(
        path,
        queryParameters: queryParameters,
        headers: headers,
        options: options,
      ),
    );
  }

  @override
  Future<Result<NetworkFailure, HttpResponseEntity<T>>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    RequestOptionsEntity? options,
  }) {
    return _mapResult(
      _inner.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        headers: headers,
        options: options,
      ),
    );
  }

  @override
  Future<Result<NetworkFailure, HttpResponseEntity<T>>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    RequestOptionsEntity? options,
  }) {
    return _mapResult(
      _inner.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        headers: headers,
        options: options,
      ),
    );
  }

  @override
  Future<Result<NetworkFailure, HttpResponseEntity<T>>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    RequestOptionsEntity? options,
  }) {
    return _mapResult(
      _inner.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        headers: headers,
        options: options,
      ),
    );
  }

  @override
  Future<Result<NetworkFailure, HttpResponseEntity<T>>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    RequestOptionsEntity? options,
  }) {
    return _mapResult(
      _inner.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        headers: headers,
        options: options,
      ),
    );
  }

  @override
  Future<Result<NetworkFailure, HttpResponseEntity<T>>> request<T>(
    RequestOptionsEntity options,
  ) {
    return _mapResult(_inner.request<T>(options));
  }

  @override
  Future<Result<NetworkFailure, String>> download(
    String url,
    String savePath, {
    void Function(int received, int total)? onProgress,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return _mapResult(
      _inner.download(
        url,
        savePath,
        onProgress: onProgress,
        queryParameters: queryParameters,
        headers: headers,
      ),
    );
  }

  @override
  Future<Result<NetworkFailure, HttpResponseEntity<T>>> upload<T>(
    String path,
    String filePath, {
    String fieldName = 'file',
    Map<String, dynamic>? data,
    void Function(int sent, int total)? onProgress,
    Map<String, dynamic>? headers,
  }) {
    return _mapResult(
      _inner.upload<T>(
        path,
        filePath,
        fieldName: fieldName,
        data: data,
        onProgress: onProgress,
        headers: headers,
      ),
    );
  }

  @override
  void addRequestInterceptor(RequestInterceptor interceptor) =>
      _inner.addRequestInterceptor(interceptor);

  @override
  void addResponseInterceptor(ResponseInterceptor interceptor) =>
      _inner.addResponseInterceptor(interceptor);

  @override
  void addErrorInterceptor(ErrorInterceptor interceptor) =>
      _inner.addErrorInterceptor(interceptor);

  @override
  void clearInterceptors() => _inner.clearInterceptors();

  @override
  void cancelAllRequests() => _inner.cancelAllRequests();

  @override
  void cancelRequest(String tag) => _inner.cancelRequest(tag);
}
