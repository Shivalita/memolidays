// //! Connexion au compte Google

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class LoginRemoteSource {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn ();

  LoginRemoteSource._();

  static LoginRemoteSource _cache;

  factory LoginRemoteSource() => _cache ??= LoginRemoteSource._();

  Future<dynamic> signInWithGoogle() async {
    
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    return user;
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Sign Out");
  }

}