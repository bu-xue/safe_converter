import 'package:test/test.dart';
import 'package:safe_converter/safe_converter.dart';

void main() {
  group('mapNullableConvert Tests', () {
    test('null input returns null', () {
      expect(mapNullableConvert<String, int>(null), isNull);
    });

    test('Map input converts correctly', () {
      expect(
          mapNullableConvert<String, int>({'a': 1, 'b': 2}), {'a': 1, 'b': 2});
      expect(
          mapNullableConvert<int, String>({1: 'a', 2: 'b'}), {1: 'a', 2: 'b'});
    });

    test('String input parses as JSON and converts', () {
      expect(
        mapNullableConvert<String, int>('{"a":1,"b":2}'),
        {'a': 1, 'b': 2},
      );
    });

    test('String input fails to parse returns null', () {
      expect(mapNullableConvert<String, int>('invalid json'), isNull);
    });

    test('Map with invalid types filters non-matching entries', () {
      expect(
          mapNullableConvert<String, int>({'a': 1, 'b': 'invalid'}), {'a': 1});
    });
  });

  group('mapConvert Tests', () {
    test('Provides defaultValue fallback', () {
      expect(mapConvert<String, int>(null, defaultValue: {'default': 0}),
          {'default': 0});
      expect(mapConvert<String, int>(null), {});
    });
  });

  group('SafeConvertObject2Map Extension Tests', () {
    test('safe2MapNullable works correctly', () {
      expect(
          {'a': 1, 'b': 2}.safe2MapNullable<String, int>(), {'a': 1, 'b': 2});
      expect('{"a":1}'.safe2MapNullable<String, int>(), {'a': 1});
      expect('invalid'.safe2MapNullable<String, int>(), isNull);
    });

    test('safe2Map works correctly', () {
      expect({'a': 1}.safe2Map<String, int>(), {'a': 1});
      expect('{"a":1}'.safe2Map<String, int>(), {'a': 1});
      expect('invalid'.safe2Map<String, int>(defaultValue: {'default': 0}),
          {'default': 0});
    });
  });

  group('MapSafeConvert2Map Extension Tests', () {
    final testMap = {
      'nested': {'a': 1, 'b': 2},
      'invalid': 'invalid',
    };

    test('getMapOrNull works correctly', () {
      expect(
        testMap.getMapOrNull<String, int>('nested'),
        {'a': 1, 'b': 2},
      );
      expect(testMap.getMapOrNull<String, int>('invalid'), isNull);
    });

    test('getMap works correctly', () {
      expect(testMap.getMap<String, int>('nested'), {'a': 1, 'b': 2});
      expect(
        testMap.getMap<String, int>('missingKey', defaultValue: {'default': 0}),
        {'default': 0},
      );
    });
  });

  group('asMap and asMapOrNull Tests', () {
    final testMap = {
      'key': {'a': 1, 'b': 2}
    };

    test('asMapOrNull works correctly', () {
      expect(asMapOrNull<String, int>(testMap, 'key'), {'a': 1, 'b': 2});
      expect(asMapOrNull<String, int>(testMap, 'missingKey'), isNull);
    });

    test('asMap works correctly', () {
      expect(asMap<String, int>(testMap, 'key'), {'a': 1, 'b': 2});
      expect(
        asMap<String, int>(testMap, 'missingKey', defaultValue: {'default': 0}),
        {'default': 0},
      );
    });
  });

  group('NonNullsMapExtension', () {
    test('mapNonNulls should apply convert only to non-null entries', () {
      final input = {
        1: 'a',
        2: null,
        null: 'c',
        4: 'd',
        5: null,
      };

      final result = input.mapNonNulls<int, String>((key, value) {
        expect(key, isNotNull);
        expect(value, isNotNull);
        return MapEntry(key, value);
      });

      expect(result, isA<Map<int, String>>());
      expect(result, {
        1: 'a',
        4: 'd',
      });
    });

    test('nonNulls should return a map with only non-null key-value pairs', () {
      final input = {
        1: 'a',
        2: null,
        null: 'c',
        4: 'd',
        5: null,
      };

      final result = input.nonNulls;

      expect(result, {
        1: 'a',
        4: 'd',
      });
    });

    test('nonNulls should return an empty map when all entries are null', () {
      final input = {
        null: null,
      };

      final result = input.nonNulls;
      expect(result, isEmpty);
    });

    test(
        'mapNonNulls should return an empty map when there are no non-null entries',
        () {
      final input = {
        null: 'a',
        2: null,
      };

      final result = input.mapNonNulls((key, value) => MapEntry(key, value));
      expect(result, isEmpty);
    });

    test('mapNonNulls with custom transformation', () {
      final input = {
        'a': 1,
        null: 2,
        'c': null,
        'd': 4,
      };

      final result = input.mapNonNulls<int, String>((key, value) {
        return MapEntry(value, key);
      });

      expect(result, {
        1: 'a',
        4: 'd',
      });
    });
  });
}
