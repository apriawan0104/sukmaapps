import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/app.dart';
import '../../../../common/common.dart';
import '../../../../core/core.dart';
import '../adapter/landing.adapter.dart';
import '../controller/landing.controller.dart';
import '../widget/widget.dart';

class InformationPage extends ConsumerWidget {
  const InformationPage({super.key});

  Widget contentListMedsos(LandingController ctrl) {
    return Column(
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
            ctrl.launchUrl('https://www.instagram.com/sukmaconvertpulsa/');
          },
        ),
        InformationContentListWidget(
          icon: IconProfileConstant.tiktokUil,
          title: 'Follow akun TikTok kami',
          onTap: () {
            ctrl.launchUrl('https://www.tiktok.com/@sukmaconvert');
          },
          secondIcon: IconProfileConstant.youtubeUil,
          secondTitle: 'Subscribe ke channel Youtube',
          secondOnTap: () {
            ctrl.launchUrl('https://www.youtube.com/@sukmaconvertpulsa5238');
          },
        ),
        InformationContentListWidget(
          icon: IconProfileConstant.webUil,
          title: 'Kunjungi website kami',
          onTap: () {
            ctrl.launchUrl('https://www.sukmaconvert.co.id/');
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrl = ref.read(landingRiverpodAdapterProvider.notifier);

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
              padding: const REdgeInsets.fromLTRB(16, 136, 16, 16),
              child: SingleChildScrollView(
                child: UICardPrimaryWidget(
                  child: contentListMedsos(ctrl),
                ),
              ),
            ),
          ],
        ));
  }
}
