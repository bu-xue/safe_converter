import 'package:test/test.dart';
import 'package:safe_converter/safe_converter.dart';

void main() {
  group('stringNullableConvert Tests', () {
    test('null input returns null', () {
      expect(stringNullableConvert(null), isNull);
    });

    test('String input returns itself', () {
      expect(stringNullableConvert("test"), "test");
    });

    test('int input converts to String', () {
      expect(stringNullableConvert(42), "42");
      expect(stringNullableConvert(-42), "-42");
    });

    test('double input converts to String', () {
      expect(stringNullableConvert(42.7), "42.7");
      expect(stringNullableConvert(-42.7), "-42.7");
    });

    test('double NaN returns null', () {
      expect(stringNullableConvert(double.nan), isNull);
    });

    test('bool input converts to String', () {
      expect(stringNullableConvert(true), "true");
      expect(stringNullableConvert(false), "false");
    });

    test('Map/List input converts to JSON String', () {
      expect(stringNullableConvert({'a': 1}), '{"a":1}');
      expect(stringNullableConvert([1, 2]), '[1,2]');
    });

    test('Other types use toString if enabled', () {
      expect(stringNullableConvert(DateTime(2024, 1, 1), useToString: true),
          "2024-01-01 00:00:00.000");
      expect(stringNullableConvert(DateTime(2024, 1, 1), useToString: false),
          isNull);
    });
  });

  group('stringConvert Tests', () {
    test('Converts with defaultValue fallback', () {
      expect(stringConvert(null), "");
      expect(
          stringConvert(DateTime(2024, 1, 1),
              defaultValue: "default", useToString: false),
          "default");
    });
  });

  group('SafeConvertOnObject2String Extension Tests', () {
    test('safe2StringNullable works correctly', () {
      expect("test".safe2StringNullable(), "test");
      expect(
          DateTime(2024, 1, 1).safe2StringNullable(useToString: false), isNull);
    });

    test('safe2String works correctly', () {
      expect("test".safe2String(), "test");
      expect(
          DateTime(2024, 1, 1)
              .safe2String(defaultValue: "default", useToString: false),
          "default");
    });
  });

  group('SafeConvertOnMap2String Extension Tests', () {
    final testMap = {
      'stringValue': "test",
      'intValue': 42,
      'nullValue': null,
    };

    test('getStringOrNull works correctly', () {
      expect(testMap.getStringOrNull('stringValue'), "test");
      expect(testMap.getStringOrNull('nullValue'), isNull);
    });

    test('getString works correctly', () {
      expect(testMap.getString('stringValue'), "test");
      expect(
          testMap.getString('missingKey', defaultValue: "default"), "default");
    });
  });

  group('asString and asStringOrNull Tests', () {
    final testMap = {
      'key': "test",
    };

    test('asStringOrNull works correctly', () {
      expect(asStringOrNull(testMap, 'key'), "test");
      expect(asStringOrNull(testMap, 'missingKey'), isNull);
    });

    test('asString works correctly', () {
      expect(asString(testMap, 'key'), "test");
      expect(
          asString(testMap, 'missingKey', defaultValue: "default"), "default");
    });
  });
}
