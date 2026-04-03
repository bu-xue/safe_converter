# Safe Converter 🛡️

[![pub package](https://img.shields.io/pub/v/safe_converter.svg)](https://pub.dev/packages/safe_converter)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Build Status](https://img.shields.io/github/actions/workflow/status/yourusername/safe_converter/dart.yml?branch=main)](https://github.com/yourusername/safe_converter/actions)

**Safe Converter** is a high-performance, developer-friendly utility designed to eliminate runtime exceptions during dynamic type conversion in Dart and Flutter. 

Stop worrying about `type 'Null' is not a subtype of type 'int'` or `FormatException`. Handle JSON parsing, API responses, and dynamic data with absolute confidence.

---

## ✨ Key Features

- **🛡️ Bulletproof Conversion**: Never crash on `null`, `NaN`, `Infinity`, or malformed strings.
- **🧠 Smart Parsing**: 
  - Numeric strings (`"123"`) ➡️ `int`.
  - Flexible booleans (`"yes"`, `"on"`, `"1"`) ➡️ `true`.
  - Timestamps or ISO8601 ➡️ `DateTime`.
- **🧩 Custom Object Support**: Register `ObjCodec` to handle your own Models effortlessly.
- **🚀 Fluent Extensions**: Minimal boilerplate with extensions on `Object` and `Map`.
- **🪵 Production Ready**: Global logging hooks to monitor data anomalies in the wild.
- **🪶 Zero Dependencies**: Pure Dart. Lightweight and fast.

---

## 🚀 Quick Start

### 1. The Basics
Use extensions on any `Object?` or direct top-level functions.

```dart
import 'package:safe_converter/safe_converter.dart';

final dynamic rawData = "123.45";

int id = rawData.safe2Int(); // 123
double price = rawData.safe2Double(); // 123.45
String text = rawData.safe2String(); // "123.45"
```

### 2. Map & API Integration (The "Golden" Way)
Safely extract values from JSON-like maps without nested `if` checks.

```dart
final Map<String, dynamic> json = {
  "id": "550e8400",
  "score": "98.5",
  "is_admin": "yes",
  "created_at": "2023-10-01T12:00:00Z"
};

final score = json.getDouble("score");         // 98.5
final isAdmin = json.getBool("is_admin");      // true
final date = json.getDateTime("created_at");   // DateTime(2023, 10, 1)
final tags = json.getList<String>("tags");      // [] (Safe default)
```

---

## 🏗️ Advanced: Custom Object Converters

You can register a `ObjCodec` to make `SafeConverter` aware of your complex models. This allows you to use `asT<User>(data)` anywhere in your app.

### Define & Register
```dart
class User {
  final String name;
  final int age;
  User({required this.name, required this.age});
}

// 1. Register the codec once (e.g., at app start)
SafeConverter.registerCodec<User>(ObjCodec(
  decode: (map) => User(
    name: map.getString("name"), 
    age: map.getInt("age")
  ),
  encode: (user) => {"name": user.name, "age": user.age},
));

// 2. Use it anywhere!
final dynamic data = {"name": "Dash", "age": "5"};
User? user = asT<User>(data); 
print(user?.name); // "Dash"
```

---

## 📊 Supported Types & Logic

| Target | Source Support | Special Behavior |
| :--- | :--- | :--- |
| **int** | `num`, `String`, `bool` | `double.toInt()`, `bool` (1/0), numeric string parsing. |
| **bool** | `num`, `String` | Supports `true/false`, `yes/no`, `on/off`, `1/0`. |
| **DateTime** | `String`, `int` | ISO8601 strings and Unix timestamps (ms). |
| **List<T>** | `Iterable` | Automatically converts/filters elements to type `T`. |
| **Map** | `String` | Auto-parses JSON strings into Maps. |

---

## 🪵 Production Monitoring

Catch unexpected backend data changes by plugging in your favorite logging or crash reporting tool:

```dart
SafeConvertConfig.enableLog = true;
SafeConvertConfig.logHandler = (message) {
  // Integrate with Sentry, Firebase Crashlytics, etc.
  debugPrint("[SafeConverter Error]: $message");
};
```

## 📦 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  safe_converter: ^1.0.0
```

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
