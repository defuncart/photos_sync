import 'dart:async';

import 'package:flutter/material.dart';

/// This class is generated by the flappy_translator package
/// Please do not change anything manually in this file, instead re-generate it when changes are available
class I18n {
  static String get authScreenDescriptionText =>
      _getText('authScreenDescriptionText');

  static String get authScreenSignupButtonText =>
      _getText('authScreenSignupButtonText');

  static String get authScreenLoginButtonText =>
      _getText('authScreenLoginButtonText');

  static String get homeScreenLogoutButtonText =>
      _getText('homeScreenLogoutButtonText');

  static Map<String, String> _localizedValues;

  static Map<String, String> _deValues = {
    'authScreenDescriptionText':
        'Synchronisier deine Bilder mit Remote-Server.',
    'authScreenSignupButtonText': 'Anmelden',
    'authScreenLoginButtonText': 'Einloggen',
    'homeScreenLogoutButtonText': 'Ausloggen',
  };

  static Map<String, String> _enValues = {
    'authScreenDescriptionText':
        'Easily sync your photos with a remote server.',
    'authScreenSignupButtonText': 'Signup',
    'authScreenLoginButtonText': 'Login',
    'homeScreenLogoutButtonText': 'Logout',
  };

  static Map<String, Map<String, String>> _allValues = {
    'de': _deValues,
    'en': _enValues,
  };

  I18n(Locale locale) {
    _locale = locale;
    _localizedValues = null;
  }

  static Locale _locale;

  static String _getText(String key) {
    return _localizedValues[key] ?? '** $key not found';
  }

  static Locale get currentLocale => _locale;

  static String get currentLanguage => _locale.languageCode;

  static Future<I18n> load(Locale locale) async {
    final translations = I18n(locale);
    _localizedValues = _allValues[locale.toString()];
    return translations;
  }
}

class I18nDelegate extends LocalizationsDelegate<I18n> {
  const I18nDelegate();

  static final Set<Locale> supportedLocals = {
    Locale('de'),
    Locale('en'),
  };

  @override
  bool isSupported(Locale locale) => supportedLocals.contains(locale);

  @override
  Future<I18n> load(Locale locale) => I18n.load(locale);

  @override
  bool shouldReload(I18nDelegate old) => false;
}
