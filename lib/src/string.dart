part of '../safe_converter.dart';

/// Converts dynamic value to String?.
/// - `null` returns `null`.
/// - `String` returns itself.
/// - `int` or `bool` returns its string representation.
/// - `double`:
///   - Returns `null` if `NaN`.
///   - Otherwise returns its string representation.
/// - `Map` or `List`: Tries to `json.encode`. Returns `null` on failure.
/// - Other types: Returns `toString()` if [useToString] is `true`, else `null`.
String? stringNullableConvert(dynamic source, {bool useToString = false}) {
  if (source == null) return null;
  if (source is String) return source;
  if (source is int || source is bool) return source.toString();
  if (source is double) return source.isNaN ? null : source.toString();
  if (source is Map || source is List) {
    try {
      return json.encode(source);
    } catch (_) {
      return null;
    }
  }
  return useToString ? source.toString() : null;
}

/// Converts dynamic value to String with a default value.
String stringConvert(dynamic source,
        {String defaultValue = '', bool useToString = true}) =>
    stringNullableConvert(source, useToString: useToString) ?? defaultValue;

/// Extension on Object to provide safe conversion to String.
extension SafeConvertOnObject2String on Object {
  /// Converts object to String?.
  String? safe2StringNullable({bool useToString = false}) =>
      stringNullableConvert(this, useToString: useToString);

  /// Converts object to String, returns [defaultValue] on failure.
  String safe2String({String defaultValue = '', bool useToString = true}) =>
      safe2StringNullable(useToString: useToString) ?? defaultValue;
}

/// Extension on Map? to provide safe conversion of values to String.
extension SafeConvertOnMap2String on Map? {
  /// Gets value by key and converts to String?.
  String? getStringOrNull(dynamic key, {String? defaultValue}) =>
      stringNullableConvert(this?[key]) ?? defaultValue;

  /// Gets value by key and converts to String, returns [defaultValue] on failure.
  String getString(dynamic key, {String defaultValue = ""}) =>
      getStringOrNull(key) ?? defaultValue;
}

/// Safely gets and converts Map value to String?.
String? asStringOrNull(Map? json, String key, {String? defaultValue}) =>
    json.getStringOrNull(key, defaultValue: defaultValue);

/// Safely gets and converts Map value to String.
String asString(Map? json, String key, {String defaultValue = ""}) =>
    json.getString(key, defaultValue: defaultValue);
