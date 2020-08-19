import 'package:flutter/material.dart';
import 'package:photos_sync/i18n.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String description;

  const ConfirmDialog({
    @required this.title,
    @required this.description,
    Key key,
  })  : assert(title != null),
        assert(description != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: <Widget>[
        FlatButton(
          child: Text(I18n.generalNo),
          textColor: Theme.of(context).textTheme.bodyText1.color,
          onPressed: () => Navigator.of(context).pop(false),
        ),
        FlatButton(
          child: Text(I18n.generalYes),
          textColor: Theme.of(context).accentColor,
          onPressed: () => Navigator.of(context).pop(true),
        )
      ],
    );
  }
}

Future<bool> showConfirmDialog({
  @required BuildContext context,
  @required String title,
  @required String description,
}) async =>
    await showDialog<bool>(
      context: context,
      builder: (_) => ConfirmDialog(
        title: title,
        description: description,
      ),
    );
