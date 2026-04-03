# CHANGELOG

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
