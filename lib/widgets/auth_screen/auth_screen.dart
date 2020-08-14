import 'package:flutter/material.dart';
import 'package:photos_sync/configs/route_names.dart';
import 'package:photos_sync/i18n.dart';
import 'package:photos_sync/modules/backend/backend.dart';
import 'package:photos_sync/widgets/common/custom_button.dart';
import 'package:photos_sync/widgets/common/modal_progress_indicator.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<IAuthService>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // logo
            Column(
              children: [
                Container(height: 48),
                Text(
                  'Photo',
                  style: TextStyle(
                    fontSize: 40,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 5
                      ..color = Colors.black,
                    letterSpacing: 3,
                  ),
                ),
                Stack(
                  children: [
                    Text(
                      'Sync',
                      style: TextStyle(
                        fontSize: 40,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = Colors.black,
                        letterSpacing: 3,
                      ),
                    ),
                    Text(
                      'Sync',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        letterSpacing: 3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // description
            Text(I18n.authScreenDescriptionText),
            // call to action
            Column(
              children: [
                CustomButton(
                  buttonText: I18n.authScreenSignupButtonText,
                  onPressed: () async {
                    ModalProgressIndicator.show(context);
                    final success = await authService.createUserAccount(email: 'bla@test.de', password: '123456');
                    ModalProgressIndicator.dismiss();
                    if (success) {
                      await Navigator.of(context).pushReplacementNamed(RouteNames.homeScreen);
                    }
                  },
                  isFilled: true,
                ),
                CustomButton(
                  buttonText: I18n.authScreenLoginButtonText,
                  onPressed: () async {
                    ModalProgressIndicator.show(context);
                    final success = await authService.login(email: 'test@test.de', password: '123456');
                    ModalProgressIndicator.dismiss();
                    if (success) {
                      await Navigator.of(context).pushReplacementNamed(RouteNames.homeScreen);
                    }
                  },
                  isFilled: false,
                ),
                Container(height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
