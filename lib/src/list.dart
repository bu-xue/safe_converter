part of '../safe_converter.dart';

/// Converts dynamic value to List<V>?.
/// Filters out elements that cannot be converted to type V.
/// Supports JSON string input.
List<V>? listNullableConvert<V>(dynamic source) {
  if (source == null) return null;
  if (source is List) {
    return source.map((e) => _tNullableConvert<V>(e)).whereType<V>().toList();
  }
  if (source is String && source.isNotEmpty) {
    try {
      return listNullableConvert<V>(json.decode(source));
    } catch (_) {
      return null;
    }
  }
  return null;
}

/// Converts dynamic value to List<V> with a default value.
List<V> listConvert<V>(dynamic source, {List<V>? defaultValue}) =>
    listNullableConvert(source) ?? defaultValue ?? <V>[];

/// Extension on Object to provide safe conversion to List.
extension SafeConvertOnObject2List on Object {
  /// Converts object to List<V>?.
  List<V>? safe2ListNullable<V>() => listNullableConvert<V>(this);

  /// Converts object to List<V>, returns [defaultValue] or empty list on failure.
  List<V> safe2List<V>({List<V>? defaultValue}) =>
      safe2ListNullable() ?? defaultValue ?? <V>[];
}

/// Extension on Map? to provide safe conversion of values to List.
extension SafeConvertOnMap2List on Map? {
  /// Gets value by key and converts to List<T>?.
  List<T>? getListOrNull<T>(dynamic key, {List<T>? defaultValue}) =>
      listNullableConvert<T>(this?[key]) ?? defaultValue;

  /// Gets value by key and converts to List<T>, returns [defaultValue] or empty list on failure.
  List<T> getList<T>(dynamic key, {List<T>? defaultValue}) =>
      getListOrNull<T>(key) ?? defaultValue ?? <T>[];
}

/// Safely gets and converts Map value to List?.
List<T>? asListOrNull<T>(Map? json, String key, {List<T>? defaultValue}) =>
    json.getListOrNull<T>(key, defaultValue: defaultValue);

/// Safely gets and converts Map value to List.
List<T> asList<T>(Map? json, String key, {List<T>? defaultValue}) =>
    json.getList<T>(key, defaultValue: defaultValue);
