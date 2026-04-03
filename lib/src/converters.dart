part of '../safe_converter.dart';

typedef _NullableConvert<T> = T? Function(dynamic);

/// Internal class to manage type converters and codecs.
class _TypeConverters {
  /// Default type converters for basic Dart types.
  static final Map<Type, _NullableConvert> _defaultConverters = {
    int: intNullableConvert,
    num: numNullableConvert,
    double: doubleNullableConvert,
    String: stringNullableConvert,
    bool: boolNullableConvert,
    Map: mapNullableConvert,
    List: listNullableConvert,
    DateTime: dateTimeNullableConvert,
  };

  /// Custom object codecs.
  static final Map<Type, ObjCodec> _objCodecs = {};

  /// Registers a custom codec for type T.
  static void registerCodec<T>(ObjCodec<T> objCodec) {
    _objCodecs[T] = objCodec;
  }

  /// Performs type conversion based on target type T.
  static T? convert<T>(dynamic source) {
    if (source == null) return null;

    final codec = _objCodecs[T];
    if (codec != null && codec is ObjCodec<T>) {
      final map = mapNullableConvert(source);
      if (map != null) {
        return codec.decode(map);
      } else {
        SafeConvertConfig._log(
            'Failed to convert to Map for codec <$T>: $source');
        return null;
      }
    }

    final convert = _defaultConverters[T];
    if (convert != null && convert is _NullableConvert<T>) {
      final result = convert(source);
      if (result == null && source != null) {
        SafeConvertConfig._log('Failed to convert source to <$T>: $source');
      }
      return result;
    }

    SafeConvertConfig._log('No converter registered for type <$T>');
    return null;
  }
}
