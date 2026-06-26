import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:sukmaapps/config/config.dart';

import '../../../../common/common.dart';
import '../../domain/entity/entity.dart';
import '../../domain/usecase/check_convert_pulsa_access.usecase.dart';
import '../widget/home/service_offline.widget.dart';
import '../widget/home/transaction_failed.widget.dart';
import '../widget/home/user_blocked.widget.dart';

/// Single entry point: check access + show feedback when blocked.
@lazySingleton
class ConvertPulsaAccessGuard {
  ConvertPulsaAccessGuard(this._checkAccess);

  final CheckConvertPulsaAccessUseCase _checkAccess;

  Future<bool> ensureAccess() async {
    final result = await _checkAccess(NoParams());

    return await result.fold(
      (failure) async {
        FailurePresenter.show(failure);
        return false;
      },
      (access) async {
        if (access == ConvertPulsaAccessResult.allowed) {
          return true;
        }
        await ConvertPulsaAccessPresenter.showBlock(access);
        return false;
      },
    );
  }
}

class ConvertPulsaAccessPresenter {
  const ConvertPulsaAccessPresenter._();

  static BuildContext? get _context => rootNavigatorKey.currentContext;

  static Future<void> showBlock(ConvertPulsaAccessResult result) async {
    switch (result) {
      case ConvertPulsaAccessResult.allowed:
        return;
      case ConvertPulsaAccessResult.serviceOffline:
        await _showServiceOffline();
      case ConvertPulsaAccessResult.userBlocked:
        await _showUserBlocked();
      case ConvertPulsaAccessResult.transactionHold:
        await _showTransactionHold();
      case ConvertPulsaAccessResult.hasOutstanding:
        await StaticWidget.msgToast(
          'Selesaikan transaksi yang sedang berjalan',
        );
    }
  }

  static Future<void> _showServiceOffline() async {
    final context = _context;
    if (context == null) return;

    await StaticWidget.modalBottomWidget(
      context: context,
      widget: RPadding.all(16, child: const ServiceOfflineWidget()),
    );
  }

  static Future<void> _showUserBlocked() async {
    final context = _context;
    if (context == null) return;

    await StaticWidget.modalBottomWidget(
      context: context,
      isShowDragHandling: false,
      widget: UserBlockedWidget(
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  static Future<void> _showTransactionHold() async {
    final context = _context;
    if (context == null) return;

    await StaticWidget.modalBottomWidget(
      context: context,
      widget: RPadding.all(
        16,
        child: TransactionFailedWidget(
          onPressed: () {
            Navigator.of(context).pop();
            appRouter.pushNamed(RouteNames.statusTransaksi);
          },
        ),
      ),
    );
  }
}
