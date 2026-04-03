import 'package:safe_converter/safe_converter.dart';

void main() {
  // Complex nested JSON data (could be from a remote API)
  final Map<String, dynamic> apiResponse = {
    'status': 'success',
    'data': {
      'user': {
        'id': '1001',
        'name': 'Safe Converter User',
        'profile': {
          'avatar': 'https://example.com/avatar.png',
          'points': '1500.5',
          'level': 5,
        },
        // Mixed JSON string (some backend might return a serialized string)
        'settings':
            '{"theme": "dark", "notifications": true, "languages": ["en", "zh"]}',
        'created_at': '2023-10-27T10:00:00Z',
      },
      'orders': [
        {'order_id': 'ORD_001', 'total': 99.9, 'status': 'completed'},
        {'order_id': 'ORD_002', 'total': 120.0, 'status': 'pending'},
      ],
    }
  };

  print('--- Basic Info ---');
  // Access deep properties using dot notation
  final userName = apiResponse.getString('data.user.name');
  final userPoints = apiResponse.getDouble('data.user.profile.points');
  final userLevel = apiResponse.getInt('data.user.profile.level');

  print('Name: $userName'); // Name: Safe Converter User
  print('Points: $userPoints'); // Points: 1500.5
  print('Level: $userLevel'); // Level: 5

  print('\n--- JSON String Deep Access ---');
  // The library automatically decodes JSON strings during path traversal!
  final theme = apiResponse.getString('data.user.settings.theme');
  final isNotificationsEnabled =
      apiResponse.getBool('data.user.settings.notifications');
  final firstLang = apiResponse.getString('data.user.settings.languages.0');

  print('Theme: $theme'); // Theme: dark
  print('Notifications: $isNotificationsEnabled'); // Notifications: true
  print('First Language: $firstLang'); // First Language: en

  print('\n--- List Access ---');
  // Access list items by index
  final firstOrderId = apiResponse.getString('data.orders.0.order_id');
  final secondOrderTotal = apiResponse.getDouble('data.orders.1.total');
  final orderCount = apiResponse.getList('data.orders').length;

  print('First Order ID: $firstOrderId'); // First Order ID: ORD_001
  print('Second Order Total: $secondOrderTotal'); // Second Order Total: 120.0
  print('Total Orders: $orderCount'); // Total Orders: 2

  print('\n--- DateTime Support ---');
  final createdAt = apiResponse.getDateTime('data.user.created_at');
  print('Created At Year: ${createdAt.year}'); // Created At Year: 2023

  print('\n--- Fallback Default Values ---');
  // Safe access with default values if path doesn't exist or type mismatch
  final missingValue =
      apiResponse.getString('data.user.missing_field', defaultValue: 'N/A');
  final invalidIndex =
      apiResponse.getString('data.orders.5.order_id', defaultValue: 'None');

  print('Missing: $missingValue'); // Missing: N/A
  print('Invalid Index: $invalidIndex'); // Invalid Index: None
}
