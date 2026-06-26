import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../domain/entity/transfer.entity.dart';
import '../../../domain/param/launch_whatsapp.param.dart';
import '../../../domain/usecase/launch_whatsapp.usecase.dart';
import '../../navigation/convert_pulsa.navigator.dart';
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
            rightOnPressed: () =>
                getIt<ConvertPulsaNavigator>().goToPhone(context),
          );
        case 0:
          widget = UIButtonBottomMultipleWidget(
            leftTitleButton: 'Kembali ke Home',
            leftOnPressed: () async {
              await onPressBack(context, ref);
            },
            rightTitleButton: 'Convert Lagi',
            rightOnPressed: () =>
                getIt<ConvertPulsaNavigator>().goToPhone(context),
          );
        case 2:
          widget = UIButtonBottomMultipleWidget(
            leftTitleButton: 'Kembali ke Home',
            leftOnPressed: () async {
              await onPressBack(context, ref);
            },
            rightTitleButton: 'Convert Lagi',
            rightOnPressed: () =>
                getIt<ConvertPulsaNavigator>().goToPhone(context),
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
            rightOnPressed: () =>
                getIt<ConvertPulsaNavigator>().goToPhone(context),
          );
        case 2:
          widget = UIButtonBottomMultipleWidget(
            leftTitleButton: 'Kembali ke Home',
            leftOnPressed: () async {
              await onPressBack(context, ref);
            },
            rightTitleButton: 'Hubungi CS',
            rightOnPressed: () {
              getIt<LaunchWhatsappUseCase>()(
                LaunchWhatsappParam(
                  body: FormatWaConstant.byTrans(
                    idTrans: model.noTrans ?? '',
                  ),
                ),
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
