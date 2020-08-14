import 'package:flutter/material.dart';

class ModalProgressIndicator {
  static OverlayEntry _overlayEntry;

  static show(BuildContext context) {
    OverlayState overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Container(
        color: Colors.black.withAlpha(128),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
    overlayState.insert(_overlayEntry);
  }

  static dismiss() {
    _overlayEntry.remove();
    _overlayEntry = null;
  }
}
