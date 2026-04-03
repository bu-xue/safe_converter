part of '../safe_converter.dart';

/// A codec for custom object conversion.
/// [encode] converts an object of type [S] to a Map.
/// [decode] converts a Map back to an object of type [S].
class ObjCodec<S> {
  final Map Function(S) encode;
  final S Function(Map) decode;

  const ObjCodec({required this.encode, required this.decode});
}
