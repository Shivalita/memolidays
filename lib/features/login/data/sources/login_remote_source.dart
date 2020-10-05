//! Connexion to Google account, get user data and instanciate User
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:memolidays/features/login/domain/models/user.dart' as entity;

class LoginRemoteSource {
  
  //! Google authentification process
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn ();

  LoginRemoteSource._();

  static LoginRemoteSource _cache;

  factory LoginRemoteSource() => _cache ??= LoginRemoteSource._();

  Future<entity.User> signInWithGoogle() async {
    
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

  //! Google account disconnection
  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Sign Out");
  }

}

// as entity 
// entity.user.toto