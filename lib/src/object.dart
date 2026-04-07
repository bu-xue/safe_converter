part of '../safe_converter.dart';

/// Converts dynamic value to a nullable of type T.
/// - If `source` is `null`, returns `null`.
/// - If `source` is already of type T, returns `source`.
/// - Otherwise, calls the corresponding converter based on type T.
T? _tNullableConvert<T>(dynamic source) {
  if (source == null) return null;
  if (source is T) return source;

  return _TypeConverters.convert<T>(source);
}

/// Alias for [_tNullableConvert].
T? asTOrNull<T>(dynamic source) => _tNullableConvert<T>(source);

/// Alias for [_tNullableConvert].
T? tryT<T>(dynamic source) => asTOrNull<T>(source);

/// Top-level function to convert dynamic value to nullable type T.
T? tNullableConvert<T>(dynamic source) => _tNullableConvert<T>(source);

/// Alias for [tNullableConvert].
T? tryTConvert<T>(dynamic source) => tNullableConvert<T>(source);

/// Top-level function to convert dynamic value to non-nullable type T with a default value.
T tConvert<T>(dynamic source, {required T defaultValue}) =>
    _tNullableConvert<T>(source) ?? defaultValue;

/// Alias for [tConvert].
T asT<T>(dynamic source, {required T defaultValue}) =>
    tConvert<T>(source, defaultValue: defaultValue);

/// Registers a custom codec for type T.
void registerCodec<T>(ObjCodec<T> objCodec) {
  _TypeConverters.registerCodec<T>(objCodec);
}

/// Extension for general object conversion.
extension SafeConvertOnObject on Object {
  /// Converts object to type T?.
  T? safe2TOrNull<T>() => asTOrNull<T>(this);

  /// Alias for [safe2TOrNull].
  T? try2T<T>() => safe2TOrNull<T>();

  /// Converts object to type T, returns [defaultValue] on failure.
  T safe2T<T>({required T defaultValue}) =>
      asT<T>(this, defaultValue: defaultValue);
}

/// Extension on Map? to provide generic safe conversion of values.
extension SafeConvertOnMap2T on Map? {
  /// Internal helper to get value from a source (Map or List) by path.
  dynamic _get(dynamic key) {
    final source = this;
    if (source == null) return null;
    if (key.isEmpty) return null;
    if (key is! String || !key.contains('.')) return source[key];
    final keys = key.split('.');
    dynamic current = source;
    for (final k in keys) {
      if (current == null) return null;
      final map = mapNullableConvert<String, dynamic>(current);
      if (map != null) {
        current = map[k];
      } else {
        final list = listNullableConvert(current);
        final index = int.tryParse(k);
        if (list != null &&
            index != null &&
            index >= 0 &&
            index < list.length) {
          current = list[index];
        } else {
          return null;
        }
      }
    }
    return current;
  }

  /// Gets value by key and converts to type T?.
  /// Supports deep path access using dot notation (e.g., "data.user.profile").
  T? getTOrNull<T>(dynamic key) => asTOrNull<T>(_get(key));

  /// Alias for [getTOrNull].
  T? tryGetT<T>(dynamic key) => getTOrNull<T>(key);

  /// Gets value by key and converts to type T, returns [defaultValue] on failure.
  /// Supports deep path access using dot notation (e.g., "data.user.profile").
  T getT<T>(dynamic key, {required T defaultValue}) =>
      getTOrNull<T>(key) ?? defaultValue;
}

/// Extension for nullable objects providing safe non-null operations.
extension SafeConvertOnObjectNullable<T> on T? {
  /// Executes [block] if the object is not null, otherwise returns null.
  R? nonNull<R>(R? Function(T it) block) {
    if (this == null) {
      return null;
    }
    return block.call(this as T);
  }
}
