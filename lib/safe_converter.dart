/// A utility library for safe dynamic type conversion in Flutter/Dart.
///
/// This library provides a set of functions and extensions to safely convert
/// dynamic data types to expected types (e.g., int, double, String, bool, List, Map, DateTime).
/// It ensures values are correctly parsed, provides default values when necessary,
/// and handles edge cases like `null`, `NaN`, or `Infinity`.
///
/// Example:
/// ```dart
/// final map = {"id": "123", "price": "99.9", "active": "yes"};
/// int id = map.getInt("id"); // 123
/// double price = map.getDouble("price"); // 99.9
/// bool active = map.getBool("active"); // true
/// ```
library safe_converter;

import 'dart:convert';
import 'dart:developer' as developer;

part 'src/codec.dart';
part 'src/object.dart';
part 'src/int.dart';
part 'src/num.dart';
part 'src/double.dart';
part 'src/bool.dart';
part 'src/string.dart';
part 'src/map.dart';
part 'src/list.dart';
part 'src/date_time.dart';
part 'src/converters.dart';

/// Global configuration for SafeConverter.
class SafeConvertConfig {
  /// Whether to enable log output.
  static bool enableLog = false;

  /// Custom log handler. If null, uses `dart:developer` log.
  static void Function(String message)? logHandler;

  static void _log(String message) {
    if (!enableLog) return;
    if (logHandler != null) {
      logHandler!(message);
    } else {
      developer.log('SafeConverter: $message');
    }
  }
}
