import 'package:safe_converter/safe_converter.dart';
import 'package:test/test.dart';

void main() {
  group('boolNullableConvert and tryBoolConvert Tests', () {
    test('null input returns null', () {
      expect(boolNullableConvert(null), isNull);
      expect(tryBoolConvert(null), isNull);
    });

    test('bool input returns itself', () {
      expect(boolNullableConvert(true), true);
      expect(tryBoolConvert(true), true);
    });

    test('int input converts correctly', () {
      expect(tryBoolConvert(1), true);
      expect(tryBoolConvert(0), false);
    });

    test('String input converts correctly', () {
      expect(tryBoolConvert("true"), true);
      expect(tryBoolConvert("yes"), true);
      expect(tryBoolConvert("false"), false);
      expect(tryBoolConvert("random"), isNull);
    });
  });

  group('SafeConvertOnObject2Bool Extension Tests', () {
    test('safe2BoolNullable and try2Bool works correctly', () {
      expect("yes".safe2BoolNullable(), true);
      expect("yes".try2Bool(), true);
      expect("no".safe2BoolNullable(), false);
      expect("no".try2Bool(), false);
      expect("random".safe2BoolNullable(), isNull);
      expect("random".try2Bool(), isNull);
    });
  });

  group('SafeConvertOnMap2Bool Extension Tests', () {
    final testMap = {
      'stringYes': "yes",
      'stringNo': "no",
      'stringRandom': "random"
    };

    test('getBoolOrNull and tryGetBool works correctly', () {
      expect(testMap.getBoolOrNull('stringYes'), true);
      expect(testMap.tryGetBool('stringYes'), true);
      expect(testMap.getBoolOrNull('stringNo'), false);
      expect(testMap.tryGetBool('stringNo'), false);
      expect(testMap.getBoolOrNull('stringRandom'), isNull);
      expect(testMap.tryGetBool('stringRandom'), isNull);
    });
  });

  group('asBool, asBoolOrNull and tryBool Tests', () {
    final testMap = {'key': "yes"};
    test('asBoolOrNull and tryBool works correctly', () {
      expect(asBoolOrNull(testMap, 'key'), true);
      expect(tryBool(testMap, 'key'), true);
      expect(tryBool(testMap, 'missing'), isNull);
    });
  });
}
