import 'package:bon_appetit/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BonAppetit());
}

class BonAppetit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MySplash(),
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return SplashScreen(
      photoSize: 100,
      seconds: 3,
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
