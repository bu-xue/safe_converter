import 'package:test/test.dart';
import 'package:safe_converter/safe_converter.dart';

void main() {
  group('intNullableConvert Tests', () {
    test('null input returns null', () {
      expect(intNullableConvert(null), isNull);
    });

    test('int input returns itself', () {
      expect(intNullableConvert(42), 42);
    });

    test('double input converts to int', () {
      expect(intNullableConvert(42.7), 42);
      expect(intNullableConvert(-42.7), -42);
    });

    test('double NaN or Infinite returns null', () {
      expect(intNullableConvert(double.nan), isNull);
      expect(intNullableConvert(double.infinity), isNull);
      expect(intNullableConvert(double.negativeInfinity), isNull);
    });

    test('bool input converts to int', () {
      expect(intNullableConvert(true), 1);
      expect(intNullableConvert(false), 0);
    });

    test('String input converts to int', () {
      expect(intNullableConvert("42"), 42);
      expect(intNullableConvert("-42"), -42);
    });

    test('String input converts to int via double', () {
      expect(intNullableConvert("42.7"), 42);
      expect(intNullableConvert("-42.7"), -42);
    });

    test('Invalid String input returns null', () {
      expect(intNullableConvert("invalid"), isNull);
    });

    test('Other types return null', () {
      expect(intNullableConvert([]), isNull);
      expect(intNullableConvert({}), isNull);
    });
  });

  group('intConvert Tests', () {
    test('Converts with defaultValue fallback', () {
      expect(intConvert(null), 0);
      expect(intConvert("invalid", defaultValue: 99), 99);
    });
  });

  group('SafeConvertOnObject2Int Extension Tests', () {
    test('safe2IntNullable works correctly', () {
      expect("42".safe2IntNullable(), 42);
      expect("invalid".safe2IntNullable(), isNull);
    });

    test('safe2Int works correctly', () {
      expect("42".safe2Int(), 42);
      expect("invalid".safe2Int(defaultValue: 99), 99);
    });
  });

  group('SafeConvertOnMap2Int Extension Tests', () {
    final testMap = {
      'intValue': 42,
      'doubleValue': 42.7,
      'stringValue': "42",
      'invalidValue': "invalid",
      'nullValue': null,
    };

    test('getIntOrNull works correctly', () {
      expect(testMap.getIntOrNull('intValue'), 42);
      expect(testMap.getIntOrNull('invalidValue'), isNull);
    });

    test('getInt works correctly', () {
      expect(testMap.getInt('intValue'), 42);
      expect(testMap.getInt('invalidValue', defaultValue: 99), 99);
    });
  });

  group('asInt and asIntOrNull Tests', () {
    final testMap = {
      'key': "42",
    };

    test('asIntOrNull works correctly', () {
      expect(asIntOrNull(testMap, 'key'), 42);
      expect(asIntOrNull(testMap, 'missing'), isNull);
    });

    test('asInt works correctly', () {
      expect(asInt(testMap, 'key'), 42);
      expect(asInt(testMap, 'missing', defaultValue: 99), 99);
    });
  });
}
