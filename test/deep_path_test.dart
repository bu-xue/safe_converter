import 'package:test/test.dart';
import 'package:safe_converter/safe_converter.dart';

void main() {
  group('Deep Path Access Tests', () {
    final Map testMap = {
      'data': {
        'user': {
          'id': 123,
          'name': 'Dart',
          'active': true,
          'profile': {
            'avatar': 'https://example.com/avatar.png',
            'score': 99.5,
          },
          'created_at': '2023-10-01T10:00:00Z',
        },
        'items': [
          {'id': 1, 'name': 'Item 1'},
          {'id': 2, 'name': 'Item 2'},
        ],
        'counts': [10, 20, 30],
      },
      'empty': {},
      'null_val': null,
    };

    test('getString deep path access', () {
      expect(testMap.getString('data.user.name'), 'Dart');
      expect(testMap.getString('data.user.profile.avatar'),
          'https://example.com/avatar.png');
      expect(testMap.getString('data.items.0.name'), 'Item 1');
      expect(testMap.getString('data.items.1.name'), 'Item 2');
      expect(
          testMap.getString('non.existent.path', defaultValue: 'N/A'), 'N/A');
    });

    test('getInt deep path access', () {
      expect(testMap.getInt('data.user.id'), 123);
      expect(testMap.getInt('data.items.0.id'), 1);
      expect(testMap.getInt('data.counts.1'), 20);
      expect(testMap.getInt('data.user.age', defaultValue: -1), -1);
    });

    test('getDouble deep path access', () {
      expect(testMap.getDouble('data.user.profile.score'), 99.5);
      expect(testMap.getDouble('data.counts.0'), 10.0);
      expect(testMap.getDouble('invalid.path', defaultValue: 0.0), 0.0);
    });

    test('getBool deep path access', () {
      expect(testMap.getBool('data.user.active'), true);
      expect(testMap.getBool('non.existent', defaultValue: false), false);
    });

    test('getMap deep path access', () {
      final user = testMap.getMap('data.user');
      expect(user['name'], 'Dart');
      final profile = testMap.getMap('data.user.profile');
      expect(profile['score'], 99.5);
      expect(testMap.getMap('data.items.0'), {'id': 1, 'name': 'Item 1'});
    });

    test('getList deep path access', () {
      final items = testMap.getList('data.items');
      expect(items.length, 2);
      expect(items[0]['name'], 'Item 1');

      final counts = testMap.getList<int>('data.counts');
      expect(counts, [10, 20, 30]);
    });

    test('getDateTime deep path access', () {
      final dt = testMap.getDateTime('data.user.created_at');
      expect(dt.year, 2023);
      expect(dt.month, 10);
      expect(dt.day, 1);
    });

    test('getNum deep path access', () {
      expect(testMap.getNum('data.user.id'), 123);
      expect(testMap.getNum('data.user.profile.score'), 99.5);
    });

    test('Edge cases and invalid paths', () {
      expect(testMap.getString('data.user.name.invalid'), '');
      expect(testMap.getString('data.items.5.name'), '');
      expect(testMap.getString('data.items.abc.name'), '');
      expect(testMap.getString(''), '');
      expect(null.getString('any.path'), '');
    });
  });
}
