part of '../safe_converter.dart';

/// Converts dynamic value to Map<K, V>?.
/// Filters out entries that cannot be converted to type K or V.
/// Supports JSON string input.
Map<K, V>? mapNullableConvert<K, V>(dynamic source) {
  if (source == null) return null;
  if (source is Map) {
    final result = <K, V>{};
    source.forEach((key, value) {
      final k = _tNullableConvert<K>(key);
      final v = _tNullableConvert<V>(value);
      if (k is K && v is V) {
        result[k] = v;
      }
    });
    return result;
  }
  if (source is String && source.isNotEmpty) {
    try {
      return mapNullableConvert<K, V>(json.decode(source));
    } catch (_) {
      return null;
    }
  }
  return null;
}

/// Converts dynamic value to Map<K, V> with a default value.
Map<K, V> mapConvert<K, V>(dynamic source, {Map<K, V>? defaultValue}) =>
    mapNullableConvert(source) ?? defaultValue ?? <K, V>{};

/// Extension on Object to provide safe conversion to Map.
extension SafeConvertOnObject2Map on Object {
  /// Converts object to Map<K, V>?.
  Map<K, V>? safe2MapNullable<K, V>() => mapNullableConvert<K, V>(this);

  /// Converts object to Map<K, V>, returns [defaultValue] or empty map on failure.
  Map<K, V> safe2Map<K, V>({Map<K, V>? defaultValue}) =>
      safe2MapNullable() ?? defaultValue ?? <K, V>{};
}

/// Extension on Map? to provide safe conversion of values to Map.
extension SafeConvertOnMap2Map on Map? {
  /// Gets value by key and converts to Map<NK, NV>?.
  /// Supports deep path access using dot notation (e.g., "data.user.profile").
  Map<NK, NV>? getMapOrNull<NK, NV>(dynamic key, {Map<NK, NV>? defaultValue}) =>
      mapNullableConvert<NK, NV>(_get(key)) ?? defaultValue;

  /// Gets value by key and converts to Map<NK, NV>, returns [defaultValue] or empty map on failure.
  /// Supports deep path access using dot notation (e.g., "data.user.profile").
  Map<NK, NV> getMap<NK, NV>(dynamic key, {Map<NK, NV>? defaultValue}) =>
      getMapOrNull<NK, NV>(key) ?? defaultValue ?? <NK, NV>{};
}

/// Safely gets and converts Map value to Map?.
Map<K, V>? asMapOrNull<K, V>(Map? json, String key,
        {Map<K, V>? defaultValue}) =>
    json.getMapOrNull<K, V>(key, defaultValue: defaultValue);

/// Safely gets and converts Map value to Map.
Map<K, V> asMap<K, V>(Map? json, String key, {Map<K, V>? defaultValue}) =>
    json.getMap<K, V>(key, defaultValue: defaultValue);

/// Extension on Map providing utility to remove null keys or values.
extension NonNulls4MapExtensions<K, V> on Map<K?, V?> {
  /// Maps entries while filtering out null keys/values.
  Map<K2, V2> mapNonNulls<K2, V2>(
      MapEntry<K2, V2> Function(K key, V value) convert) {
    return Map.fromEntries(entries
        .where((e) => e.key != null && e.value != null)
        .map((e) => convert(e.key as K, e.value as V)));
  }

  /// Returns a new Map with all null keys and values removed.
  Map<K, V> get nonNulls =>
      mapNonNulls<K, V>((key, value) => MapEntry<K, V>(key, value));
}
