import 'package:test/test.dart';
import 'package:safe_converter/safe_converter.dart';

void main() {
  group('numNullableConvert and tryNumConvert Tests', () {
    test('null input returns null', () {
      expect(numNullableConvert(null), isNull);
      expect(tryNumConvert(null), isNull);
    });

    test('num input returns itself', () {
      expect(numNullableConvert(42), 42);
      expect(tryNumConvert(42.7), 42.7);
    });

    test('bool input converts correctly', () {
      expect(tryNumConvert(true), 1);
      expect(tryNumConvert(false), 0);
    });

    test('String input converts correctly', () {
      expect(tryNumConvert("42"), 42);
      expect(tryNumConvert("42.7"), 42.7);
      expect(tryNumConvert("invalid"), isNull);
    });
  });

  group('SafeConvertOnObject2Num Extension Tests', () {
    test('safe2NumNullable and try2Num works correctly', () {
      expect("42.7".safe2NumNullable(), 42.7);
      expect("42.7".try2Num(), 42.7);
      expect("invalid".try2Num(), isNull);
    });

    test('safe2Num works correctly', () {
      expect("invalid".safe2Num(defaultValue: 99), 99);
    });
  });

  group('SafeConvertOnMap2Num Extension Tests', () {
    final testMap = {'key': "42.7"};
    test('getNum, getNumOrNull and tryGetNum works correctly', () {
      expect(testMap.getNum('key'), 42.7);
      expect(testMap.getNumOrNull('key'), 42.7);
      expect(testMap.tryGetNum('key'), 42.7);
      expect(testMap.tryGetNum('missing'), isNull);
    });
  });

  group('asNumOrNull and tryNum Tests', () {
    final testMap = {'key': "42.7"};
    test('asNumOrNull and tryNum works correctly', () {
      expect(asNumOrNull(testMap, 'key'), 42.7);
      expect(tryNum(testMap, 'key'), 42.7);
      expect(tryNum(testMap, 'missing'), isNull);
    });
  });
}
