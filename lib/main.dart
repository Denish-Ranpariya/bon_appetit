import 'package:bon_appetit/screens/wrapper.dart';
import 'package:bon_appetit/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(BonAppetit());
}

class BonAppetit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: MySplash(),
      ),
    );
  }
}

class MySplash extends StatefulWidget {
  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      photoSize: 100,
      seconds: 5,
      title: Text(
        'Bon Appetit',
        style: GoogleFonts.patuaOne(
          fontSize: 30,
          color: Colors.grey[700],
          fontWeight: FontWeight.w400,
        ),
      ),
      image: Image(
        image: AssetImage('images/soup.png'),
      ),
      backgroundColor: Color(0xffc9e3db),
      navigateAfterSeconds: Wrapper(),
    );
  }
}
