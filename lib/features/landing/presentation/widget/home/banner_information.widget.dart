import 'package:app_core/app_core.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';

class BannerInformationWidget extends StatelessWidget {
  const BannerInformationWidget({super.key, this.listInformation});
  final List<String>? listInformation;

  @override
  Widget build(BuildContext context) {
    List<String> data = listInformation ??
        [
          'Selamat datang di Sukma Convert Pulsa. Rate tinggi dan bisa kirim ke semua rekening tanpa ribet',
        ];
    return UICardPrimaryWidget(
      color: AppColor.brPrimaryStrong,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 40.h,
          viewportFraction: 1,
          autoPlay: true,
          scrollDirection: Axis.vertical,
        ),
        items: data.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                child: UITextPrimaryWidget(
                  title: i,
                  fontSize: 12.sp,
                  color: AppColor.whiteMassive,
                  fontWeight: FontWeight.w700,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
