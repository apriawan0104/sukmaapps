import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app.dart';
import '../../../../common/common.dart';
import '../../../../core/core.dart';
import '../adapter/landing.adapter.dart';
import '../controller/landing.controller.dart';

class StatusTransaksiPage extends ConsumerStatefulWidget {
  const StatusTransaksiPage({super.key});

  @override
  ConsumerState<StatusTransaksiPage> createState() =>
      _StatusTransaksiPageState();
}

class _StatusTransaksiPageState extends ConsumerState<StatusTransaksiPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(landingRiverpodAdapterProvider.notifier)
          .getStatusTransaksiFailed();
    });
  }

  Widget _buildReasonItem(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(IconStatusTransaksiConstant.statusFailed),
          SizedBox(width: 8.w),
          Expanded(
            child: UITextPrimaryWidget(
              title: title,
              fontSize: 14.sp,
              color: const Color(0xFF52575C),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionDetailCard({
    required String transNo,
    required String providerIcon,
    required String description,
    required LandingController ctrl,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            ctrl.launchWhatsapp(
              FormatWaConstant.byTransFailed(idTrans: transNo),
            );
          },
          child: UICardPrimaryWidget(
            color: const Color(0xFFF8F8FC),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      providerIcon,
                      height: 40.h,
                      width: 40.w,
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UITextPrimaryWidget(
                            title: transNo,
                            fontSize: 14.sp,
                            color: AppColor.blackMassive,
                            fontWeight: FontWeight.w700,
                            textOverflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          UITextPrimaryWidget(
                            title: description,
                            fontSize: 12.sp,
                            color: AppColor.blackHeavy,
                            fontWeight: FontWeight.w400,
                            textOverflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    IconButton(
                      onPressed: () {
                        ctrl.launchWhatsapp(
                          FormatWaConstant.byTransFailed(idTrans: transNo),
                        );
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 24.sp,
                        color: AppColor.blackMassive,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = ref.read(landingRiverpodAdapterProvider.notifier);
    final statusTransaksiFailed =
        ref.watch(landingRiverpodAdapterProvider).statusTransaksiFailed;

    return Scaffold(
      appBar: UIAppBar.appBar(
        context,
        title: 'Status Transaksi',
      ),
      body: RefreshIndicator(
        onRefresh: ctrl.getStatusTransaksiFailed,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RPadding.all(
                16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      ImageStatusTransaksiConstant.warningTransaction,
                    ),
                    SizedBox(height: 18.h),
                    UITextPrimaryWidget(
                      title: 'Yah, transaksimu belum bisa diproses, nih!',
                      fontSize: 16.sp,
                      color: const Color(0xFF282D31),
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 8.h),
                    UITextPrimaryWidget(
                      title: 'Ini biasanya terjadi karena:',
                      fontSize: 14.sp,
                      color: const Color(0xFF52575C),
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 8.h),
                    _buildReasonItem(
                      'Nomor pengirim yang diinput di aplikasi tidak sama dengan nomor pengirim pulsa',
                    ),
                    SizedBox(height: 8.h),
                    _buildReasonItem(
                      'Nomor rekening yang kamu input tidak terdaftar',
                    ),
                    SizedBox(height: 8.h),
                    _buildReasonItem(
                      'Bukti transfer yang diupload tidak jelas/tidak valid',
                    ),
                  ],
                ),
              ),
              const UIKeyPairWidget(),
              RPadding.all(
                16,
                child: AsyncValueWidget<List<StatusTransaksiEntity>>(
                  value: statusTransaksiFailed,
                  onSuccess: (items) {
                    if (items.isEmpty) {
                      return UICardPrimaryWidget(
                        color: const Color(0xFFF8F8FC),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              IconSharedConstant.leftItem,
                              height: 40.h,
                              width: 40.w,
                            ),
                            SizedBox(width: 16.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                UITextPrimaryWidget(
                                  title: 'Tidak ada transaksi',
                                  fontSize: 14.sp,
                                  color: AppColor.blackMassive,
                                  fontWeight: FontWeight.w700,
                                ),
                                SizedBox(height: 4.h),
                                UITextPrimaryWidget(
                                  title: 'Kamu bisa menutup halaman ini',
                                  fontSize: 14.sp,
                                  color: AppColor.blackHeavy,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UITextPrimaryWidget(
                          title: 'Transaksi yang perlu kamu check',
                          fontSize: 14.sp,
                          color: const Color(0xFF282D31),
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(height: 16.h),
                        ...items.map(
                          (item) => _buildTransactionDetailCard(
                            transNo: item.noTrans ?? '',
                            providerIcon: IconProviderHelper(
                              item.nameProvider ?? '',
                            ).getIconProvider(),
                            description: item.description ?? '',
                            ctrl: ctrl,
                          ),
                        ),
                      ],
                    );
                  },
                  onRetry: ctrl.getStatusTransaksiFailed,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: UIButtonBottomWidget(
        titleButton: 'Tutup',
        onPressed: () {
          context.pop();
        },
        backgroundColor: Colors.white,
        foregroundColor: AppColor.brPrimaryStrong,
      ),
    );
  }
}
