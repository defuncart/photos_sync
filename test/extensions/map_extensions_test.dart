import 'package:flutter_test/flutter_test.dart';
import 'package:photos_sync/extensions/map_extensions.dart';

main() {
  test('tryParse: Null map', () {
    const Map? map = null;
    final value = map.tryParse('key');
    expect(value, null);
  });

  test('tryParse: Empty map', () {
    final Map map = {};
    final value = map.tryParse('key');
    expect(value, null);
  });

  test('tryParse: Null key', () {
    final Map map = {'key': 'myString'};
    final value = map.tryParse(null);
    expect(value, null);
  });

  test('tryParse: Incorrect key', () {
    final Map map = {'key': 'myString'};
    final value = map.tryParse('bla');
    expect(value, null);
  });

  test('tryParse: Correct key', () {
    final Map map = {'key': 'myString'};
    final value = map.tryParse('key');
    expect(value, 'myString');
  });
}
