import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:photos_sync/i18n.dart';
import 'package:photos_sync/modules/backend/backend.dart';
import 'package:photos_sync/services/firebase_service.dart';

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
        home: Scaffold(
          appBar: AppBar(
            title: Text('Photos Sync'),
          ),
          body: _HomeScreen(),
        ),
      ),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(I18n.test),
    );
  }
}
