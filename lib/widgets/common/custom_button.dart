import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final void Function() onPressed;
  final bool isFilled;

  const CustomButton({
    @required this.buttonText,
    @required this.onPressed,
    this.isFilled = true,
    Key key,
  })  : assert(buttonText != null),
        assert(onPressed != null),
        assert(isFilled != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: isFilled ? Colors.black : Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.black,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          buttonText.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      textColor: isFilled ? Colors.white : Colors.black,
      onPressed: onPressed,
      minWidth: MediaQuery.of(context).size.width * 0.75,
    );
  }
}
