import 'package:app_core/app_core.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../common/common.dart';
import '../../../../../core/core.dart';
import '../../../domain/entity/entity.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({
    super.key,
    required this.bannerAsync,
    required this.onRetry,
    required this.onOpenBannerUrl,
  });

  final AsyncValue<List<BannerEntity>> bannerAsync;
  final VoidCallback onRetry;
  final String? Function(String? url) onOpenBannerUrl;

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int _currentIndexBanner = 0;

  Widget _bannerCarousel(BuildContext context, List<BannerEntity> data) {
    List<Widget> listData(BuildContext context) {
      return List.generate(
        data.length,
        (index) => InkWell(
          onTap: () => widget.onOpenBannerUrl(data[index].urlAction),
          child: Container(
            margin: REdgeInsets.symmetric(horizontal: 5),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)).w,
              child: CachedNetworkImage(
                height: 148.h,
                width: double.infinity,
                fit: BoxFit.fitWidth,
                imageUrl:
                    '${EnvConstant.imageUrl.env}${data[index].url!}/584',
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 148.h,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 148.h,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: const Icon(Icons.broken_image_outlined,
                      color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CarouselSlider(
          items: listData(context),
          options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 0.90,
            height: 165.h,
            onPageChanged: (index, _) {
              setState(() {
                _currentIndexBanner = index;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              data.length,
              (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 3.w),
                width: _currentIndexBanner == index ? 24.w : 6.w,
                height: 6.h,
                decoration: ShapeDecoration(
                  color: _currentIndexBanner == index
                      ? const Color(0xFF164994)
                      : const Color(0xFFE7E8F3),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: _currentIndexBanner == index ? 0 : 1.w,
                      color: const Color(0xFFE7E8F3),
                    ),
                    borderRadius: BorderRadius.circular(15).w,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _bannerCarouselLoading() {
    const int count = 5;
    final List<Widget> shimmerItems = List.generate(
      count,
      (index) => Shimmer.fromColors(
        baseColor: const Color(0xFFDFD9D9),
        highlightColor: const Color(0xFFF2F2FF),
        child: Container(
          margin: REdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8).w,
          ),
        ),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CarouselSlider(
          items: shimmerItems,
          options: CarouselOptions(
            autoPlay: false,
            viewportFraction: 0.90,
            height: 165.h,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              count,
              (index) => Shimmer.fromColors(
                baseColor: const Color(0xFFDFD9D9),
                highlightColor: const Color(0xFFF2F2FF),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  width: index == 0 ? 24.w : 6.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15).w,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AsyncValueWidget<List<BannerEntity>>(
      value: widget.bannerAsync,
      onSuccess: (data) => _bannerCarousel(context, data),
      loadingWidget: _bannerCarouselLoading(),
      errorWidget: (p0, p1) => _bannerCarouselLoading(),
      onRetry: widget.onRetry,
    );
  }
}
