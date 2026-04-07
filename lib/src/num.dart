part of '../safe_converter.dart';

/// Converts dynamic value to num?.
num? numNullableConvert(dynamic source) {
  if (source == null) return null;
  if (source is num) return source;
  if (source is bool) return source ? 1 : 0;
  if (source is String) return num.tryParse(source);
  return null;
}

/// Alias for [numNullableConvert].
num? tryNumConvert(dynamic source) => numNullableConvert(source);

/// Converts dynamic value to num with a default value.
num numConvert(dynamic source, {num defaultValue = 0}) =>
    numNullableConvert(source) ?? defaultValue;

/// Extension on Object to provide safe conversion to num.
extension SafeConvertOnObject2Num on Object {
  /// Converts object to num?.
  num? safe2NumNullable() => numNullableConvert(this);

  /// Alias for [safe2NumNullable].
  num? try2Num() => safe2NumNullable();

  /// Converts object to num, returns [defaultValue] on failure.
  num safe2Num({num defaultValue = 0}) => safe2NumNullable() ?? defaultValue;
}

/// Extension on Map? to provide safe conversion of values to num.
extension SafeConvertOnMap2Num on Map? {
  /// Gets value by key and converts to num?.
  /// Supports deep path access using dot notation (e.g., "data.item.count").
  num? getNumOrNull(dynamic key, {num? defaultValue}) =>
      numNullableConvert(_get(key)) ?? defaultValue;

  /// Alias for [getNumOrNull].
  num? tryGetNum(dynamic key, {num? defaultValue}) =>
      getNumOrNull(key, defaultValue: defaultValue);

  /// Gets value by key and converts to num, returns [defaultValue] on failure.
  /// Supports deep path access using dot notation (e.g., "data.item.count").
  num getNum(dynamic key, {num defaultValue = 0}) =>
      getNumOrNull(key) ?? defaultValue;
}

/// Safely gets and converts Map value to num.
num asNum(Map? json, String key, {num defaultValue = 0}) =>
    json.getNum(key, defaultValue: defaultValue);

/// Safely gets and converts Map value to num?.
num? asNumOrNull(Map? json, String key, {num? defaultValue}) =>
    json.getNumOrNull(key, defaultValue: defaultValue);

/// Alias for [asNumOrNull].
num? tryNum(Map? json, String key, {num? defaultValue}) =>
    asNumOrNull(json, key, defaultValue: defaultValue);
