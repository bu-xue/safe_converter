# Safe Converter 🛡️

[![pub package](https://img.shields.io/pub/v/safe_converter.svg)](https://pub.dev/packages/safe_converter)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**Safe Converter** is a high-performance, developer-friendly utility designed to eliminate runtime exceptions during dynamic type conversion in Dart and Flutter. 

Stop worrying about `type 'Null' is not a subtype of type 'int'` or `FormatException`. Handle JSON parsing, API responses, and dynamic data with absolute confidence.

--- 

## ✨ Key Features

- **🛡️ Bulletproof Conversion**: Never crash on `null`, `NaN`, `Infinity`, or malformed strings.
- **🔍 Deep Path Access**: Access nested data using dot notation (e.g., `json.getString("data.user.name")`).
- **🍭 Fluent Try Aliases**: Concise `tryxx` methods (e.g., `tryInt`, `tryGetBool`) for even cleaner code.
- **🧠 Smart Parsing**: 
  - Numeric strings (`"123"`) ➡️ `int`.
  - Flexible booleans (`"yes"`, `"on"`, `"1"`) ➡️ `true`.
  - Timestamps or ISO8601 ➡️ `DateTime`.
- **⚡ Automatic JSON Decoding**: Automatically decodes JSON strings during path traversal.
- **🧩 Custom Object Support**: Register `ObjCodec` to handle your own Models effortlessly.
- **🚀 Fluent Extensions**: Minimal boilerplate with extensions on `Object` and `Map`.
- **🪶 Zero Dependencies**: Pure Dart. Lightweight and fast.

---

## 🚀 Quick Start

### 1. The "Try" Way (New! 🍭)
Short and sweet. Perfect for nullable assignments.

```dart
final name = json.tryGetString("user.profile.name"); // same as getStringOrNull
final age = json.tryGetInt("user.profile.age");     // same as getIntOrNull
final list = json.tryGetList<int>("data.scores");   // same as getListOrNull
```

### 2. Deep Path Access
Tired of writing `json['data']['user']['name']`? Now you can use dot notation. It even works if middle layers are JSON strings!

```dart
final Map<String, dynamic> json = {
  "data": {
    "user": {
      "name": "Dash",
      "settings": '{"theme": "dark"}' // Nested JSON string
    },
    "items": [{"id": 1}, {"id": 2}]
  }
};

final name = json.getString("data.user.name");          // "Dash"
final theme = json.getString("data.user.settings.theme"); // "dark" (Auto-decoded!)
final firstId = json.getInt("data.items.0.id");         // 1
```

### 3. The Basics
Use extensions on any `Object?`.

```dart
import 'package:safe_converter/safe_converter.dart';

final dynamic rawData = "123.45";

int id = rawData.try2Int() ?? 0; // 123
double price = rawData.try2Double() ?? 0.0; // 123.45
```

---

## 🏗️ Advanced: Custom Object Converters

Register a `ObjCodec` to make `SafeConverter` aware of your complex models.

```dart
SafeConverter.registerCodec<User>(ObjCodec(
  decode: (map) => User(
    name: map.getString("name"), 
    age: map.getInt("age")
  ),
  encode: (user) => {"name": user.name, "age": user.age},
));

// Use it with deep paths!
User? user = json.tryGetT<User>("data.user"); 
```

---

## 📊 Supported Types & Logic

| Target | Source Support | Special Behavior |
| :--- | :--- | :--- |
| **int** | `num`, `String`, `bool` | `double.toInt()`, `bool` (1/0), numeric string parsing. |
| **bool** | `num`, `String` | Supports `true/false`, `yes/no`, `on/off`, `1/0`. |
| **DateTime** | `String`, `int` | ISO8601 strings and Unix timestamps (ms). |
| **List<T>** | `Iterable`, `String` | Auto-converts/filters elements. Supports JSON strings. |
| **Map** | `String` | Auto-parses JSON strings into Maps. |

---

## 🪵 Production Monitoring

```dart
SafeConvertConfig.enableLog = true;
SafeConvertConfig.logHandler = (message) {
  // Integrate with Sentry, Firebase Crashlytics, etc.
  debugPrint("[SafeConverter]: $message");
};
```

## 📦 Installation

```yaml
dependencies:
  safe_converter: ^1.2.0
```

## 📜 License

MIT License.
