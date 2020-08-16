import 'package:flutter/material.dart';
import 'package:photos_sync/configs/route_names.dart';
import 'package:photos_sync/i18n.dart';
import 'package:photos_sync/modules/backend/backend.dart';
import 'package:photos_sync/modules/user_preferences/user_preferences.dart';
import 'package:photos_sync/widgets/auth/auth_screen.dart';
import 'package:photos_sync/widgets/common/error_dialog.dart';
import 'package:photos_sync/widgets/common/modal_progress_indicator.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthScreen(
      title: I18n.loginScreenTitle,
      mainButtonText: I18n.loginScreenMainButtonText,
      onMainButtonPressed: (email, password) async {
        ModalProgressIndicator.show(context);
        final success = await context.read<IAuthService>().login(email: email, password: password);
        ModalProgressIndicator.dismiss();
        if (success) {
          await UserPreferences.setUsername(email);
          await Navigator.of(context).pushReplacementNamed(RouteNames.homeScreen);
        } else {
          showErrorDialog(context);
        }
      },
      secondaryButtonText: I18n.loginScreenSecondaryButtonText,
      onSecondaryButtonPressed: () => Navigator.of(context).pushReplacementNamed(RouteNames.signupScreen),
    );
  }
}
