import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide AsyncValue;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../app/app.dart';
import '../../../config/config.dart';
import '../../../core/core.dart';
import '../../../core/enum/status.enum.dart';
import '../../domain/entity/transfer.entity.dart';
import '../adapter/detail_transaksi.adapter.dart';
import '../navigation/detail_transaksi.arg.dart';
import '../widget/widget.dart';
import '../../../features/landing/presentation/adapter/landing.adapter.dart';

class DetailTransaksiScreen extends ConsumerStatefulWidget {
  const DetailTransaksiScreen({
    super.key,
    required this.argument,
  });

  final DetailTransaksiArg argument;

  @override
  ConsumerState<DetailTransaksiScreen> createState() =>
      _DetailTransaksiScreenState();
}

class _DetailTransaksiScreenState extends ConsumerState<DetailTransaksiScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  Color _getAppBarColor(int? status) {
    if (status == 1) return const Color(0xFF16A472);
    if (status == 2) return const Color(0xFFA41616);
    if (status == 0) return const Color(0xFF3681F2);
    return AppColor.whiteMassive;
  }

  Widget sectionDetail({required TransferEntity transferModel}) {
    return Column(
      children: [
        RPadding.all(
          16,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UITextPrimaryWidget(
                  title: 'Detail Konversi Pulsa',
                  fontSize: 16.sp,
                  color: const Color(0xFF101828),
                  fontWeight: FontWeight.w700,
                ),
                RPadding.symmetric(
                  vertical: 8,
                  child: const DashedDividerWidget(
                    color: Color(0xFFE7E8F3),
                  ),
                ),
                rowDetail(
                  leftText: 'ID Transaksi',
                  rightText: transferModel.noTrans ?? '',
                ),
                rowDetail(
                  leftText: 'Nomor Pengirim',
                  rightText: transferModel.noSending ?? '',
                ),
                rowDetail(
                  leftText: 'Nominal',
                  rightText: FormatHelper.formatThousandFromNumber(
                    transferModel.nominal,
                  ),
                ),
                rowDetail(
                  leftText: 'Rate',
                  rightText: transferModel.rate ?? '',
                ),
                rowDetail(
                  leftText: 'Hasil Convert',
                  rightText:
                      'Rp${FormatHelper.formatThousandFromNumber(transferModel.subtotal)}',
                ),
                rowDetail(
                  leftText: 'Rekening Penerima',
                  rightText: transferModel.bank ?? '',
                ),
                rowDetail(
                  leftText: 'No Rekening / Wallet',
                  rightText: transferModel.noRekening ?? '',
                ),
                rowDetail(
                  leftText: 'Pemilik  Rekening / Wallet',
                  rightText: transferModel.nameRekening ?? '',
                ),
                rowDetail(
                  leftText: 'Biaya Transfer',
                  rightText:
                      'Rp${FormatHelper.formatThousandFromNumber(transferModel.charge)}',
                ),
                RPadding.symmetric(
                  vertical: 8,
                  child: const DashedDividerWidget(
                    color: Color(0xFFE7E8F3),
                  ),
                ),
                SizedBox(height: 4.h),
                rowSummary(
                  leftText: 'Jumlah uang yang diterima',
                  rightText:
                      'Rp${FormatHelper.formatThousandFromNumber(transferModel.total)}',
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
        UIButtonBottomWidget(
          titleButton: 'Tutup',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget rowDetail({required String leftText, required String rightText}) {
    return RPadding.all(
      4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UITextPrimaryWidget(
            title: leftText,
            fontSize: 12.sp,
            color: const Color(0xFF667085),
            fontWeight: FontWeight.w400,
          ),
          UITextPrimaryWidget(
            title: rightText,
            fontSize: 12.sp,
            color: const Color(0xFF344054),
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }

  Widget rowSummary({required String leftText, required String rightText}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UITextPrimaryWidget(
          title: leftText,
          fontSize: 14.sp,
          color: const Color(0xFF101828),
          fontWeight: FontWeight.w700,
        ),
        UITextPrimaryWidget(
          title: rightText,
          fontSize: 14.sp,
          color: const Color(0xFF101828),
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }

  Widget infoBox() {
    return UICardInfobox(
      colorBorder: const Color(0xFFB54708),
      colorBg: const Color(0xFFFEF0C7),
      widget: Row(
        children: [
          Icon(
            Icons.warning_rounded,
            size: 24.sp,
            color: const Color(0xFFB54708),
          ),
          SizedBox(width: 8.w),
          SizedBox(
            child: Text(
              'Segera hubungi customer service jika kamu\nsudah melakukan transfer pulsa ke Sukma',
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFFB54708),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget cardReTransfer() {
    return UICardPrimaryWidget(
      width: 343.w,
      color: const Color(0xFF164994),
      colorSide: const Color(0xFF164994),
      child: Row(
        children: [
          SvgPicture.asset(
            IconSharedConstant.transfer,
            height: 40.h,
            width: 40.w,
          ),
          SizedBox(width: 16.w),
          Text(
            'Convert Pulsa Lagi',
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleBack() async {
    await InAppReviewWidget.show(context, ref);
    if (!mounted) return;
    if (!widget.argument.isFromHistory) {
      context.goNamed(RouteNames.landing);
      return;
    }
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = ref.watch(detailTransactionControllerProvider.notifier);
    final detailAsync = ref.watch(
      getDetailTransactionProvider(transNo: widget.argument.transNo),
    );
    final status = detailAsync.valueOrNull?.status;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          await _handleBack();
        }
      },
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _getAppBarColor(status),
          title: UITextPrimaryWidget(
            title: 'Status Transaksi',
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          leading: widget.argument.isFromHistory
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: _handleBack,
                )
              : IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white),
                  onPressed: _handleBack,
                ),
        ),
        body: detailAsync.when(
          data: (transfer) {
            if (transfer == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!context.mounted) return;
                context.goNamed(RouteNames.statusTransaksi);
              });
              return const SizedBox.shrink();
            }

            return RefreshIndicator(
              onRefresh: () =>
                  ctrl.refreshDetailTrans(transNo: widget.argument.transNo),
              child: Container(
                color: AppColor.whiteFair,
                child: Stack(
                  children: [
                    bannerStatus(status: transfer.status ?? 0),
                    RPadding.only(
                      right: 16,
                      left: 16,
                      bottom: 16,
                      child: ListView(
                        children: [
                          SizedBox(height: 122.h),
                          if ((transfer.status ?? 0) == 0)
                            StatusProsesWidget(model: transfer),
                          if ((transfer.status ?? 0) == 1)
                            StatusSuccessWidget(model: transfer),
                          if ((transfer.status ?? 0) == 2 &&
                              !(transfer.cancelByAdmin ?? false))
                            const StatusCancelWidget(),
                          if ((transfer.status ?? 0) == 2 &&
                              (transfer.cancelByAdmin ?? false))
                            const StatusFailedWidget(),
                          SizedBox(height: 16.h),
                          InkWell(
                            onTap: () {
                              StaticWidget.modalBottomWidget(
                                context: context,
                                widget: Column(
                                  children: [
                                    sectionDetail(transferModel: transfer),
                                  ],
                                ),
                              );
                            },
                            child: UICardPrimaryWidget(
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    IconBottomNavConstant.riwayatLight,
                                    height: 24.h,
                                    width: 24.w,
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: UITextPrimaryWidget(
                                      title: 'Detail Transaksi',
                                      fontSize: 14.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Icon(
                                    Icons.chevron_right_sharp,
                                    size: 24.sp,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (StatusTransHelper.getStatus(
                                transfer.status ?? 0,
                              ) ==
                              Status.failed)
                            Column(
                              children: [
                                SizedBox(height: 16.h),
                                InkWell(
                                  onTap: () {
                                    ref
                                        .read(
                                          landingRiverpodAdapterProvider
                                              .notifier,
                                        )
                                        .launchWhatsapp(
                                          FormatWaConstant.byTransFailed(
                                            idTrans: transfer.noTrans ?? '',
                                          ),
                                        );
                                  },
                                  child: UICardPrimaryWidget(
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          IconSharedConstant.customerService,
                                          height: 24.h,
                                          width: 24.w,
                                        ),
                                        SizedBox(width: 8.w),
                                        Expanded(
                                          child: UITextPrimaryWidget(
                                            title: 'Hubungi CS',
                                            fontSize: 14.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        Icon(
                                          Icons.chevron_right_sharp,
                                          size: 24.sp,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Padding(
            padding: REdgeInsets.all(16),
            child: Center(
              child: UIButtonPrimaryWidget(
                titleButton: '$error. Tap to retry',
                onPressed: () {
                  ctrl.refreshDetailTrans(transNo: widget.argument.transNo);
                },
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: detailAsync.when(
            data: (transfer) {
              if (transfer == null) return const SizedBox.shrink();
              return DetailTransaksiWidget.buttonBottomDetailTransaksi(
                context: context,
                ref: ref,
                fromHistory: widget.argument.isFromHistory,
                model: transfer,
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }

  Column bannerStatus({required int status}) {
    return Column(
      children: [
        if (status == 0)
          Lottie.asset(
            ImageStatusTransaksiConstant.bannerTransactionProcessAnimation,
            height: 122.h,
            width: double.infinity,
            fit: BoxFit.cover,
          )
        else
          Image.asset(
            status == 1
                ? ImageStatusTransaksiConstant.bannerTransactionDone
                : ImageStatusTransaksiConstant.bannerTransactionFail,
            height: 122.h,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ClipPath(
          clipper: BottomOvalClipper(),
          child: Container(
            decoration: BoxDecoration(
              color: _getAppBarColor(status),
            ),
            height: 100.h,
          ),
        ),
      ],
    );
  }
}

class BottomOvalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 30,
      size.width,
      size.height - 30,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
