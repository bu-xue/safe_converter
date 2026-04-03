import 'package:test/test.dart';
import 'package:safe_converter/safe_converter.dart';

class User {
  final String name;
  User(this.name);
}

void main() {
  group('_TypeConverters (tConvert/tNullableConvert) Tests', () {
    test('tNullableConvert handles basic types correctly', () {
      expect(tNullableConvert<int>("123"), 123);
      expect(tNullableConvert<double>("123.45"), 123.45);
      expect(tNullableConvert<bool>("yes"), true);
      expect(tNullableConvert<String>(123), "123");
    });

    test('tConvert returns defaultValue on failure', () {
      expect(tConvert<int>("invalid", defaultValue: 99), 99);
    });

    test('registerCodec and tConvert for custom objects', () {
      // Register a mock codec
      registerCodec<User>(ObjCodec<User>(
        encode: (user) => {'name': user.name},
        decode: (map) => User(map['name'] as String),
      ));

      final userData = {'name': 'Alice'};
      final result = tNullableConvert<User>(userData);

      expect(result, isA<User>());
      expect(result?.name, 'Alice');
    });

    test('tNullableConvert returns null for unregistered types', () {
      expect(tNullableConvert<User>("not-a-map"), isNull);
    });
  });

  group('SafeConvertConfig (Logging) Tests', () {
    test('Config records log when enabled', () {
      String? lastLog;
      SafeConvertConfig.enableLog = true;
      SafeConvertConfig.logHandler = (msg) => lastLog = msg;

      // Trigger a conversion failure
      tNullableConvert<int>("this_is_not_a_number");

      expect(lastLog, contains("Failed to convert source to <int>"));

      // Reset config
      SafeConvertConfig.enableLog = false;
      SafeConvertConfig.logHandler = null;
    });
  });
}
