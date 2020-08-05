import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'form_screen.dart';
import 'login_screen.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  @override
  Widget build(BuildContext context) {
    // will return login screen or form screen
    final user = Provider.of<FirebaseUser>(context);
    //return either home or authenticate widget
    if(user == null){
      return LoginScreen();
    }else{
      return FormScreen();
    }
  }
}
