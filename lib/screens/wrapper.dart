import 'package:flutter/material.dart';

import 'login_screen.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    // will return login screen or form screen
    return LoginScreen();
  }
}