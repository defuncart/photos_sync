import 'package:flutter/material.dart';

class ModalProgressIndicator {
  static OverlayEntry? _overlayEntry;

  static show(BuildContext context) {
    final overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Container(
        color: Colors.black.withAlpha(128),
        width: double.infinity,
        height: double.infinity,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
    overlayState?.insert(_overlayEntry!);
  }

  static dismiss() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
