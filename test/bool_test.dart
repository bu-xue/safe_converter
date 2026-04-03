import 'package:safe_converter/safe_converter.dart';
import 'package:test/test.dart';

void main() {
  group('boolNullableConvert Tests', () {
    test('null input returns null', () {
      expect(boolNullableConvert(null), isNull);
    });

    test('bool input returns itself', () {
      expect(boolNullableConvert(true), true);
      expect(boolNullableConvert(false), false);
    });

    test('int input converts correctly', () {
      expect(boolNullableConvert(0), false);
      expect(boolNullableConvert(1), true);
      expect(boolNullableConvert(-1), true);
    });

    test('double input converts correctly', () {
      expect(boolNullableConvert(0.0), false);
      expect(boolNullableConvert(1.0), true);
      expect(boolNullableConvert(-1.0), true);
      expect(boolNullableConvert(double.nan), false);
    });

    test('String input converts correctly', () {
      expect(boolNullableConvert("true"), true);
      expect(boolNullableConvert("True"), true);
      expect(boolNullableConvert("yes"), true);
      expect(boolNullableConvert("on"), true);
      expect(boolNullableConvert("false"), false);
      expect(boolNullableConvert("no"), false);
      expect(boolNullableConvert("off"), false);
      expect(boolNullableConvert("1"), true);
      expect(boolNullableConvert("0"), false);
      expect(boolNullableConvert("random"), isNull);
    });
  });

  group('SafeConvertOnObject2Bool Extension Tests', () {
    test('safe2BoolNullable works correctly', () {
      expect("yes".safe2BoolNullable(), true);
      expect("no".safe2BoolNullable(), false);
      expect("random".safe2BoolNullable(), isNull);
    });
  });

  group('SafeConvertOnMap2Bool Extension Tests', () {
    final testMap = {
      'stringYes': "yes",
      'stringNo': "no",
      'stringRandom': "random"
    };

    test('getBoolOrNull works correctly', () {
      expect(testMap.getBoolOrNull('stringYes'), true);
      expect(testMap.getBoolOrNull('stringNo'), false);
      expect(testMap.getBoolOrNull('stringRandom'), isNull);
    });
  });
}
