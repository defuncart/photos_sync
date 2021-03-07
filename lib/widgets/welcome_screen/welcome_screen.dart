import 'package:flutter/material.dart';
import 'package:photos_sync/configs/route_names.dart';
import 'package:photos_sync/i18n.dart';
import 'package:photos_sync/widgets/common/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            Text(I18n.welcomeScreenDescriptionText),
            // call to action
            Column(
              children: [
                CustomButton(
                  buttonText: I18n.welcomeScreenSignupButtonText,
                  onPressed: () => Navigator.of(context).pushReplacementNamed(RouteNames.signupScreen),
                  isFilled: true,
                ),
                Container(height: 16),
                CustomButton(
                  buttonText: I18n.welcomeScreenLoginButtonText,
                  onPressed: () => Navigator.of(context).pushReplacementNamed(RouteNames.loginScreen),
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
