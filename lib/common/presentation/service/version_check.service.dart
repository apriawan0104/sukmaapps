import 'package:app_core/app_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../config/config.dart';
import '../../domain/usecase/check_app_version.usecase.dart';
import '../../domain/usecase/init_remote_config.usecase.dart';
import '../widget/partial_update_dialog.widget.dart';

part 'version_check.service.g.dart';

@Riverpod(keepAlive: true)
class VersionCheck extends _$VersionCheck {
  late InitRemoteConfigUseCase _initRemoteConfigUseCase;
  late CheckAppVersionUseCase _checkAppVersionUseCase;

  @override
  Future<void> build() async {
    _initRemoteConfigUseCase = getIt<InitRemoteConfigUseCase>();
    _checkAppVersionUseCase = getIt<CheckAppVersionUseCase>();

    await _initialize();
  }

  Future<void> _initialize() async {
    final initResult = await _initRemoteConfigUseCase(NoParams());
    initResult.fold(
      (failure) {
        if (kDebugMode) {
          print('Remote config initialization error: ${failure.message}');
        }
      },
      (_) {},
    );

    await _checkAndPrompt();
  }

  Future<void> _checkAndPrompt() async {
    final result = await _checkAppVersionUseCase(NoParams());
    result.fold(
      (failure) {
        if (kDebugMode) {
          print('Version check error: ${failure.message}');
        }
      },
      (check) {
        if (!check.needsUpdate) {
          return;
        }

        SchedulerBinding.instance.addPostFrameCallback((_) {
          _showUpdatePrompt(isForceUpdate: check.isForceUpdate);
        });
      },
    );
  }

  void _showUpdatePrompt({required bool isForceUpdate}) {
    final context = rootNavigatorKey.currentContext;
    if (context == null) {
      return;
    }

    if (isForceUpdate) {
      appRouter.goNamed(RouteNames.forceUpdate);
      return;
    }

    PartialUpdateDialog.show(context: context);
  }
}
