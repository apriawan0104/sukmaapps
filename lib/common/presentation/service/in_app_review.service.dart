import 'package:app_core/app_core.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../config/config.dart';

part 'in_app_review.service.g.dart';

@riverpod
class InAppReviewService extends _$InAppReviewService {
  final InAppReview _inAppReview = InAppReview.instance;
  static const String _lastReviewRequestKey = 'last_review_request';
  static const String _lastSkipReviewRequestKey = 'last_skip_review_request';
  static const String _successfulTransactionsKey =
      'successful_transactions_count';
  static const int _minTransactionsForReview = 100;
  static const Duration _minDaysBetweenReviews = Duration(days: 30);
  static const Duration _skipDaysReview = Duration(days: 1);

  late StorageService _storage;

  @override
  FutureOr<void> build() {
    _storage = getIt<StorageService>();
  }

  Future<void> requestReview() async {
    try {
      final lastReviewTime = DateTime.fromMillisecondsSinceEpoch(
        await _readInt(_lastReviewRequestKey) ?? 0,
      );

      if (DateTime.now().difference(lastReviewTime) < _minDaysBetweenReviews) {
        return;
      }

      if (await _inAppReview.isAvailable()) {
        await _inAppReview.requestReview();
        await _writeInt(
          _lastReviewRequestKey,
          DateTime.now().millisecondsSinceEpoch,
        );
      } else {
        await openStoreListing();
      }
    } catch (_) {}
  }

  Future<void> incrementSuccessfulTransactions() async {
    try {
      final currentCount = await _readInt(_successfulTransactionsKey) ?? 0;
      await _writeInt(_successfulTransactionsKey, currentCount + 1);
    } catch (_) {}
  }

  Future<void> openStoreListing() async {
    try {
      await resetSuccessfulTransactions();
      await _inAppReview.openStoreListing(
        appStoreId: 'id6578454686',
        microsoftStoreId: 'com.sukmaconvert.sukma',
      );
    } catch (_) {}
  }

  Future<bool> hasMetMinimumTransactions() async {
    try {
      final now = DateTime.now();
      final currentCount = await _readInt(_successfulTransactionsKey) ?? 0;

      final lastSkipReviewTimeStamp = await _readInt(_lastSkipReviewRequestKey);
      if (lastSkipReviewTimeStamp != null) {
        final lastSkipReviewTime =
            DateTime.fromMillisecondsSinceEpoch(lastSkipReviewTimeStamp);
        if (now.difference(lastSkipReviewTime) < _skipDaysReview) {
          return false;
        }
      }

      final lastReviewTimeStamp = await _readInt(_lastReviewRequestKey);
      if (lastReviewTimeStamp != null) {
        final lastReviewTime =
            DateTime.fromMillisecondsSinceEpoch(lastReviewTimeStamp);
        if (now.difference(lastReviewTime) < _minDaysBetweenReviews) {
          return false;
        }
      }

      return currentCount >= _minTransactionsForReview;
    } catch (_) {
      return false;
    }
  }

  Future<void> resetSuccessfulTransactions() async {
    try {
      await _writeInt(_successfulTransactionsKey, 0);
      await _writeInt(
        _lastReviewRequestKey,
        DateTime.now().millisecondsSinceEpoch,
      );
      await _storage.delete(_lastSkipReviewRequestKey);
    } catch (_) {}
  }

  Future<void> skipReview() async {
    try {
      await _writeInt(
        _lastSkipReviewRequestKey,
        DateTime.now().millisecondsSinceEpoch,
      );
    } catch (_) {}
  }

  Future<int?> _readInt(String key) async {
    final result = await _storage.get<int>(key);
    return result.fold((_) => null, (value) => value);
  }

  Future<void> _writeInt(String key, int value) async {
    await _storage.save(key, value);
  }
}
