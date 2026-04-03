import 'package:test/test.dart';
import 'package:safe_converter/safe_converter.dart';

void main() {
  group('numNullableConvert Tests', () {
    test('null input returns null', () {
      expect(numNullableConvert(null), isNull);
    });

    test('num input returns itself', () {
      expect(numNullableConvert(42), 42);
      expect(numNullableConvert(42.7), 42.7);
    });

    test('bool input converts correctly', () {
      expect(numNullableConvert(true), 1);
      expect(numNullableConvert(false), 0);
    });

    test('String input converts correctly', () {
      expect(numNullableConvert("42"), 42);
      expect(numNullableConvert("42.7"), 42.7);
      expect(numNullableConvert("invalid"), isNull);
    });
  });

  group('SafeConvertOnObject2Num Extension Tests', () {
    test('safe2NumNullable works correctly', () {
      expect("42.7".safe2NumNullable(), 42.7);
    });

    test('safe2Num works correctly', () {
      expect("invalid".safe2Num(defaultValue: 99), 99);
    });
  });

  group('SafeConvertOnMap2Num Extension Tests', () {
    final testMap = {'key': "42.7"};
    test('getNum works correctly', () {
      expect(testMap.getNum('key'), 42.7);
    });
  });
}
