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

  static String formatCountdown(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    final paddedMinutes = minutes.toString().padLeft(2, '0');
    final paddedSeconds = seconds.toString().padLeft(2, '0');

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:$paddedMinutes:$paddedSeconds';
    }

    return '$paddedMinutes:$paddedSeconds';
  }
}
