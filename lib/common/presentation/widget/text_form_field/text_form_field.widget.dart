import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/app.dart';

class UITextFormFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? errorText;
  final Function(String)? onChanged;

  final String? labelText;
  final String hintText;
  final bool enabled;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final List<TextInputFormatter> inputFormatters;
  final Function? onClicked;
  final bool isArea;
  final Function(bool)? onTextFieldTap;
  final Function(String)? onFieldSubmitted;
  final Color? borderColor;
  final Key? keyTextField;
  final String? messageValidator;
  final String? Function(String?)? customValidator;

  const UITextFormFieldWidget({
    super.key,
    this.controller,
    this.errorText,
    this.onChanged,
    this.labelText,
    this.hintText = '',
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.prefixIcon,
    this.suffixIcon,
    this.inputFormatters = const [],
    this.isArea = false,
    this.onClicked,
    this.onTextFieldTap,
    this.onFieldSubmitted,
    this.borderColor = const Color(0xFFDADCE9),
    this.keyTextField,
    this.messageValidator,
    this.customValidator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            if (onClicked != null) {
              onClicked!();
            }
          },
          child: Container(
            color: Colors.transparent,
            child: Focus(
              onFocusChange: (focus) {
                if (onTextFieldTap != null) onTextFieldTap!(focus);
              },
              child: TextFormField(
                key: keyTextField,
                controller: controller,
                enabled: enabled,
                enableSuggestions: false,
                keyboardType: keyboardType,
                onChanged: (value) {
                  if (onChanged != null) onChanged!(value);
                },
                textInputAction: textInputAction,
                inputFormatters: inputFormatters,
                maxLines: isArea ? 5 : null,
                validator: (customValidator == null)
                    ? (messageValidator != null)
                        ? (value) {
                            if (value == null || value.isEmpty) {
                              return messageValidator;
                            }
                            return null;
                          }
                        : null
                    : customValidator ??
                        (value) {
                          return null;
                        },
                style: GoogleFonts.plusJakartaSans(
                  color: AppColor.blackMassive,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                onFieldSubmitted: (value) {
                  if (onFieldSubmitted != null) onFieldSubmitted!(value);
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 10,
                    bottom: 10,
                  ),
                  suffixIcon: suffixIcon,
                  prefixIcon: prefixIcon,
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 0,
                    minHeight: 0,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: borderColor!,
                      )),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      )),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      )),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.blackMassive),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: GoogleFonts.plusJakartaSans(
                    color: AppColor.greyTextField,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  hintText: hintText,
                  fillColor:
                      enabled || onClicked != null ? Colors.white : Colors.grey,
                  errorText: (errorText ?? '') != '' ? errorText : null,
                  errorStyle: GoogleFonts.plusJakartaSans(
                    color: AppColor.errorHeavy,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
