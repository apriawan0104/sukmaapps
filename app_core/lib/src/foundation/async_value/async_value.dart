// lib/src/common/utils/custom_async_value.dart
import 'package:equatable/equatable.dart';

/// Custom AsyncValue implementation without Riverpod dependency
///
/// Supports [skipLoadingOnReload] and [skipError] functionality similar to
/// Riverpod's AsyncValue.
///
/// When [skipLoadingOnReload] is true, [when] shows previous data instead of
/// loading state if available.
///
/// When [skipError] is true, [when] shows previous data instead of error state
/// if available.
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

  /// Whether the async operation resolved to data (including nullable/void).
  bool get hasData => !isLoading && error == null;

  /// Whether a value is available, including previous data during loading/error
  /// and resolved nullable/void data states.
  bool get hasValue => previousData != null || hasData;

  /// Check if the value has error
  bool get hasError => error != null;

  /// Get the data if available, otherwise null
  T? get value => data;

  /// Get previous data for skipLoadingOnReload/skipError functionality
  T? get cachedData => previousData ?? data;

  /// Returns the current or previous value.
  ///
  /// Throws if no value is available.
  T get requireValue {
    if (previousData != null) return previousData as T;
    if (hasData) return data as T;
    if (hasError) throw error!;
    throw StateError(
      'Tried to call requireValue on an AsyncValue that has no value: $this',
    );
  }

  /// Pattern matching method similar to Riverpod's AsyncValue
  ///
  /// [skipLoadingOnReload] - If true and we have cached data, shows cached data
  /// instead of loading state. Useful for search operations and background refresh.
  ///
  /// [skipError] - If true and we have cached data, shows cached data instead of
  /// error state. Useful for background refresh that should keep showing stale data.
  R when<R>({
    required R Function() loading,
    required R Function(T data) data,
    required R Function(Object error, StackTrace? stackTrace) error,
    bool skipLoadingOnReload = false,
    bool skipError = false,
  }) {
    if (isLoading) {
      if (!(skipLoadingOnReload && hasValue)) {
        return loading();
      }
    }

    if (hasError && (!hasValue || !skipError)) {
      return error(this.error!, this.stackTrace);
    }

    return data(requireValue);
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
      previousData: data ?? previousData,
    );
  }

  /// Create an error state while preserving previous data
  ///
  /// Use this method instead of [AsyncValue.error] when you want to preserve
  /// the current data for [skipError] functionality.
  AsyncValue<T> copyWithError(Object error, [StackTrace? stackTrace]) {
    return AsyncValue<T>._(
      isLoading: false,
      data: null,
      error: error,
      stackTrace: stackTrace,
      previousData: data ?? previousData,
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
