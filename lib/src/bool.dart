part of '../safe_converter.dart';

/// Converts dynamic value to bool?.
/// Supports true/false, 1/0, yes/no, on/off.
bool? boolNullableConvert(dynamic source) {
  if (source == null) return null;
  if (source is bool) return source;
  if (source is int) return source != 0;
  if (source is double) return !source.isNaN && source != 0.0;
  if (source is String) {
    final lower = source.toLowerCase().trim();
    if (lower == '1' || lower == 'true' || lower == 'yes' || lower == 'on')
      return true;
    if (lower == '0' || lower == 'false' || lower == 'no' || lower == 'off')
      return false;
  }
  return null;
}

/// Converts dynamic value to bool with a default value.
bool boolConvert(dynamic source, {bool defaultValue = false}) =>
    boolNullableConvert(source) ?? defaultValue;

/// Extension on Object to provide safe conversion to bool.
extension SafeConvertOnObject2Bool on Object {
  /// Converts object to bool?.
  bool? safe2BoolNullable() => boolNullableConvert(this);

  /// Converts object to bool, returns [defaultValue] on failure.
  bool safe2Bool({bool defaultValue = false}) =>
      safe2BoolNullable() ?? defaultValue;
}

/// Extension on Map? to provide safe conversion of values to bool.
extension SafeConvertOnMap2Bool on Map? {
  /// Gets value by key and converts to bool?.
  bool? getBoolOrNull(dynamic key, {bool? defaultValue}) =>
      boolNullableConvert(this?[key]) ?? defaultValue;

  /// Gets value by key and converts to bool, returns [defaultValue] on failure.
  bool getBool(dynamic key, {bool defaultValue = false}) =>
      getBoolOrNull(key) ?? defaultValue;
}

/// Safely gets and converts Map value to bool.
bool asBool(Map? json, String key, {bool defaultValue = false}) =>
    json.getBool(key, defaultValue: defaultValue);

/// Safely gets and converts Map value to bool?.
bool? asBoolOrNull(Map? json, String key, {bool? defaultValue}) =>
    json.getBoolOrNull(key, defaultValue: defaultValue);
