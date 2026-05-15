import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/app.dart';
import '../text/text_primary.widget.dart';

class AsyncValueSharedWidget<T> extends StatelessWidget {
  static Widget errorTextRetry(
      {required String error,
      required VoidCallback onPressed,
      Color? fontColor}) {
    return SingleChildScrollView(
        child: TextButton(
      onPressed: onPressed,
      child: UITextPrimaryWidget(
        title: '$error. Tap to retry',
        fontSize: 12.sp,
        color: AppColor.blackRoot,
        fontWeight: FontWeight.w700,
      ),
    ));
  }

  const AsyncValueSharedWidget(
      {super.key,
      required this.value,
      required this.data,
      this.customLoading,
      this.onError,
      required this.onPressed,
      this.skipError,
      this.skipLoadingOnReload});

  final AsyncValue<T> value;
  final Widget Function(T) data;
  final Widget? customLoading;
  final Widget Function(Object, StackTrace)? onError;
  final VoidCallback onPressed;
  final bool? skipError;
  final bool? skipLoadingOnReload;

  @override
  Widget build(BuildContext context) {
    return value.when(
      skipError: skipError ?? false,
      skipLoadingOnReload: skipLoadingOnReload ?? false,
      data: data,
      error: onError ??
          (e, st) => Center(
                child: errorTextRetry(
                  error: e.toString(),
                  onPressed: onPressed,
                ),
              ),
      loading: () =>
          customLoading ??
          const Center(
            child: CircularProgressIndicator(),
          ),
    );
  }
}
