import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide AsyncValue;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';
import '../../../../../core/core.dart';
import '../../adapter/convert_pulsa.adapter.dart';
import '../../controller/convert_pulsa.controller.dart';

class AddPhoneSenderWidget extends StatelessWidget {
  const AddPhoneSenderWidget({
    super.key,
    required this.ctrl,
    required this.choosePhone,
    required this.chooseProviderName,
  });

  final ConvertPulsaController ctrl;
  final String? choosePhone;
  final String? chooseProviderName;

  String get _iconProvider =>
      IconProviderHelper(chooseProviderName ?? '').getIconProvider();

  Widget _cardProvider({
    required String numberPhone,
    required String iconProvider,
    required String providerName,
  }) {
    return UICardDottedWidget(
      width: 343.w,
      color: AppColor.whiteFair,
      child: Row(
        children: [
          Image.asset(
            iconProvider,
            height: 32.h,
            width: 32.w,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              providerName,
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF1D2939),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            numberPhone,
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF101828),
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardEmptyProvider(BuildContext context) {
    return UICardDottedWidget(
      width: 343.w,
      child: GestureDetector(
        onTap: () {
          PhoneDialogWidget.inputPhone(context: context, ctrl: ctrl);
        },
        child: Row(
          children: [
            SvgPicture.asset(
              IconSharedConstant.addCircle,
              height: 24.h,
              width: 24.w,
            ),
            SizedBox(width: 16.w),
            Text(
              'Tambahkan Nomor Pengirim',
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF293142),
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final phone = choosePhone ?? '';

    return Padding(
      padding: REdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Nomor Pengirim',
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF101828),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              if (phone.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    PhoneDialogWidget.inputPhone(context: context, ctrl: ctrl);
                  },
                  child: Text(
                    'Ganti',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFF164994),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 4.h),
          phone.isNotEmpty
              ? _cardProvider(
                  numberPhone: phone,
                  iconProvider: _iconProvider,
                  providerName: chooseProviderName ?? '',
                )
              : _cardEmptyProvider(context),
        ],
      ),
    );
  }
}

class PhoneDialogWidget {
  static Future<dynamic> inputPhone({
    required BuildContext context,
    required ConvertPulsaController ctrl,
  }) async {
    ctrl.isSavePhone(false);

    return StaticWidget.modalBottomWidget(
      context: context,
      widget: Consumer(
        builder: (context, ref, _) {
          final state = ref.watch(convertPulsaRiverpodAdapterProvider);
          final adapter =
              ref.read(convertPulsaRiverpodAdapterProvider.notifier);

          ref.listen(
            convertPulsaRiverpodAdapterProvider.select((s) => s.isProviderUnknown),
            (previous, next) {
              if (next == true && context.mounted) {
                adapter.resetProviderUnknown();
                context.pop();
                numberUnknown(context: context);
              }
            },
          );

          ref.listen(
            convertPulsaRiverpodAdapterProvider.select((s) => s.savePhoneValue),
            (previous, next) {
              final wasLoading = previous?.isLoading ?? false;
              if (!wasLoading || next?.isLoading == true) {
                return;
              }

              final currentState = ref.read(convertPulsaRiverpodAdapterProvider);
              if (currentState.isProviderUnknown == true) {
                return;
              }

              if (next?.hasValue == true && context.mounted) {
                context.pop();
              }
            },
          );

          return _PhoneInputDialogContent(
            ctrl: adapter,
            isSavePhone: state.isSavePhone ?? false,
            savePhoneValue:
                state.savePhoneValue ?? const AsyncValue.data(null),
          );
        },
      ),
    );
  }

  static Future<dynamic> numberUnknown({
    required BuildContext context,
  }) async {
    final Widget item = Container(
      color: Colors.white,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                SvgPicture.asset(
                  IconSharedConstant.validatePhone,
                  width: 160.w,
                  height: 160.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.w),
                  child: UITextPrimaryWidget(
                    title: 'Provider tidak dikenali',
                    fontSize: 14.sp,
                    color: AppColor.blackMassive,
                    fontWeight: FontWeight.w700,
                    align: TextAlign.start,
                  ),
                ),
                UITextPrimaryWidget(
                  title: 'Silakan periksa kembali provider yang kamu masukkan',
                  fontSize: 12.sp,
                  color: AppColor.blackFair,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          UIButtonBottomWidget(
            onPressed: () {
              context.pop();
            },
            titleButton: 'Oke, mengerti',
          ),
        ],
      ),
    );
    StaticWidget.modalBottomWidget(
      context: context,
      widget: item,
    );
  }
}

class _PhoneInputDialogContent extends StatefulWidget {
  const _PhoneInputDialogContent({
    required this.ctrl,
    required this.isSavePhone,
    required this.savePhoneValue,
  });

  final ConvertPulsaController ctrl;
  final bool isSavePhone;
  final AsyncValue<void> savePhoneValue;

  @override
  State<_PhoneInputDialogContent> createState() =>
      _PhoneInputDialogContentState();
}

class _PhoneInputDialogContentState extends State<_PhoneInputDialogContent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _txtPhone = TextEditingController();
  final ValueNotifier<int> _lengthCounter = ValueNotifier<int>(0);
  bool _isFocus = false;

  @override
  void dispose() {
    _txtPhone.dispose();
    _lengthCounter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: REdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UITextPrimaryWidget(
                        title: 'Nomor Pengirim',
                        fontSize: 14.sp,
                        color: AppColor.blackMassive,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: 5.w),
                      Focus(
                        onFocusChange: (value) {
                          setState(() {
                            _isFocus = value;
                          });
                        },
                        child: UITextFormFieldWidget(
                          messageValidator: 'No Pengirim harus di isi',
                          controller: _txtPhone,
                          hintText: 'Isi Nomor Pengirim',
                          onChanged: (value) {
                            _lengthCounter.value = value.length;
                          },
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(
                              left: 1.w,
                              top: 1.w,
                              bottom: 1.w,
                              right: 10.w,
                            ),
                            child: Container(
                              width: 50.w,
                              height: 50.w,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                                color: AppColor.greyTextFieldPrefix,
                              ),
                              child: const Center(
                                child: Text(
                                  '+62',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          suffixIcon: ValueListenableBuilder<int>(
                            valueListenable: _lengthCounter,
                            builder: (ctx, value, child) {
                              return value > 1 && _isFocus
                                  ? Transform.rotate(
                                      angle: 0.7854,
                                      child: IconButton(
                                        onPressed: () {
                                          _txtPhone.clear();
                                          _lengthCounter.value = 0;
                                        },
                                        icon: Icon(
                                          Icons.add_circle,
                                          color: AppColor.blackIcon,
                                          size: 25.w,
                                        ),
                                      ),
                                    )
                                  : const SizedBox();
                            },
                          ),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TextFieldFormatterHelper.formatPhoneNumber,
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: AppColor.brPrimaryStrong,
                            visualDensity: VisualDensity.compact,
                            value: widget.isSavePhone,
                            onChanged: (value) {
                              widget.ctrl.isSavePhone(value ?? false);
                            },
                          ),
                          UITextPrimaryWidget(
                            title: 'Simpan nomor untuk transaksi selanjutnya',
                            fontSize: 14.sp,
                            color: AppColor.blackHeavy,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              AsyncValueWidget<void>(
                value: widget.savePhoneValue,
                loadingWidget: Container(
                  color: Colors.white,
                  child: RPadding.all(
                    16,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                onSuccess: (_) {
                  return UIButtonBottomWidget(
                    titleButton: 'Simpan Nomor',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.ctrl.savePhoneFav(_txtPhone.text);
                      }
                    },
                  );
                },
                onRetry: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    widget.ctrl.savePhoneFav(_txtPhone.text);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
