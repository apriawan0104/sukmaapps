// lib/src/common/utils/custom_async_value.dart
import 'package:equatable/equatable.dart';

/// Custom AsyncValue implementation without Riverpod dependency
///
/// Supports skipLoadingOnReload functionality similar to Riverpod's AsyncValue.
/// When skipLoadingOnReload is true, the widget will show previous data instead
/// of loading state if available.
class AsyncValue<T> extends Equatable {
  const AsyncValue._({
    required this.isLoading,
    required this.data,
    required this.error,
    this.stackTrace,
    this.previousData,
  });

  const factory AsyncValue.loading() = _Loading<T>;
  const factory AsyncValue.data(T data) = _Data<T>;
  const factory AsyncValue.error(Object error, [StackTrace? stackTrace]) =
      _Error<T>;

  final bool isLoading;
  final T? data;
  final Object? error;
  final StackTrace? stackTrace;
  final T? previousData;

  /// Check if the value is loading
  bool get hasData => !isLoading && error == null && data != null;

  /// Check if the value has error
  bool get hasError => !isLoading && error != null;

  /// Get the data if available, otherwise null
  T? get value => data;

  /// Get previous data for skipLoadingOnReload functionality
  T? get cachedData => previousData ?? data;

  /// Pattern matching method similar to Riverpod's AsyncValue
  ///
  /// [skipLoadingOnReload] - If true and we have cached data, shows cached data
  /// instead of loading state. Useful for search operations and background refresh.
  R when<R>({
    required R Function() loading,
    required R Function(T data) data,
    required R Function(Object error, StackTrace? stackTrace) error,
    bool skipLoadingOnReload = false,
  }) {
    if (isLoading) {
      // If skipLoadingOnReload is true and we have cached data, return the cached data
      if (skipLoadingOnReload && cachedData != null) {
        return data(cachedData as T);
      }
      return loading();
    } else if (this.error != null) {
      return error(this.error!, this.stackTrace);
    } else {
      return data(this.data as T);
    }
  }

  /// Map the data if available
  AsyncValue<R> map<R>(R Function(T data) mapper) {
    if (isLoading) {
      return AsyncValue<R>.loading();
    } else if (error != null) {
      return AsyncValue<R>.error(error!, stackTrace);
    } else {
      return AsyncValue<R>.data(mapper(data as T));
    }
  }

  /// Create a loading state while preserving previous data
  ///
  /// Use this method instead of AsyncValue.loading() when you want
  /// to preserve the current data for skipLoadingOnReload functionality.
  ///
  /// Example:
  /// ```dart
  /// // ❌ Wrong - loses previous data
  /// state = state.copyWith(
  ///   observerValue: const AsyncValue.loading(),
  /// );
  ///
  /// // ✅ Correct - preserves previous data
  /// state = state.copyWith(
  ///   observerValue: state.observerValue.copyWithLoading(),
  /// );
  /// ```
  AsyncValue<T> copyWithLoading() {
    return AsyncValue<T>._(
      isLoading: true,
      data: null,
      error: null,
      previousData: data, // Preserve current data as previous data
    );
  }

  @override
  List<Object?> get props => [isLoading, data, error, stackTrace, previousData];

  @override
  String toString() {
    if (isLoading) return 'AsyncValue.loading()';
    if (error != null) return 'AsyncValue.error($error)';
    return 'AsyncValue.data($data)';
  }
}

class _Loading<T> extends AsyncValue<T> {
  const _Loading()
      : super._(
          isLoading: true,
          data: null,
          error: null,
          previousData: null,
        );
}

class _Data<T> extends AsyncValue<T> {
  const _Data(T data)
      : super._(
          isLoading: false,
          data: data,
          error: null,
          previousData: null,
        );
}

class _Error<T> extends AsyncValue<T> {
  const _Error(Object error, [StackTrace? stackTrace])
      : super._(
          isLoading: false,
          data: null,
          error: error,
          stackTrace: stackTrace,
          previousData: null,
        );
}
