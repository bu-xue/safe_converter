import 'package:test/test.dart';
import 'package:safe_converter/safe_converter.dart';

void main() {
  group('intNullableConvert and tryIntConvert Tests', () {
    test('null input returns null', () {
      expect(intNullableConvert(null), isNull);
      expect(tryIntConvert(null), isNull);
    });

    test('int input returns itself', () {
      expect(intNullableConvert(42), 42);
      expect(tryIntConvert(42), 42);
    });

    test('double input converts to int', () {
      expect(intNullableConvert(42.7), 42);
      expect(tryIntConvert(42.7), 42);
    });

    test('String input converts to int', () {
      expect(tryIntConvert("42"), 42);
      expect(tryIntConvert("invalid"), isNull);
    });
  });

  group('intConvert Tests', () {
    test('Converts with defaultValue fallback', () {
      expect(intConvert(null), 0);
      expect(intConvert("invalid", defaultValue: 99), 99);
    });
  });

  group('SafeConvertOnObject2Int Extension Tests', () {
    test('safe2IntNullable and try2Int works correctly', () {
      expect("42".safe2IntNullable(), 42);
      expect("42".try2Int(), 42);
      expect("invalid".safe2IntNullable(), isNull);
      expect("invalid".try2Int(), isNull);
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

    test('getIntOrNull and tryGetInt works correctly', () {
      expect(testMap.getIntOrNull('intValue'), 42);
      expect(testMap.tryGetInt('intValue'), 42);
      expect(testMap.getIntOrNull('invalidValue'), isNull);
      expect(testMap.tryGetInt('invalidValue'), isNull);
    });

    test('getInt works correctly', () {
      expect(testMap.getInt('intValue'), 42);
      expect(testMap.getInt('invalidValue', defaultValue: 99), 99);
    });
  });

  group('asInt, asIntOrNull and tryInt Tests', () {
    final testMap = {
      'key': "42",
    };

    test('asIntOrNull and tryInt works correctly', () {
      expect(asIntOrNull(testMap, 'key'), 42);
      expect(tryInt(testMap, 'key'), 42);
      expect(asIntOrNull(testMap, 'missing'), isNull);
      expect(tryInt(testMap, 'missing'), isNull);
    });

    test('asInt works correctly', () {
      expect(asInt(testMap, 'key'), 42);
      expect(asInt(testMap, 'missing', defaultValue: 99), 99);
    });
  });
}
