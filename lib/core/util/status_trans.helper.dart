import 'package:sukmaapps/core/enum/status.enum.dart';

class StatusTransHelper {
  static Status getStatus(int statusCode) {
    if (statusCode == -1) return Status.outstanding;
    if (statusCode == 0) return Status.proses;
    if (statusCode == 1) return Status.success;
    return Status.failed;
  }
}
