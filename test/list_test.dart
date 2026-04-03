import 'package:test/test.dart';
import 'package:safe_converter/safe_converter.dart';

void main() {
  group('listNullableConvert Tests', () {
    test('null input returns null', () {
      expect(listNullableConvert<int>(null), isNull);
    });

    test('List input returns List with correct types', () {
      expect(listNullableConvert<int>([1, 2, 3]), [1, 2, 3]);
      expect(listNullableConvert<int>([1, 'a', 2]), [1, 2]); // Filters non-int
    });

    test('String input parses as JSON and converts', () {
      expect(listNullableConvert<int>('[1,2,3]'), [1, 2, 3]);
      expect(listNullableConvert<int>('[1,"a",2]'), [1, 2]);
    });

    test('String input fails to parse returns null', () {
      expect(listNullableConvert<int>('invalid json'), isNull);
    });
  });

  group('listConvert Tests', () {
    test('Provides defaultValue fallback', () {
      expect(listConvert<int>(null, defaultValue: [9, 8]), [9, 8]);
      expect(listConvert<int>(null), []);
    });
  });

  group('SafeConvertObject2List Extension Tests', () {
    test('safe2ListNullable works correctly', () {
      expect([1, 2, 3].safe2ListNullable<int>(), [1, 2, 3]);
      expect('[1,2]'.safe2ListNullable<int>(), [1, 2]);
      expect('invalid'.safe2ListNullable<int>(), isNull);
    });

    test('safe2List works correctly', () {
      expect([1, 2].safe2List<int>(), [1, 2]);
      expect('[1,2]'.safe2List<int>(), [1, 2]);
      expect('invalid'.safe2List<int>(defaultValue: [0]), [0]);
    });
  });

  group('MapSafeConvert2List Extension Tests', () {
    final testMap = {
      'intList': [1, 2, 3],
      'stringList': '["a", "b"]',
      'invalidList': 'invalid',
    };

    test('getListOrNull works correctly', () {
      expect(testMap.getListOrNull<int>('intList'), [1, 2, 3]);
      expect(testMap.getListOrNull<String>('stringList'), ['a', 'b']);
      expect(testMap.getListOrNull<int>('invalidList'), isNull);
    });

    test('getList works correctly', () {
      expect(testMap.getList<int>('intList'), [1, 2, 3]);
      expect(testMap.getList<String>('stringList'), ['a', 'b']);
      expect(testMap.getList<int>('missingKey', defaultValue: [0]),
          [0]); // Fallback
    });
  });

  group('asList and asListOrNull Tests', () {
    final testMap = {
      'key': [1, 2, 3]
    };

    test('asListOrNull works correctly', () {
      expect(asListOrNull<int>(testMap, 'key'), [1, 2, 3]);
      expect(asListOrNull<int>(testMap, 'missingKey'), isNull);
    });

    test('asList works correctly', () {
      expect(asList<int>(testMap, 'key'), [1, 2, 3]);
      expect(asList<int>(testMap, 'missingKey', defaultValue: [0]), [0]);
    });
  });
}
