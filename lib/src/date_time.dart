part of '../safe_converter.dart';

/// Converts dynamic value to DateTime?.
/// - `null` returns `null`.
/// - `DateTime` returns itself.
/// - `int` is treated as milliseconds timestamp.
/// - `String` tries `DateTime.tryParse` (ISO8601).
DateTime? dateTimeNullableConvert(dynamic source) {
  if (source == null) return null;
  if (source is DateTime) return source;
  if (source is int) return DateTime.fromMillisecondsSinceEpoch(source);
  if (source is String) return DateTime.tryParse(source);
  return null;
}

/// Alias for [dateTimeNullableConvert].
DateTime? tryDateTimeConvert(dynamic source) => dateTimeNullableConvert(source);

/// Converts dynamic value to DateTime with a default value.
DateTime dateTimeConvert(dynamic source, {DateTime? defaultValue}) =>
    dateTimeNullableConvert(source) ??
    defaultValue ??
    DateTime.fromMillisecondsSinceEpoch(0);

/// Extension on Object to provide safe conversion to DateTime.
extension SafeConvertOnObject2DateTime on Object {
  /// Converts object to DateTime?.
  DateTime? safe2DateTimeNullable() => dateTimeNullableConvert(this);

  /// Alias for [safe2DateTimeNullable].
  DateTime? try2DateTime() => safe2DateTimeNullable();

  /// Converts object to DateTime, returns [defaultValue] or epoch on failure.
  DateTime safe2DateTime({DateTime? defaultValue}) =>
      safe2DateTimeNullable() ??
      defaultValue ??
      DateTime.fromMillisecondsSinceEpoch(0);
}

/// Extension on Map? to provide safe conversion of values to DateTime.
extension SafeConvertOnMap2DateTime on Map? {
  /// Gets value by key and converts to DateTime?.
  /// Supports deep path access using dot notation (e.g., "data.user.createdAt").
  DateTime? getDateTimeOrNull(dynamic key, {DateTime? defaultValue}) =>
      dateTimeNullableConvert(_get(key)) ?? defaultValue;

  /// Alias for [getDateTimeOrNull].
  DateTime? tryGetDateTime(dynamic key, {DateTime? defaultValue}) =>
      getDateTimeOrNull(key, defaultValue: defaultValue);

  /// Gets value by key and converts to DateTime, returns [defaultValue] or epoch on failure.
  /// Supports deep path access using dot notation (e.g., "data.user.createdAt").
  DateTime getDateTime(dynamic key, {DateTime? defaultValue}) =>
      getDateTimeOrNull(key) ??
      defaultValue ??
      DateTime.fromMillisecondsSinceEpoch(0);
}

/// Safely gets and converts Map value to DateTime?.
DateTime? asDateTimeOrNull(Map? json, String key, {DateTime? defaultValue}) =>
    json.getDateTimeOrNull(key, defaultValue: defaultValue);

/// Alias for [asDateTimeOrNull].
DateTime? tryDateTime(Map? json, String key, {DateTime? defaultValue}) =>
    asDateTimeOrNull(json, key, defaultValue: defaultValue);

/// Safely gets and converts Map value to DateTime.
DateTime asDateTime(Map? json, String key, {DateTime? defaultValue}) =>
    json.getDateTime(key, defaultValue: defaultValue);
