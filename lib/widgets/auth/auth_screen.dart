import 'package:flutter/material.dart';
import 'package:photos_sync/i18n.dart';
import 'package:photos_sync/services/validator.dart';
import 'package:photos_sync/widgets/common/custom_button.dart';
import 'package:photos_sync/widgets/common/resign_keyboard_on_background_tap.dart';

class AuthScreen extends StatefulWidget {
  final String title;
  final String mainButtonText;
  final void Function(String, String) onMainButtonPressed;
  final String secondaryButtonText;
  final void Function() onSecondaryButtonPressed;

  const AuthScreen({
    @required this.title,
    @required this.mainButtonText,
    @required this.onMainButtonPressed,
    @required this.secondaryButtonText,
    @required this.onSecondaryButtonPressed,
    Key key,
  }) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String _email = '';
  String _password = '';
  bool _isEmailPasswordValid = false;
  bool _shouldObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ResignKeyboardOnBackgroundTap(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Container(height: 16),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(height: 32),
                _CustomTextField(
                  onChanged: (value) {
                    _email = value;
                    _validateInput();
                  },
                  hintText: I18n.generalEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                Container(height: 16),
                _CustomTextField(
                  onChanged: (value) {
                    _password = value;
                    _validateInput();
                  },
                  hintText: I18n.generalPassword,
                  shouldObscureText: _shouldObscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _shouldObscurePassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () => setState(() => _shouldObscurePassword = !_shouldObscurePassword),
                  ),
                ),
                // call to action
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomButton(
                          buttonText: widget.mainButtonText,
                          onPressed: _isEmailPasswordValid
                              ? () {
                                  FocusScope.of(context).unfocus();
                                  widget.onMainButtonPressed(_email, _password);
                                }
                              : null,
                        ),
                        Container(height: 8),
                        FlatButton(
                          child: Text(widget.secondaryButtonText),
                          onPressed: widget.onSecondaryButtonPressed,
                        ),
                        Container(height: 8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validateInput() => setState(
        () => _isEmailPasswordValid = Validator.isValidEmail(_email) && Validator.isValidPassword(_password),
      );
}

class _CustomTextField extends StatelessWidget {
  final Function(String) onChanged;
  final String hintText;
  final String errorText;
  final TextInputType keyboardType;
  final bool shouldObscureText;
  final Widget suffixIcon;

  const _CustomTextField({
    @required this.onChanged,
    @required this.hintText,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.shouldObscureText = false,
    this.suffixIcon,
    Key key,
  })  : assert(onChanged != null),
        assert(hintText != null),
        assert(shouldObscureText != null),
        assert(keyboardType != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).disabledColor,
            ),
            borderRadius: const BorderRadius.all(
              const Radius.circular(24.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
            ),
            borderRadius: const BorderRadius.all(
              const Radius.circular(24.0),
            ),
          ),
          filled: false,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).disabledColor,
          ),
          suffixIcon: suffixIcon),
      cursorColor: Theme.of(context).accentColor,
      obscureText: shouldObscureText,
      keyboardType: keyboardType,
      autocorrect: false,
    );
  }
}
