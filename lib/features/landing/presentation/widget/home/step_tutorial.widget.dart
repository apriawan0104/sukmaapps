import 'package:app_core/app_core.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/core.dart';

class StepTutorialWidget extends StatefulWidget {
  const StepTutorialWidget({super.key});

  @override
  State<StepTutorialWidget> createState() => _StepTutorialWidgetState();
}

class _StepTutorialWidgetState extends State<StepTutorialWidget> {
  int _currentIndexStatic = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  Widget staticCarousel(BuildContext context) {
    final items = listStaticCarousel(context);

    return Column(
      children: <Widget>[
        CarouselSlider(
          items: items,
          options: CarouselOptions(
            height: 260.h,
            viewportFraction: 0.95,
            enableInfiniteScroll: false,
            onPageChanged: (index, _) {
              setState(() {
                _currentIndexStatic = index;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(
              items,
              (index, _) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  width: _currentIndexStatic == index ? 24.w : 6.w,
                  height: 6.h,
                  decoration: ShapeDecoration(
                    color: _currentIndexStatic == index
                        ? const Color(0xFF164994)
                        : const Color(0xFFE7E8F3),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: _currentIndexStatic == index ? 0 : 1.w,
                          color: const Color(0xFFE7E8F3)),
                      borderRadius: BorderRadius.circular(15).w,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: 30.w,
        )
      ],
    );
  }

  List<Widget> listStaticCarousel(BuildContext context) {
    return [
      stepWidget(
          image: ImageStepConstant.step1,
          number: 1,
          title: 'Isi Nomor Pengirim',
          subtitle: 'Masukkan nomor pengirim yang akan ditukar pulsanya'),
      stepWidget(
          image: ImageStepConstant.step2,
          number: 2,
          title: 'Isi Nominal',
          subtitle: 'Masukkan nominal pulsa yang akan diconvert'),
      stepWidget(
          image: ImageStepConstant.step3,
          number: 3,
          title: 'Pilih Bank',
          subtitle: 'Masukkan detail bank yang akan menerima dana dari kami'),
      stepWidget(
          image: ImageStepConstant.step4,
          number: 4,
          title: 'Review Transaksi',
          subtitle:
              'Periksa kembali transaksi yang kamu buat dan tap button “Lanjutkan Transfer Pulsa '),
      stepWidget(
          image: ImageStepConstant.step5,
          number: 5,
          title: 'Transfer Pulsa ke Nomor Sukma',
          subtitle:
              'Transfer pulsa ke nomor yang tersedia, Lalu upload bukti transfernya'),
      stepWidget(
          image: ImageStepConstant.step6,
          number: 6,
          title: 'Selesaikan Transfer',
          subtitle:
              'Jika sudah mengupload bukti transfer, klik “Saya Sudah Transfer”. '),
    ];
  }

  Widget stepWidget(
      {required String image,
      required int number,
      required String title,
      required String subtitle}) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.w, color: const Color(0xFFE7E8F3)),
          borderRadius: BorderRadius.circular(8).w,
        ),
      ),
      child: Column(
        children: [
          cardStep(image: image),
          detailCardStep(number: number, title: title, subtitle: subtitle),
        ],
      ),
    );
  }

  Widget cardStep({required String image}) {
    return Image.asset(image, height: 160.h, width: 319.w, fit: BoxFit.fill);
  }

  Widget detailCardStep(
      {required int number, required String title, required String subtitle}) {
    return Container(
      width: 319.w,
      //height: 86.h,
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: REdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24.w,
                  // height: 24.h,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF164994),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16).w,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        number.toString(),
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFFFFFFFF),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFF293142),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                SizedBox(
                  child: Text(
                    subtitle,
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFF474D5F),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sliderStep() {
    return Container(
      height: 22.h,
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 24.w,
            height: 6.h,
            decoration: ShapeDecoration(
              color: const Color(0xFF164994),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15).w,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            width: 6.w,
            height: 6.h,
            decoration: ShapeDecoration(
              color: const Color(0xFFE7E8F3),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.w, color: const Color(0xFFE7E8F3)),
                borderRadius: BorderRadius.circular(15).w,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            width: 6.w,
            height: 6.h,
            decoration: ShapeDecoration(
              color: const Color(0xFFE7E8F3),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.w, color: const Color(0xFFE7E8F3)),
                borderRadius: BorderRadius.circular(15).w,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            width: 6.w,
            height: 6.h,
            decoration: ShapeDecoration(
              color: const Color(0xFFE7E8F3),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.w, color: const Color(0xFFE7E8F3)),
                borderRadius: BorderRadius.circular(15).w,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            width: 6.w,
            height: 6.h,
            decoration: ShapeDecoration(
              color: const Color(0xFFE7E8F3),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.w, color: const Color(0xFFE7E8F3)),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.only(
        top: 8,
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cara melakukan convert pulsa',
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF19202D),
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          staticCarousel(context),
        ],
      ),
    );
  }
}
