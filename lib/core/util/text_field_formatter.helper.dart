import 'package:flutter/services.dart';

class TextFieldFormatterHelper {
  static FormatPhoneNumber get formatPhoneNumber => FormatPhoneNumber();
}

class FormatPhoneNumber extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Prevent entering a space as the initial character
    if (newValue.text.isNotEmpty) {
      if (newValue.text.substring(0, 1) == '0') {
        return oldValue;
      }
    }
    return newValue;
  }
}
