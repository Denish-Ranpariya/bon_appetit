import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffbbc05),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Image.asset('images/chef.png'),
            ),
            Expanded(
              child: Text(
                'Bon Appetit',
                style: GoogleFonts.sriracha(
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                  color: Colors.black,
                ),
              ),
            ),
            GestureDetector(
              onTap: (){},
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10.0, // soften the shadow
                        spreadRadius: 0.0, //extend the shadow
                        offset: Offset(
                          4.0, // Move to right 10  horizontally
                          4.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: SvgPicture.asset('images/google_logo.svg',height: 30),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Sign in with Google',
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
