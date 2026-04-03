part of '../safe_converter.dart';

/// Converts dynamic value to double?.
double? doubleNullableConvert(dynamic source) {
  if (source == null) return null;
  if (source is double) return source;
  if (source is int) return source.toDouble();
  if (source is bool) return source ? 1.0 : 0.0;
  if (source is String) return double.tryParse(source);
  return null;
}

/// Converts dynamic value to double with a default value.
double doubleConvert(dynamic source, {double defaultValue = 0.0}) =>
    doubleNullableConvert(source) ?? defaultValue;

/// Extension on Object to provide safe conversion to double.
extension SafeConvertOnObject2Double on Object {
  /// Converts object to double?.
  double? safe2DoubleNullable() => doubleNullableConvert(this);

  /// Converts object to double, returns [defaultValue] on failure.
  double safe2Double({double defaultValue = 0.0}) =>
      safe2DoubleNullable() ?? defaultValue;
}

/// Extension on Map? to provide safe conversion of values to double.
extension SafeConvertOnMap2Double on Map? {
  /// Gets value by key and converts to double?.
  /// Supports deep path access using dot notation (e.g., "data.item.price").
  double? getDoubleOrNull(dynamic key, {double? defaultValue}) =>
      doubleNullableConvert(_get(key)) ?? defaultValue;

  /// Gets value by key and converts to double, returns [defaultValue] on failure.
  /// Supports deep path access using dot notation (e.g., "data.item.price").
  double getDouble(dynamic key, {double defaultValue = 0.0}) =>
      getDoubleOrNull(key) ?? defaultValue;
}

/// Safely gets and converts Map value to double.
double asDouble(Map? json, String key, {double defaultValue = 0.0}) =>
    json.getDouble(key, defaultValue: defaultValue);

/// Safely gets and converts Map value to double?.
double? asDoubleOrNull(Map? json, String key, {double? defaultValue}) =>
    json.getDoubleOrNull(key, defaultValue: defaultValue);
