import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

import '../../../../../app/app.dart';
import '../../../../../common/common.dart';
import '../../../../../core/core.dart';
import '../../../domain/entity/entity.dart';

class BankCardWidget extends StatelessWidget {
  const BankCardWidget({
    super.key,
    required this.bank,
    this.isTap = false,
    this.onTap,
  });

  final BankEntity bank;
  final bool isTap;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: isTap ? null : onTap,
        child: UICardPrimaryWidget(
          color: isTap ? AppColor.whiteFair : null,
          width: double.infinity,
          child: Row(
            children: [
              Image.asset(
                IconBankHelper(bank.name ?? '').getIconBank(),
                height: 32.h,
                width: 32.w,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: UITextPrimaryWidget(
                  title: bank.name ?? '',
                  fontSize: 12.sp,
                  color: AppColor.blackMassive,
                  fontWeight: FontWeight.w700,
                ),
              ),
              UICardChargeWidget(charge: bank.charge ?? 0),
            ],
          ),
        ),
      ),
    );
  }
}
