import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'form_screen.dart';
import 'login_screen.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Future<bool> onPressedBack(){
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Do you really want to close the app?'),
        actions: [
          FlatButton(
            child: Text('No'),
            onPressed: (){
              Navigator.pop(context,false);
            },
          ),
          FlatButton(
            child: Text('Yes'),
            onPressed: (){
              Navigator.pop(context,true);
            },
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // will return login screen or form screen
    final user = Provider.of<FirebaseUser>(context);
    //return either home or authenticate widget
    if(user == null){
      return WillPopScope(
        onWillPop:onPressedBack,
        child: LoginScreen());
    }else{
      return WillPopScope(
        onWillPop:onPressedBack,
        child: FormScreen());
    }
  }
}
