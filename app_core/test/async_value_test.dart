import 'package:app_core/app_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AsyncValue<void>', () {
    test('data(null) is treated as resolved success', () {
      const value = AsyncValue<void>.data(null);

      expect(value.hasData, isTrue);
      expect(value.hasValue, isTrue);
      expect(value.isLoading, isFalse);
      expect(value.hasError, isFalse);

      var called = false;
      value.when(
        loading: () => fail('should not be loading'),
        error: (_, __) => fail('should not be error'),
        data: (_) => called = true,
      );
      expect(called, isTrue);
    });

    test('loading transitions to data(null) via when', () {
      const loading = AsyncValue<void>.loading();
      const success = AsyncValue<void>.data(null);

      expect(loading.hasValue, isFalse);
      expect(success.hasValue, isTrue);
    });
  });

  group('AsyncValue<String?>', () {
    test('data(null) is treated as resolved nullable data', () {
      const value = AsyncValue<String?>.data(null);

      expect(value.hasData, isTrue);
      expect(value.hasValue, isTrue);
      expect(value.requireValue, isNull);

      String? result;
      value.when(
        loading: () => fail('should not be loading'),
        error: (_, __) => fail('should not be error'),
        data: (data) => result = data,
      );
      expect(result, isNull);
    });
  });

  group('AsyncValue<String>', () {
    test('preserves previous data during copyWithLoading', () {
      const initial = AsyncValue<String>.data('cached');
      final loading = initial.copyWithLoading();

      expect(loading.hasValue, isTrue);
      expect(loading.requireValue, 'cached');
      expect(
        loading.when(
          skipLoadingOnReload: true,
          loading: () => 'loading',
          error: (_, __) => 'error',
          data: (data) => data,
        ),
        'cached',
      );
    });
  });
}
