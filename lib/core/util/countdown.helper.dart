class CountdownHelper {
  CountdownHelper._();

  static DateTime? toLocalExpiredAt(DateTime? expiredAt) {
    return expiredAt?.toLocal();
  }

  /// Sisa waktu hingga [expiredAt]. Mengembalikan [Duration.zero] jika null
  /// atau sudah lewat.
  static Duration remainingUntil(DateTime? expiredAt) {
    final localExpiredAt = toLocalExpiredAt(expiredAt);
    if (localExpiredAt == null) return Duration.zero;

    final diff = localExpiredAt.difference(DateTime.now());
    if (diff.inSeconds <= 0) return Duration.zero;

    return diff;
  }

  static bool isExpired(DateTime? expiredAt) {
    final localExpiredAt = toLocalExpiredAt(expiredAt);
    if (localExpiredAt == null) return false;

    return localExpiredAt.difference(DateTime.now()).inSeconds <= 0;
  }
}
