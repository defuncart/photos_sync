import 'package:flutter_test/flutter_test.dart';
import 'package:photos_sync/extensions/map_extensions.dart';

main() {
  test('tryParse: Null map', () {
    final Map map = null;
    final value = map.tryParse('key');
    expect(value, null);
  });
}
