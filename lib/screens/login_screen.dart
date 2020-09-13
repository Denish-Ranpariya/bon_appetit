import 'package:bon_appetit/services/auth_service.dart';
import 'package:bon_appetit/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 110),
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'images/soup.png',
                      height: 200,
                      width: 200,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Bon Appetit',
                      style: GoogleFonts.sriracha(
                        fontSize: 40,
                        color: Colors.amber[500],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        AuthService authService = new AuthService();
                        FirebaseUser firebaseUser =
                            await authService.signInWithGoogle();
                        print(firebaseUser.uid);

                        if (!_disposed) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      } catch (e) {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 15.0, // soften the shadow
                              spreadRadius: 0.0, //extend the shadow
                              offset: Offset(
                                4.0,
                                4.0,
                              ),
                            )
                          ],
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: SvgPicture.asset('images/google_logo.svg',
                                  height: 30),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                'Sign in with Google',
                                style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600],
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
