import 'package:test/test.dart';
import 'package:safe_converter/safe_converter.dart';

void main() {
  group('dateTimeNullableConvert Tests', () {
    test('null input returns null', () {
      expect(dateTimeNullableConvert(null), isNull);
    });

    test('DateTime input returns itself', () {
      final now = DateTime.now();
      expect(dateTimeNullableConvert(now), now);
    });

    test('int input converts as milliseconds timestamp', () {
      const timestamp = 1704067200000; // 2024-01-01 00:00:00
      final result = dateTimeNullableConvert(timestamp);
      expect(result?.year, 2024);
      expect(result?.month, 1);
      expect(result?.day, 1);
    });

    test('String ISO8601 input converts correctly', () {
      const isoString = "2024-05-20T13:14:00Z";
      final result = dateTimeNullableConvert(isoString);
      expect(result, isNotNull);
      expect(result?.year, 2024);
      expect(result?.month, 5);
      expect(result?.day, 20);
    });

    test('Invalid String returns null', () {
      expect(dateTimeNullableConvert("not-a-date"), isNull);
    });
  });

  group('SafeConvertOnObject2DateTime Extension Tests', () {
    test('safe2DateTime works with fallback', () {
      final fallback = DateTime(2000);
      expect("invalid".safe2DateTime(defaultValue: fallback), fallback);
    });
  });

  group('SafeConvertOnMap2DateTime Extension Tests', () {
    final testMap = {
      'timeStr': "2024-01-01T00:00:00Z",
      'timeInt': 1704067200000,
    };

    test('getDateTime works correctly', () {
      expect(testMap.getDateTime('timeStr').year, 2024);
      expect(testMap.getDateTime('timeInt').year, 2024);
    });
  });
}
