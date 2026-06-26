import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../../features/landing/presentation/guard/convert_pulsa_navigation.dart';
import '../../../../features/landing/presentation/adapter/landing.adapter.dart';
import '../../../domain/entity/transfer.entity.dart';
import '../widget.dart';

class DetailTransaksiWidget {
  static Widget buttonBottomDetailTransaksi({
    required BuildContext context,
    required WidgetRef ref,
    required bool fromHistory,
    required TransferEntity model,
  }) {
    Widget widget;
    if (fromHistory) {
      switch (model.status) {
        case 1:
          widget = UIButtonBottomMultipleWidget(
            leftTitleButton: 'Kembali ke Home',
            leftOnPressed: () async {
              await onPressBack(context, ref);
            },
            rightTitleButton: 'Convert Lagi',
            rightOnPressed: () => ConvertPulsaNavigation.goToPhone(context),
          );
        case 0:
          widget = UIButtonBottomMultipleWidget(
            leftTitleButton: 'Kembali ke Home',
            leftOnPressed: () async {
              await onPressBack(context, ref);
            },
            rightTitleButton: 'Convert Lagi',
            rightOnPressed: () => ConvertPulsaNavigation.goToPhone(context),
          );
        case 2:
          widget = UIButtonBottomMultipleWidget(
            leftTitleButton: 'Kembali ke Home',
            leftOnPressed: () async {
              await onPressBack(context, ref);
            },
            rightTitleButton: 'Convert Lagi',
            rightOnPressed: () => ConvertPulsaNavigation.goToPhone(context),
          );
        default:
          widget = Container();
      }
    } else {
      switch (model.status) {
        case 0 || 1:
          widget = UIButtonBottomMultipleWidget(
            leftTitleButton: 'Kembali ke Home',
            leftOnPressed: () async {
              await onPressBack(context, ref);
            },
            rightTitleButton: 'Convert Lagi',
            rightOnPressed: () => ConvertPulsaNavigation.goToPhone(context),
          );
        case 2:
          widget = UIButtonBottomMultipleWidget(
            leftTitleButton: 'Kembali ke Home',
            leftOnPressed: () async {
              await onPressBack(context, ref);
            },
            rightTitleButton: 'Hubungi CS',
            rightOnPressed: () {
              ref.read(landingRiverpodAdapterProvider.notifier).launchWhatsapp(
                    FormatWaConstant.byTrans(idTrans: model.noTrans ?? ''),
                  );
            },
          );
        default:
          widget = Container();
      }
    }
    return widget;
  }

  static Future<void> onPressBack(BuildContext context, WidgetRef ref) async {
    await InAppReviewWidget.show(context, ref);
    if (!context.mounted) return;
    context.goNamed(RouteNames.landing);
  }
}
