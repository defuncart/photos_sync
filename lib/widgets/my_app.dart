import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:photos_sync/configs/route_names.dart';
import 'package:photos_sync/i18n.dart';
import 'package:photos_sync/modules/backend/backend.dart';
import 'package:photos_sync/modules/user_preferences/user_preferences.dart';
import 'package:photos_sync/services/firebase_service.dart';
import 'package:photos_sync/widgets/auth_screen/auth_screen.dart';
import 'package:photos_sync/widgets/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  static final _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IAuthService>.value(
          value: _firebaseService,
        ),
        Provider<ISyncService>.value(
          value: _firebaseService,
        ),
        Provider<IDatabaseService>.value(
          value: _firebaseService,
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          const I18nDelegate(),
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: I18nDelegate.supportedLocals,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.white,
        ),
        home: UserPreferences.getIsLoggedIn() ? HomeScreen() : AuthScreen(),
        routes: {
          RouteNames.authScreen: (_) => AuthScreen(),
          RouteNames.homeScreen: (_) => HomeScreen(),
        },
      ),
    );
  }
}
