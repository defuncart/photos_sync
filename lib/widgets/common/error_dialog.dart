import 'package:flutter/material.dart';
import 'package:photos_sync/i18n.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(I18n.errorPopupTitleText),
      content: Text(I18n.errorPopupDescriptionText),
      actions: <Widget>[
        FlatButton(
          child: Text(I18n.generalOk),
          textColor: Theme.of(context).accentColor,
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}

void showErrorDialog(BuildContext context) => showDialog(
      context: context,
      builder: (_) => ErrorDialog(),
    );
