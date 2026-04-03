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

/// Alias for [tNullableConvert].
T? asTOrNull<T>(dynamic source) => _tNullableConvert<T>(source);

/// Alias for [tConvert].
T asT<T>(dynamic source, {required T defaultValue}) =>
    _tNullableConvert<T>(source) ?? defaultValue;

/// Top-level function to convert dynamic value to nullable type T.
T? tNullableConvert<T>(dynamic source) => _tNullableConvert<T>(source);

/// Top-level function to convert dynamic value to non-nullable type T with a default value.
T tConvert<T>(dynamic source, {required T defaultValue}) =>
    _tNullableConvert<T>(source) ?? defaultValue;

/// Registers a custom codec for type T.
void registerCodec<T>(ObjCodec<T> objCodec) {
  _TypeConverters.registerCodec<T>(objCodec);
}

/// Extension for general object conversion.
extension SafeConvertOnObject on Object {
  /// Converts object to type T?.
  T? safe2TOrNull<T>() => asTOrNull<T>(this);

  /// Converts object to type T, returns [defaultValue] on failure.
  T safe2T<T>({required T defaultValue}) =>
      asT<T>(this, defaultValue: defaultValue);
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
