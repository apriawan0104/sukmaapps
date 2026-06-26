import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

import '../buttons/button_primary.widget.dart';

/// A widget that handles AsyncValue states with support for skipLoadingOnReload
///
/// Usage:
/// ```dart
/// // For search operations - skip loading to show previous data
/// AsyncValueWidget<List<EmployeeEntity>?>(
///   skipLoadingOnReload: true,  // ✅ Shows previous data while loading
///   value: observerValue,
///   onSuccess: (observers) => DropdownWidget(observers),
///   onRetry: () => refreshData(),
/// )
///
/// // For initial load - show loading state
/// AsyncValueWidget<List<EmployeeEntity>?>(
///   skipLoadingOnReload: false, // ✅ Default - shows loading indicator
///   value: observerValue,
///   onSuccess: (observers) => DropdownWidget(observers),
///   onRetry: () => refreshData(),
/// )
/// ```
///
/// Important: When using skipLoadingOnReload: true, make sure to use
/// value.copyWithLoading() instead of AsyncValue.loading() to preserve
/// previous data.
///
/// When using skipError: true, use value.copyWithError() instead of
/// AsyncValue.error() to preserve previous data.
class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    required this.value,
    required this.onSuccess,
    required this.onRetry,
    super.key,
    this.loadingWidget,
    this.errorWidget,
    this.skipError,
    this.skipLoadingOnReload,
  });

  final AsyncValue<T> value;
  final Widget Function(T) onSuccess;
  final VoidCallback onRetry;
  final Widget? loadingWidget;
  final Widget Function(Object, StackTrace)? errorWidget;
  final bool? skipError;
  final bool? skipLoadingOnReload;

  @override
  Widget build(BuildContext context) {
    return value.when(
      skipError: skipError ?? false,
      skipLoadingOnReload: skipLoadingOnReload ?? false,
      data: onSuccess,
      error: (error, stackTrace) {
        if (errorWidget != null) {
          return errorWidget!(
            error,
            stackTrace ?? StackTrace.empty,
          );
        }
        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: REdgeInsets.all(16),
              child: UIButtonPrimaryWidget(
                titleButton: '$error. Tap to retry',
                onPressed: onRetry,
              ),
            ),
          ),
        );
      },
      loading: () =>
          loadingWidget ?? const Center(child: CircularProgressIndicator()),
    );
  }
}
