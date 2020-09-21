import 'package:bon_appetit/screens/wrapper.dart';
import 'package:bon_appetit/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(BonAppetit());
}

class BonAppetit extends StatelessWidget {
  const BonAppetit({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: Wrapper(),
      ),
    );
  }
}
