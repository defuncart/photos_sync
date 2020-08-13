import 'package:shared_preferences/shared_preferences.dart';

/// A class of convenience methods to get and set user preferences
class UserPreferences {
  /// A reference to the SharedPreferences instance
  static SharedPreferences _prefs;

  /// Initializes the service which is required before first use
  static Future<void> init() async => _prefs = await SharedPreferences.getInstance();

  /// Returns whether the user is logged in
  static bool getIsLoggedIn() => getUsername() != null && getUsername().isNotEmpty;

  /// Returns the user's username
  static String getUsername() => _prefs.getString(_UserPreferencesKeys.username);

  /// Sets the user's username
  static Future<void> setUsername(String username) async =>
      await _prefs.setString(_UserPreferencesKeys.username, username);

  /// Clears all prefs
  static Future<void> clear() async => await _prefs.clear();
}

/// A class of keys to save corresponding prefs
class _UserPreferencesKeys {
  static const String username = 'username';
}
