//! Connexion to Google account, get user data and instanciate User
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:memolidays/features/login/domain/models/user.dart' as entity;
import 'package:memolidays/core/components/exceptions/google_auth_exception.dart';

class LoginRemoteSource {
  
  //! Google authentification process
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn ();

  LoginRemoteSource._();

  static LoginRemoteSource _cache;

  factory LoginRemoteSource() => _cache ??= LoginRemoteSource._();

  Future<entity.User> signInWithGoogle(context) async {
    
    //! Google authentication
    try {

      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      //! Get logged in user data
      final authResult = await _auth.signInWithCredential(credential);
      final User user = authResult.user;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      //! Instanciate and return User 
      final entity.User userEntity = new entity.User(user.uid, user.displayName, user.email);

      return userEntity;

    }

    //! Handle Google authentication error
    catch (error) {

      print('ERROR : ');
      print(error);
      throw GoogleAuthException(context);

    }

  }

  //! Google account disconnection
  Future<String> signOutGoogle(context) async {
    await googleSignIn.signOut();
    return 'User disconnected';
  }

}