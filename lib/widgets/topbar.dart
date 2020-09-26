import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final IconData iconData;
  final String iconTitle;
  final Function onPressed;

  TopBar({this.iconData, this.iconTitle = '', this.onPressed});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.grey[700]),
      backgroundColor: Color(0xFFc9e3db),
      elevation: 0,
      title: Text(
        'Bon Appetit',
        style: TextStyle(color: Colors.grey[800]),
      ),
      actions: <Widget>[
        FlatButton.icon(
          label: Text(iconTitle),
          icon: Icon(
            iconData,
            color: Colors.grey[800],
          ),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
