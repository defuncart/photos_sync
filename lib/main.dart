import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:photos_sync/modules/user_preferences/user_preferences.dart';
import 'package:photos_sync/widgets/my_app.dart';

void main() async {
  // TODO move to an initialization widget
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  // await UserPreferences.clear();
  await Firebase.initializeApp();

  runApp(MyApp());
}
