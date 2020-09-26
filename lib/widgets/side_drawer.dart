import 'dart:ui';

import 'package:bon_appetit/screens/about_us_screen.dart';
import 'package:bon_appetit/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SideDrawer extends StatelessWidget {
  final Function onPressedQrCode;
  final Function onLogout;

  SideDrawer({this.onPressedQrCode, this.onLogout});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            color: Color(0xFFc9e3db),
            padding: EdgeInsets.symmetric(vertical: 30),
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  'Bon Appetit',
                  style: kScreenHeadingTextStyle,
                ),
                SizedBox(
                  height: 30,
                ),
                CircleAvatar(
                  radius: 60.0,
                  backgroundImage:
                      NetworkImage(Provider.of<FirebaseUser>(context).photoUrl),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    Provider.of<FirebaseUser>(context).displayName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: onPressedQrCode,
            child: Center(
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.qrcode,
                  color: Colors.grey[700],
                ),
                title: Text('QR code'),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsScreen()),
              );
            },
            child: Center(
              child: ListTile(
                leading: Icon(
                  Icons.note,
                  color: Colors.grey[700],
                ),
                title: Text('About Us'),
              ),
            ),
          ),
          GestureDetector(
            onTap: onLogout,
            child: Center(
              child: ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.grey[700],
                ),
                title: Text('Logout'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
