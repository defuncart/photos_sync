/// Map extension methods
extension MapExtension on Map {
  /// Tries to parse a key. Returns `null` if the key does not exist.
  dynamic tryParse(dynamic key) => this != null && this.containsKey(key) ? this[key] : null;
}
