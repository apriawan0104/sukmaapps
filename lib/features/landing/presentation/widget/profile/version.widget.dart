import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';
import '../../adapter/landing.adapter.dart';

class VersionWidget extends ConsumerWidget {
  const VersionWidget({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final VoidCallback onTap;
  final String icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrl = ref.read(landingRiverpodAdapterProvider.notifier);

    return FutureBuilder<String>(
      future: ctrl.getVersion(),
      builder: (context, snapshot) {
        final version = snapshot.data ?? '';

        return InkWell(
          onTap: onTap,
          child: Padding(
            padding: REdgeInsets.all(16.0),
            child: Row(
              children: [
                SvgPicture.asset(
                  icon,
                  height: 24.h,
                  width: 24.w,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: UITextPrimaryWidget(
                    title: title,
                    fontSize: 14.sp,
                    color: AppColor.blackFair,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                UITextPrimaryWidget(
                  title: version.isEmpty ? subtitle : '$subtitle $version',
                  fontSize: 14.sp,
                  color: AppColor.blackFair,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
