part of '../safe_converter.dart';

/// Converts dynamic value to int?.
int? intNullableConvert(dynamic source) {
  if (source == null) return null;
  if (source is int) return source;
  if (source is double) {
    return source.isNaN || source.isInfinite ? null : source.toInt();
  }
  if (source is bool) return source ? 1 : 0;
  if (source is String) {
    return int.tryParse(source) ?? double.tryParse(source)?.toInt();
  }
  return null;
}

/// Alias for [intNullableConvert].
int? tryIntConvert(dynamic source) => intNullableConvert(source);

/// Converts dynamic value to int with a default value.
int intConvert(dynamic source, {int defaultValue = 0}) =>
    intNullableConvert(source) ?? defaultValue;

/// Extension on Object to provide safe conversion to int.
extension SafeConvertOnObject2Int on Object {
  /// Converts object to int?.
  int? safe2IntNullable() => intNullableConvert(this);

  /// Alias for [safe2IntNullable].
  int? try2Int() => safe2IntNullable();

  /// Converts object to int, returns [defaultValue] on failure.
  int safe2Int({int defaultValue = 0}) => safe2IntNullable() ?? defaultValue;
}

/// Extension on Map? to provide safe conversion of values to int.
extension SafeConvertOnMap2Int on Map? {
  /// Gets value by key and converts to int?.
  /// Supports deep path access using dot notation (e.g., "data.user.age").
  int? getIntOrNull(dynamic key, {int? defaultValue}) =>
      intNullableConvert(_get(key)) ?? defaultValue;

  /// Alias for [getIntOrNull].
  int? tryGetInt(dynamic key, {int? defaultValue}) =>
      getIntOrNull(key, defaultValue: defaultValue);

  /// Gets value by key and converts to int, returns [defaultValue] on failure.
  /// Supports deep path access using dot notation (e.g., "data.user.age").
  int getInt(dynamic key, {int defaultValue = 0}) =>
      getIntOrNull(key) ?? defaultValue;
}

/// Safely gets and converts Map value to int.
int asInt(Map? json, String key, {int defaultValue = 0}) =>
    json.getInt(key, defaultValue: defaultValue);

/// Safely gets and converts Map value to int?.
int? asIntOrNull(Map? json, String key, {int? defaultValue}) =>
    json.getIntOrNull(key, defaultValue: defaultValue);

/// Alias for [asIntOrNull].
int? tryInt(Map? json, String key, {int? defaultValue}) =>
    asIntOrNull(json, key, defaultValue: defaultValue);
