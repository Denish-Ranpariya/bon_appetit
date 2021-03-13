import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();

  Future<User> signInWithGoogle() async {
    // final GoogleSignInAccount googleSignInAccount =
    //     await _googleSignIn.signIn();
    // final GoogleSignInAuthentication googleSignInAuthentication =
    //     await googleSignInAccount.authentication;
    //
    // final AuthCredential credential = GoogleAuthProvider.credential(
    //     idToken: googleSignInAuthentication.idToken,
    //     accessToken: googleSignInAuthentication.accessToken);
    print('signin');
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    print('authenticate');
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    print('credentials');
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );


    final result = await _auth.signInWithCredential(credential);

    return result.user;
  }


  Future<void> logout() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    print('logged out');
  }
}
