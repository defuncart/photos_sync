import 'package:photos_sync/enums/client_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A class of convenience methods to get and set user preferences
class UserPreferences {
  /// A reference to the SharedPreferences instance
  static late SharedPreferences _prefs;

  /// Initializes the service which is required before first use
  static Future<void> init() async => _prefs = await SharedPreferences.getInstance();

  /// Returns whether the user is logged in
  static bool getIsLoggedIn() => getUsername() != null && getUsername()!.isNotEmpty;

  /// Returns the user's username
  static String? getUsername() => _prefs.getString(_UserPreferencesKeys.username);

  /// Sets the user's username
  static Future<void> setUsername(String username) async =>
      await _prefs.setString(_UserPreferencesKeys.username, username);

  /// Returns the client type for this device
  static ClientType? getClientType() {
    final clientTypeAsInt = _prefs.getInt(_UserPreferencesKeys.clientType);
    if (clientTypeAsInt != null && clientTypeAsInt >= 0 && clientTypeAsInt < ClientType.values.length) {
      return ClientType.values[clientTypeAsInt];
    }

    return null;
  }

  /// Sets the client type for this device
  static Future<void> setClientType(ClientType clientType) async {
    final clientTypeAsInt = ClientType.values.indexOf(clientType);
    await _prefs.setInt(_UserPreferencesKeys.clientType, clientTypeAsInt);
  }

  /// Clears all prefs
  static Future<void> clear() async => await _prefs.clear();
}

/// A class of keys to save corresponding prefs
class _UserPreferencesKeys {
  static const String username = 'username';
  static const String clientType = 'clientType';
}
