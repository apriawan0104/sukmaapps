import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide AsyncValue;
import 'package:go_router/go_router.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';
import '../../../domain/entity/entity.dart';
import '../../adapter/convert_pulsa.adapter.dart';
import '../../controller/convert_pulsa.controller.dart';
import 'bank_card.widget.dart';

class RekeningDialogWidget {
  static Future<dynamic> listReceiverAccount({
    required BuildContext context,
    required ConvertPulsaController ctrl,
  }) async {
    await ctrl.getListBank();
    if (!context.mounted) return;

    return StaticWidget.modalBottomWidget(
      context: context,
      widget: Consumer(
        builder: (context, ref, _) {
          final state = ref.watch(convertPulsaRiverpodAdapterProvider);
          final adapter =
              ref.read(convertPulsaRiverpodAdapterProvider.notifier);

          return _BankListDialogContent(
            ctrl: adapter,
            bankListValue:
                state.bankListValue ?? const AsyncValue<List<BankEntity>>.loading(),
          );
        },
      ),
    );
  }

  static Future<dynamic> inputRekening({
    required BuildContext context,
    required ConvertPulsaController ctrl,
    required BankEntity bank,
  }) async {
    ctrl.isSaveRekening(false);

    return StaticWidget.modalBottomWidget(
      context: context,
      widget: Consumer(
        builder: (context, ref, _) {
          final state = ref.watch(convertPulsaRiverpodAdapterProvider);
          final adapter =
              ref.read(convertPulsaRiverpodAdapterProvider.notifier);

          ref.listen(
            convertPulsaRiverpodAdapterProvider.select((s) => s.saveRekeningValue),
            (previous, next) {
              final wasLoading = previous?.isLoading ?? false;
              if (!wasLoading || next?.isLoading == true) {
                return;
              }

              if (next?.hasValue == true && context.mounted) {
                context.pop();
              }
            },
          );

          return _BankInputDialogContent(
            ctrl: adapter,
            bank: bank,
            isSaveRekening: state.isSaveRekening ?? false,
            saveRekeningValue:
                state.saveRekeningValue ?? const AsyncValue.data(null),
          );
        },
      ),
    );
  }
}

class _BankListDialogContent extends StatelessWidget {
  const _BankListDialogContent({
    required this.ctrl,
    required this.bankListValue,
  });

  final ConvertPulsaController ctrl;
  final AsyncValue<List<BankEntity>> bankListValue;

  Widget _listBank(BuildContext context, {required String typeBank}) {
    return RPadding.all(
      16,
      child: AsyncValueWidget<List<BankEntity>>(
        value: bankListValue,
        onSuccess: (data) {
          return ListView(
            children: List.generate(
              data.length,
              (index) {
                if (data[index].typePayment == typeBank) {
                  return BankCardWidget(
                    bank: data[index],
                    onTap: () {
                      RekeningDialogWidget.inputRekening(
                        context: context,
                        ctrl: ctrl,
                        bank: data[index],
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          );
        },
        onRetry: ctrl.getListBank,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 564.h,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: UITextPrimaryWidget(
              title: 'Tambahkan Rekening',
              fontSize: 14.sp,
              color: AppColor.blackMassive,
              fontWeight: FontWeight.w700,
            ),
            automaticallyImplyLeading: false,
            bottom: TabBar(
              padding: REdgeInsets.symmetric(horizontal: 16),
              tabs: [
                Tab(
                  child: SizedBox(
                    width: double.infinity,
                    child: UITextPrimaryWidget(
                      align: TextAlign.center,
                      title: 'Rekening Bank',
                      fontSize: 12.sp,
                      color: AppColor.blackFair,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Tab(
                  child: SizedBox(
                    width: double.infinity,
                    child: UITextPrimaryWidget(
                      align: TextAlign.center,
                      title: 'Wallet',
                      fontSize: 12.sp,
                      color: AppColor.blackFair,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _listBank(context, typeBank: 'Bank'),
              _listBank(context, typeBank: 'E-Wallet'),
            ],
          ),
        ),
      ),
    );
  }
}

class _BankInputDialogContent extends StatefulWidget {
  const _BankInputDialogContent({
    required this.ctrl,
    required this.bank,
    required this.isSaveRekening,
    required this.saveRekeningValue,
  });

  final ConvertPulsaController ctrl;
  final BankEntity bank;
  final bool isSaveRekening;
  final AsyncValue<void> saveRekeningValue;

  @override
  State<_BankInputDialogContent> createState() =>
      _BankInputDialogContentState();
}

class _BankInputDialogContentState extends State<_BankInputDialogContent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _txtNoRek = TextEditingController();
  final TextEditingController _txtName = TextEditingController();
  final TextEditingController _txtOtherBankName = TextEditingController();
  final ValueNotifier<int> _lengthCounterOtherBank = ValueNotifier<int>(0);
  final ValueNotifier<int> _lengthCounterNoRek = ValueNotifier<int>(0);
  final ValueNotifier<int> _lengthCounterName = ValueNotifier<int>(0);
  bool _isFocusOtherBank = false;
  bool _isFocusNoRek = false;
  bool _isFocusName = false;

  bool get _isOtherBank =>
      (widget.bank.name ?? '').toLowerCase() == 'bank lainnya';

  @override
  void dispose() {
    _txtNoRek.dispose();
    _txtName.dispose();
    _txtOtherBankName.dispose();
    _lengthCounterOtherBank.dispose();
    _lengthCounterNoRek.dispose();
    _lengthCounterName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Column(
          children: [
            Container(
              color: Colors.white,
              child: RPadding.all(
                16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: UITextPrimaryWidget(
                            title: 'Rekening Penerima',
                            fontSize: 14.sp,
                            color: const Color(0xFF101828),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: UITextPrimaryWidget(
                            title: 'Ganti',
                            fontSize: 14.sp,
                            color: const Color(0xFF164994),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    BankCardWidget(
                      bank: widget.bank,
                      isTap: true,
                    ),
                  ],
                ),
              ),
            ),
            const UIKeyPairWidget(),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(color: Colors.white),
              child: RPadding.all(
                16,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_isOtherBank) ...[
                        UITextPrimaryWidget(
                          title: 'Nama Bank / Wallet',
                          fontSize: 14.sp,
                          color: AppColor.blackMassive,
                          fontWeight: FontWeight.w700,
                        ),
                        Focus(
                          onFocusChange: (value) {
                            setState(() {
                              _isFocusOtherBank = value;
                            });
                          },
                          child: UITextFormFieldWidget(
                            controller: _txtOtherBankName,
                            hintText: 'Masukkan Nama Bank / Wallet',
                            messageValidator: 'Nama bank wajib di isi',
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(15),
                            ],
                            suffixIcon: ValueListenableBuilder<int>(
                              valueListenable: _lengthCounterOtherBank,
                              builder: (ctx, value, child) {
                                return _isFocusOtherBank
                                    ? Transform.rotate(
                                        angle: 0.7854,
                                        child: IconButton(
                                          onPressed: () {
                                            if (_lengthCounterOtherBank.value >
                                                0) {
                                              _txtOtherBankName.clear();
                                              _lengthCounterOtherBank.value =
                                                  0;
                                            }
                                          },
                                          icon: Icon(
                                            Icons.add_circle,
                                            color: (_lengthCounterOtherBank
                                                        .value >
                                                    0)
                                                ? AppColor.blackIcon
                                                : AppColor.greyTextFieldPrefix,
                                            size: 25.w,
                                          ),
                                        ),
                                      )
                                    : const SizedBox();
                              },
                            ),
                            onChanged: (value) {
                              _lengthCounterOtherBank.value = value.length;
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UITextPrimaryWidget(
                              title: 'Contoh : CIMB Niaga',
                              fontSize: 12.sp,
                              color: AppColor.blackMassive,
                              fontWeight: FontWeight.w400,
                            ),
                            ValueListenableBuilder<int>(
                              valueListenable: _lengthCounterOtherBank,
                              builder: (ctx, value, child) {
                                return UITextPrimaryWidget(
                                  title:
                                      '${_lengthCounterOtherBank.value}/15',
                                  fontSize: 12.sp,
                                  color: AppColor.blackMassive,
                                  fontWeight: FontWeight.w400,
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                      ],
                      UITextPrimaryWidget(
                        title: 'Nomor Rekening / Wallet',
                        fontSize: 14.sp,
                        color: AppColor.blackMassive,
                        fontWeight: FontWeight.w700,
                      ),
                      Focus(
                        onFocusChange: (value) {
                          setState(() {
                            _isFocusNoRek = value;
                          });
                        },
                        child: UITextFormFieldWidget(
                          controller: _txtNoRek,
                          hintText: 'Masukkan Nomor Rekening / Wallet',
                          messageValidator: 'Nomor rekenins wajib di isi',
                          suffixIcon: ValueListenableBuilder<int>(
                            valueListenable: _lengthCounterNoRek,
                            builder: (ctx, value, child) {
                              return _isFocusNoRek
                                  ? Transform.rotate(
                                      angle: 0.7854,
                                      child: IconButton(
                                        onPressed: () {
                                          if (_lengthCounterNoRek.value > 0) {
                                            _txtNoRek.clear();
                                            _lengthCounterNoRek.value = 0;
                                          }
                                        },
                                        icon: Icon(
                                          Icons.add_circle,
                                          color: (_lengthCounterNoRek.value > 0)
                                              ? AppColor.blackIcon
                                              : AppColor.greyTextFieldPrefix,
                                          size: 25.w,
                                        ),
                                      ),
                                    )
                                  : const SizedBox();
                            },
                          ),
                          onChanged: (value) {
                            _lengthCounterNoRek.value = value.length;
                          },
                        ),
                      ),
                      SizedBox(height: 16.h),
                      UITextPrimaryWidget(
                        title: 'Nama Pemilik',
                        fontSize: 14.sp,
                        color: AppColor.blackMassive,
                        fontWeight: FontWeight.w700,
                      ),
                      Focus(
                        onFocusChange: (value) {
                          setState(() {
                            _isFocusName = value;
                          });
                        },
                        child: UITextFormFieldWidget(
                          controller: _txtName,
                          hintText: 'Masukkan Nama Pemilik',
                          messageValidator: 'Nama pemilik wajib di isi',
                          suffixIcon: ValueListenableBuilder<int>(
                            valueListenable: _lengthCounterName,
                            builder: (ctx, value, child) {
                              return _isFocusName
                                  ? Transform.rotate(
                                      angle: 0.7854,
                                      child: IconButton(
                                        onPressed: () {
                                          if (_lengthCounterName.value > 0) {
                                            _txtName.clear();
                                            _lengthCounterName.value = 0;
                                          }
                                        },
                                        icon: Icon(
                                          Icons.add_circle,
                                          color: (_lengthCounterName.value > 0)
                                              ? AppColor.blackIcon
                                              : AppColor.greyTextFieldPrefix,
                                          size: 25.w,
                                        ),
                                      ),
                                    )
                                  : const SizedBox();
                            },
                          ),
                          onChanged: (value) {
                            _lengthCounterName.value = value.length;
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: AppColor.brPrimaryStrong,
                            visualDensity: VisualDensity.compact,
                            value: widget.isSaveRekening,
                            onChanged: (value) {
                              widget.ctrl.isSaveRekening(value ?? false);
                            },
                          ),
                          UITextPrimaryWidget(
                            title:
                                'Simpan rekening untuk transaksi selanjutnya',
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
            ),
            AsyncValueWidget<void>(
              value: widget.saveRekeningValue,
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
                  titleButton: 'Simpan Rekening',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.ctrl.saveRekening(
                        bankId: widget.bank.id ?? 0,
                        bankName: widget.bank.name ?? '',
                        bankCharge: widget.bank.charge ?? 0,
                        otherBankName: _isOtherBank
                            ? _txtOtherBankName.text
                            : null,
                        accountNumber: _txtNoRek.text,
                        accountName: _txtName.text,
                      );
                    }
                  },
                );
              },
              onRetry: () {
                if (_formKey.currentState?.validate() ?? false) {
                  widget.ctrl.saveRekening(
                    bankId: widget.bank.id ?? 0,
                    bankName: widget.bank.name ?? '',
                    bankCharge: widget.bank.charge ?? 0,
                    otherBankName:
                        _isOtherBank ? _txtOtherBankName.text : null,
                    accountNumber: _txtNoRek.text,
                    accountName: _txtName.text,
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
