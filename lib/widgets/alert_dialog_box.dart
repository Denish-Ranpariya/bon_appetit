import 'package:flutter/material.dart';

class AlertDialogBox extends StatelessWidget {
  final String textMessage;

  AlertDialogBox({this.textMessage});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(textMessage),
      actions: [
        FlatButton(
          child: Text('No'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: Text('Yes'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }
}
