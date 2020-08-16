import 'package:flutter/material.dart';
import 'package:photos_sync/configs/route_names.dart';
import 'package:photos_sync/i18n.dart';
import 'package:photos_sync/modules/backend/backend.dart';
import 'package:photos_sync/modules/user_preferences/user_preferences.dart';
import 'package:photos_sync/widgets/common/custom_button.dart';
import 'package:provider/provider.dart';

import '../../modules/backend/backend.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: CustomButton(
            buttonText: I18n.homeScreenLogoutButtonText,
            onPressed: () async {
              await context.read<IAuthService>().logout();
              await UserPreferences.setUsername('');
              Navigator.of(context).pushReplacementNamed(RouteNames.welcomeScreen);
            },
          ),
        ),
      ),
    );
  }
}
