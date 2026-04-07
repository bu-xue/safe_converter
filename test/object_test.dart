import 'package:safe_converter/safe_converter.dart';
import 'package:test/test.dart';

main() {
  group('tNullableConvert Tests', () {
    // Test for null input
    test('tNullableConvert should return null for null input', () {
      expect(tNullableConvert<int>(null), isNull);
      expect(tNullableConvert<String>(null), isNull);
    });

    // Test for already matching types
    test('tNullableConvert should return the value for already matching types',
        () {
      expect(tNullableConvert<int>(42), equals(42));
      expect(tNullableConvert<String>('Hello'), equals('Hello'));
    });

    // Test for int conversion
    test('tNullableConvert should convert to int when T is int', () {
      expect(tNullableConvert<int>(42), equals(42));
      expect(tNullableConvert<int>('42'), equals(42));
      expect(tNullableConvert<int>(3.14), equals(3)); // Should truncate decimal
      expect(tNullableConvert<int>(true),
          equals(1)); // Should convert boolean to 1
      expect(tNullableConvert<int>('not a number'), isNull); // Invalid string
      expect(tNullableConvert<int>(null), isNull); // Null
    });

    // Test for double conversion
    test('tNullableConvert should convert to double when T is double', () {
      expect(tNullableConvert<double>(42), equals(42.0));
      expect(tNullableConvert<double>('42.0'), equals(42.0));
      expect(tNullableConvert<double>(3),
          equals(3.0)); // Should convert int to double
      expect(tNullableConvert<double>(true),
          equals(1.0)); // Should convert boolean to 1.0
      expect(
          tNullableConvert<double>('not a number'), isNull); // Invalid string
      expect(tNullableConvert<double>(null), isNull); // Null
    });

    // Test for String conversion
    test('tNullableConvert should convert to String when T is String', () {
      expect(tNullableConvert<String>(42), equals('42'));
      expect(tNullableConvert<String>(3.14), equals('3.14'));
      expect(tNullableConvert<String>(true), equals('true'));
      expect(tNullableConvert<String>(null), isNull); // Null
    });

    // Test for bool conversion
    test('tNullableConvert should convert to bool when T is bool', () {
      expect(tNullableConvert<bool>(0), equals(false));
      expect(tNullableConvert<bool>(1), equals(true));
      expect(tNullableConvert<bool>(3.14), equals(true));
      expect(tNullableConvert<bool>('true'), equals(true));
      expect(tNullableConvert<bool>('false'), equals(false));
      expect(tNullableConvert<bool>('1'), equals(true));
      expect(tNullableConvert<bool>('0'), equals(false));
      expect(tNullableConvert<bool>(null), isNull); // Null
    });

    // Test for Map conversion
    test('tNullableConvert should convert to Map when T is Map', () {
      final source = {'key': 'value'};
      expect(tNullableConvert<Map>(source), equals({'key': 'value'}));
      expect(
          tNullableConvert<Map>('{"key": "value"}'), equals({'key': 'value'}));
      expect(tNullableConvert<Map>('invalid string'), isNull); // Invalid string
    });

    // Test for List conversion
    test('tNullableConvert should convert to List when T is List', () {
      final source = [1, 2, 3];
      expect(tNullableConvert<List>(source), equals([1, 2, 3]));
      expect(tNullableConvert<List>('[1,2,3]'), equals([1, 2, 3]));
      expect(
          tNullableConvert<List>('invalid string'), isNull); // Invalid string
    });

    // Test for invalid types
    test('tNullableConvert should return null for unsupported types', () {
      expect(tNullableConvert<int>({}), isNull); // Map
      expect(tNullableConvert<int>([]), isNull); // List
      expect(tNullableConvert<int>(Object()), isNull); // Object
    });
  });

  group('New Aliases Tests', () {
    test('asT, asTOrNull and tryT should work', () {
      expect(asT<int>("100", defaultValue: 0), 100);
      expect(asTOrNull<double>("100.5"), 100.5);
      expect(tryT<double>("100.5"), 100.5);
      expect(asT<bool>("yes", defaultValue: false), true);
    });

    test('Object Extension: safe2T, safe2TOrNull and try2T should work', () {
      const val = "123";
      expect(val.safe2TOrNull<int>(), 123);
      expect(val.try2T<int>(), 123);
      expect("abc".safe2T<int>(defaultValue: 0), 0);
      expect("abc".try2T<int>(), isNull);
    });

    test('Map Extension: getTOrNull and tryGetT should work', () {
      final map = {'age': '25'};
      expect(map.getTOrNull<int>('age'), 25);
      expect(map.tryGetT<int>('age'), 25);
      expect(map.tryGetT<int>('missing'), isNull);
    });
  });

  group('nonNull Extension Tests', () {
    test('Non-null value returns transformed result', () {
      final value = 42;
      final result = value.nonNull((it) => it * 2);
      expect(result, 84);
    });

    test('Null value returns null', () {
      int? value;
      final result = value.nonNull((it) => it * 2);
      expect(result, isNull);
    });

    test('Throws exception when transform throws', () {
      final value = 'test';
      expect(() => value.nonNull((it) => throw Exception('Error')),
          throwsA(isA<Exception>()));
    });

    test('Works with complex objects', () {
      final user = User('Alice');
      final result = user.nonNull((u) => u.name.toUpperCase());
      expect(result, 'ALICE');
    });

    test('Handles nullables correctly', () {
      String? nullable;
      final result = nullable.nonNull((s) => s.length);
      expect(result, isNull);
    });
  });
  group('registerCodec Tests', () {
    test('register codecForUser', () {
      final user = User('Masker');
      registerCodec(codecForUser);
      final result1 = tNullableConvert<User>(_toJson(user));
      final result2 = tNullableConvert<Map>(_toJson(user));
      expect(result1, user);
      expect(result2, _toJson(user));
    });
  });
}

class User {
  final String name;

  User(this.name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;
}

Map _toJson(User user) => {'name': user.name};

User _fromJson(Map json) => User(json.getString('name'));

const codecForUser = ObjCodec<User>(encode: _toJson, decode: _fromJson);
