import 'package:flutter/material.dart';
import 'package:photos_sync/i18n.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String description;

  const ConfirmDialog({
    required this.title,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: <Widget>[
        TextButton(
          child: Text(I18n.generalNo),
          style: TextButton.styleFrom(
            primary: Theme.of(context).textTheme.bodyText2!.color,
          ),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        TextButton(
          child: Text(I18n.generalYes),
          style: TextButton.styleFrom(
            primary: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () => Navigator.of(context).pop(true),
        )
      ],
    );
  }
}

Future<bool> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String description,
}) async =>
    await showDialog<bool>(
      context: context,
      builder: (_) => ConfirmDialog(
        title: title,
        description: description,
      ),
    ) ??
    false;
