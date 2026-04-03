import 'package:test/test.dart';
import 'package:safe_converter/safe_converter.dart';

void main() {
  group('doubleNullableConvert Tests', () {
    test('null input returns null', () {
      expect(doubleNullableConvert(null), isNull);
    });

    test('double input returns itself', () {
      expect(doubleNullableConvert(1.23), 1.23);
    });

    test('int input converts to double', () {
      expect(doubleNullableConvert(42), 42.0);
    });

    test('bool input converts to double', () {
      expect(doubleNullableConvert(true), 1.0);
      expect(doubleNullableConvert(false), 0.0);
    });

    test('String input converts to double', () {
      expect(doubleNullableConvert("42.5"), 42.5);
      expect(doubleNullableConvert("-1.23"), -1.23);
    });

    test('Invalid String input returns null', () {
      expect(doubleNullableConvert("invalid"), isNull);
    });

    test('Other types return null', () {
      expect(doubleNullableConvert([]), isNull);
      expect(doubleNullableConvert({}), isNull);
    });
  });

  group('doubleConvert Tests', () {
    test('Converts with defaultValue fallback', () {
      expect(doubleConvert(null), 0.0);
      expect(doubleConvert("invalid", defaultValue: 3.14), 3.14);
    });
  });

  group('SafeConvertObject2double Extension Tests', () {
    test('safe2DoubleNullable works correctly', () {
      expect("42.5".safe2DoubleNullable(), 42.5);
      expect("invalid".safe2DoubleNullable(), isNull);
    });

    test('safe2Double works correctly', () {
      expect("42.5".safe2Double(), 42.5);
      expect("invalid".safe2Double(defaultValue: 3.14), 3.14);
    });
  });

  group('MapSafeConvert2double Extension Tests', () {
    final testMap = {
      'doubleValue': 42.5,
      'intValue': 42,
      'stringValue': "42.5",
      'invalidValue': "invalid",
      'nullValue': null,
    };

    test('getDoubleOrNull works correctly', () {
      expect(testMap.getDoubleOrNull('doubleValue'), 42.5);
      expect(testMap.getDoubleOrNull('invalidValue'), isNull);
    });

    test('getDouble works correctly', () {
      expect(testMap.getDouble('doubleValue'), 42.5);
      expect(testMap.getDouble('invalidValue', defaultValue: 3.14), 3.14);
    });
  });

  group('asDouble and asDoubleOrNull Tests', () {
    final testMap = {
      'key': "42.5",
    };

    test('asDoubleOrNull works correctly', () {
      expect(asDoubleOrNull(testMap, 'key'), 42.5);
      expect(asDoubleOrNull(testMap, 'missing'), isNull);
    });

    test('asDouble works correctly', () {
      expect(asDouble(testMap, 'key'), 42.5);
      expect(asDouble(testMap, 'missing', defaultValue: 3.14), 3.14);
    });
  });
}
