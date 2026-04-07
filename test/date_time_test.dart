import 'package:test/test.dart';
import 'package:safe_converter/safe_converter.dart';

void main() {
  group('dateTimeNullableConvert and tryDateTimeConvert Tests', () {
    test('null input returns null', () {
      expect(dateTimeNullableConvert(null), isNull);
      expect(tryDateTimeConvert(null), isNull);
    });

    test('DateTime input returns itself', () {
      final now = DateTime.now();
      expect(dateTimeNullableConvert(now), now);
      expect(tryDateTimeConvert(now), now);
    });

    test('int input converts as milliseconds timestamp', () {
      const timestamp = 1704067200000; // 2024-01-01 00:00:00
      final result = tryDateTimeConvert(timestamp);
      expect(result?.year, 2024);
      expect(result?.month, 1);
      expect(result?.day, 1);
    });

    test('String ISO8601 input converts correctly', () {
      const isoString = "2024-05-20T13:14:00Z";
      final result = tryDateTimeConvert(isoString);
      expect(result, isNotNull);
      expect(result?.year, 2024);
      expect(result?.month, 5);
      expect(result?.day, 20);
    });

    test('Invalid String returns null', () {
      expect(tryDateTimeConvert("not-a-date"), isNull);
    });
  });

  group('SafeConvertOnObject2DateTime Extension Tests', () {
    test('safe2DateTime, safe2DateTimeNullable and try2DateTime works correctly',
        () {
      final fallback = DateTime(2000);
      expect("invalid".safe2DateTime(defaultValue: fallback), fallback);
      expect("2024-01-01".safe2DateTimeNullable()?.year, 2024);
      expect("2024-01-01".try2DateTime()?.year, 2024);
      expect("invalid".try2DateTime(), isNull);
    });
  });

  group('SafeConvertOnMap2DateTime Extension Tests', () {
    final testMap = {
      'timeStr': "2024-01-01T00:00:00Z",
      'timeInt': 1704067200000,
    };

    test('getDateTime, getDateTimeOrNull and tryGetDateTime works correctly',
        () {
      expect(testMap.getDateTime('timeStr').year, 2024);
      expect(testMap.getDateTimeOrNull('timeStr')?.year, 2024);
      expect(testMap.tryGetDateTime('timeStr')?.year, 2024);
      expect(testMap.getDateTime('timeInt').year, 2024);
      expect(testMap.tryGetDateTime('missing'), isNull);
    });
  });

  group('asDateTimeOrNull and tryDateTime Tests', () {
    final testMap = {
      'key': "2024-01-01T00:00:00Z",
    };

    test('asDateTimeOrNull and tryDateTime works correctly', () {
      expect(asDateTimeOrNull(testMap, 'key')?.year, 2024);
      expect(tryDateTime(testMap, 'key')?.year, 2024);
      expect(tryDateTime(testMap, 'missing'), isNull);
    });
  });
}
