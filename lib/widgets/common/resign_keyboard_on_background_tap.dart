import 'package:flutter/material.dart';

class ResignKeyboardOnBackgroundTap extends StatelessWidget {
  final Widget child;

  const ResignKeyboardOnBackgroundTap({
    @required this.child,
    Key key,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
