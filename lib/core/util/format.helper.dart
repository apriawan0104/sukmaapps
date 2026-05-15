import 'package:intl/intl.dart';

class FormatHelper {
  static String formatThousandFromNumber(num? number) {
    return NumberFormat.decimalPattern('vi_VN').format(number ?? 0);
  }

  static DateTime stringtoDate(String date) {
    return DateTime.parse(date);
  }

  static String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy – HH:mm').format(date);
  }

  static String formatInterval(DateTime date) {
    return DateFormat('mm:ss').format(date);
  }
}
