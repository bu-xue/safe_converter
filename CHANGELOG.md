# CHANGELOG

## 1.2.0 - Fluent Try Aliases 🍭

This update introduces concise `tryxx` aliases for all `OrNull` methods to improve developer experience and code readability.

### New Features
- **Try Aliases**: Added shorter `tryxx` aliases for all conversion methods.
    - **Map Extension**: `tryGetInt`, `tryGetBool`, `tryGetString`, `tryGetList`, `tryGetMap`, `tryGetT`, etc.
    - **Object Extension**: `try2Int`, `try2Bool`, `try2String`, `try2T`, etc.
    - **Top-level Functions**: `tryInt`, `tryBool`, `tryString`, `tryList`, `tryMap`, `tryT`, etc.
- **Improved Fluent API**: Enhanced `Object` extensions with `try` prefixes for more natural chain calls.

---

## 1.1.0 - Deep Path Access 🔥

This update introduces powerful deep path access and automatic JSON decoding during traversal.

### New Features
- **Deep Path Access**: Support for dot notation (e.g., `data.user.name`) to access nested fields in `Map`.
- **List Index Support**: Access list elements by index within paths (e.g., `items.0.id`).
- **Automatic JSON Decoding**: The library now automatically detects and decodes JSON strings in the middle of a path, allowing seamless traversal through serialized data.
- **Generic Path Access**: Added `getTOrNull<T>(key)` and `getT<T>(key)` to `Map` extensions for flexible, type-safe path access.

### Improvements
- Refactored core traversal logic into a private `_get` helper for better consistency and performance.
- Enhanced internal robust type checking during path resolution.

---

## 1.0.0 - Initial Release 🚀

The first stable release of `safe_convert`, providing a robust and developer-friendly way to handle dynamic type conversion in Dart and Flutter.

### Core Features
- **Comprehensive Type Support**: Safe conversion for `int`, `double`, `num`, `bool`, `String`, `DateTime`, `List`, and `Map`.
- **Smart Parsing**: 
    - Numeric strings (e.g., `"123.4"`) are automatically parsed to `int` or `double`.
    - Boolean strings support multiple formats like `"yes/no"`, `"on/off"`, `"true/false"`, and `"1/0"`.
    - `DateTime` support for both ISO8601 strings and millisecond timestamps.
- **Fluent Extensions**:
    - `SafeConvertOnObject2XXX`: Perform conversions directly on any `Object`.
    - `SafeConvertOnMap2XXX`: Safely extract and convert values from `Map` by key.
- **Production Monitoring**: Global logging via `SafeConvertConfig` to track and report conversion failures in real-world data.
- **Custom Object Codecs**: Support for registering custom `ObjCodec` to handle complex Model parsing via `registerCodec`.
- **JSON Integration**: Automatic `json.encode` support for `Map` and `List` when converting to `String`.
- **Zero Dependencies**: Pure Dart implementation, suitable for Flutter, Web, and Server-side Dart.
- **Fully Documented**: All public APIs come with English documentation and usage examples.
- **High Test Coverage**: Extensive unit tests covering edge cases like `null`, `NaN`, `Infinity`, and invalid formats.
