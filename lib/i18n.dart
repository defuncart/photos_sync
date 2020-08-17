import 'dart:async';

import 'package:flutter/material.dart';

/// This class is generated by the flappy_translator package
/// Please do not change anything manually in this file, instead re-generate it when changes are available
class I18n {
  static String get generalOk => _getText('generalOk');

  static String get generalEmail => _getText('generalEmail');

  static String get generalPassword => _getText('generalPassword');

  static String get welcomeScreenDescriptionText =>
      _getText('welcomeScreenDescriptionText');

  static String get welcomeScreenSignupButtonText =>
      _getText('welcomeScreenSignupButtonText');

  static String get welcomeScreenLoginButtonText =>
      _getText('welcomeScreenLoginButtonText');

  static String get singupScreenTitle => _getText('singupScreenTitle');

  static String get singupScreenMainButtonText =>
      _getText('singupScreenMainButtonText');

  static String get singupScreenSecondaryButtonText =>
      _getText('singupScreenSecondaryButtonText');

  static String get loginScreenTitle => _getText('loginScreenTitle');

  static String get loginScreenMainButtonText =>
      _getText('loginScreenMainButtonText');

  static String get loginScreenSecondaryButtonText =>
      _getText('loginScreenSecondaryButtonText');

  static String get homeScreenDeleteAllButtonText =>
      _getText('homeScreenDeleteAllButtonText');

  static String get homeScreenLogoutButtonText =>
      _getText('homeScreenLogoutButtonText');

  static String homeScreenUploadingText({
    @required int completed,
    @required int total,
  }) {
    String text = _getText('homeScreenUploadingText');
    if (completed != null) {
      text = text.replaceAll("%completed\$d", completed.toString());
    }
    if (total != null) {
      text = text.replaceAll("%total\$d", total.toString());
    }
    return text;
  }

  static String get errorPopupTitleText => _getText('errorPopupTitleText');

  static String get errorPopupDescriptionText =>
      _getText('errorPopupDescriptionText');

  static Map<String, String> _localizedValues;

  static Map<String, String> _deValues = {
    'generalOk': 'Ok',
    'generalEmail': 'Email',
    'generalPassword': 'Passwort',
    'welcomeScreenDescriptionText':
        'Synchronisier deine Bilder mit einem Remote-Server.',
    'welcomeScreenSignupButtonText': 'Anmelden',
    'welcomeScreenLoginButtonText': 'Einloggen',
    'singupScreenTitle': 'Anmelden',
    'singupScreenMainButtonText': 'Konto eröffnen',
    'singupScreenSecondaryButtonText': 'Du hast schon ein Konto?',
    'loginScreenTitle': 'Einloggen',
    'loginScreenMainButtonText': 'Fortfahren',
    'loginScreenSecondaryButtonText': 'Du hast noch kein Konto?',
    'homeScreenDeleteAllButtonText': 'Alle Bilder löschen',
    'homeScreenLogoutButtonText': 'Ausloggen',
    'homeScreenUploadingText': 'Uploading %completed\$d/%total\$d...',
    'errorPopupTitleText': 'Ooops',
    'errorPopupDescriptionText': 'Etwas ist schief gelaufen',
  };

  static Map<String, String> _enValues = {
    'generalOk': 'Ok',
    'generalEmail': 'Email',
    'generalPassword': 'Password',
    'welcomeScreenDescriptionText':
        'Easily sync your photos with a remote server.',
    'welcomeScreenSignupButtonText': 'Signup',
    'welcomeScreenLoginButtonText': 'Login',
    'singupScreenTitle': 'Signup',
    'singupScreenMainButtonText': 'Create Account',
    'singupScreenSecondaryButtonText': 'Already have an account?',
    'loginScreenTitle': 'Login',
    'loginScreenMainButtonText': 'Continue',
    'loginScreenSecondaryButtonText': 'Don\'t have an account?',
    'homeScreenDeleteAllButtonText': 'Delete all photos',
    'homeScreenLogoutButtonText': 'Logout',
    'homeScreenUploadingText': 'Uploading %completed\$d/%total\$d...',
    'errorPopupTitleText': 'Ooops',
    'errorPopupDescriptionText': 'Something went wrong',
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
