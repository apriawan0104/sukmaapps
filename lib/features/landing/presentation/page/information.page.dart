import 'package:app_core/app_core.dart' as app_core;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/app.dart';
import '../../../../common/common.dart';
import '../../../../core/core.dart';
import '../../domain/entity/entity.dart';
import '../adapter/landing.adapter.dart';
import '../controller/landing.controller.dart';
import '../widget/widget.dart';

class InformationPage extends ConsumerWidget {
  const InformationPage({super.key});

  Widget contentListMedsos(LandingController ctrl,
      app_core.AsyncValue<List<SocialMediaEntity>> socialMedia) {
    return AsyncValueWidget(
        value: socialMedia,
        onSuccess: (data) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InformationContentListWidget(
                  icon: IconProfileConstant.whatsappUil,
                  title: 'Chat dengan Customer Service ',
                  onTap: () {
                    ctrl.launchWhatsapp(FormatWaConstant.general);
                  },
                  secondIcon: IconProfileConstant.instagramUil,
                  secondTitle: 'Follow akun Instagram kami',
                  secondOnTap: () {
                    if (data.any((element) => element.type == 'instagram')) {
                      ctrl.launchUrl(data
                              .firstWhere(
                                  (element) => element.type == 'instagram')
                              .url ??
                          '');
                    } else {
                      ctrl.launchUrl(
                          'https://www.instagram.com/sukmaconvertpulsa/');
                    }
                  },
                ),
                InformationContentListWidget(
                  icon: IconProfileConstant.tiktokUil,
                  title: 'Follow akun TikTok kami',
                  onTap: () {
                    if (data.any((element) => element.type == 'tiktok')) {
                      ctrl.launchUrl(data
                              .firstWhere((element) => element.type == 'tiktok')
                              .url ??
                          '');
                    } else {
                      ctrl.launchUrl('https://www.tiktok.com/@sukmaconvert');
                    }
                  },
                  secondIcon: IconProfileConstant.youtubeUil,
                  secondTitle: 'Subscribe ke channel Youtube',
                  secondOnTap: () {
                    if (data.any((element) => element.type == 'youtube')) {
                      ctrl.launchUrl(data
                              .firstWhere(
                                  (element) => element.type == 'youtube')
                              .url ??
                          '');
                    } else {
                      ctrl.launchUrl(
                          'https://www.youtube.com/@sukmaconvertpulsa5238');
                    }
                  },
                ),
                InformationContentListWidget(
                  icon: IconProfileConstant.webUil,
                  title: 'Kunjungi website kami',
                  onTap: () {
                    if (data.any((element) => element.type == 'website')) {
                      ctrl.launchUrl(data
                              .firstWhere(
                                  (element) => element.type == 'website')
                              .url ??
                          '');
                    } else {
                      ctrl.launchUrl('https://www.sukmaconvert.co.id/');
                    }
                  },
                ),
              ],
            ),
        onRetry: () => ctrl.getSocialMedia());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrl = ref.read(landingRiverpodAdapterProvider.notifier);
    final state = ref.watch(landingRiverpodAdapterProvider);

    return Scaffold(
        backgroundColor: AppColor.whiteFair,
        appBar: UIAppBar.appBar(
          context,
          title: 'Information',
          customBackButton: const SizedBox(),
        ),
        body: Stack(
          children: [
            Image.asset(
              ImageInformationConstant.customerCare,
              // fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: const app_core.REdgeInsets.fromLTRB(16, 136, 16, 16),
              child: SingleChildScrollView(
                child: UICardPrimaryWidget(
                  child: contentListMedsos(ctrl, state.socialMedia),
                ),
              ),
            ),
          ],
        ));
  }
}
