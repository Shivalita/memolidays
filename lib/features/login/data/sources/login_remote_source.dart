//! Connexion to Google account, get user data from Google and Memolidays, and instanciate User
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:memolidays/features/login/domain/models/user.dart' as entity;
import 'package:memolidays/core/components/exceptions/google_auth_exception.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

class LoginRemoteSource {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn ();

  LoginRemoteSource._();
  static LoginRemoteSource _cache;
  factory LoginRemoteSource() => _cache ??= LoginRemoteSource._();

  Future<entity.User> signInWithGoogle(context) async {
    
    try {

      //! Google authentication
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      //! Get logged in Google user data
      final authResult = await _auth.signInWithCredential(credential);
      final User user = authResult.user;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      //! Get Memolidays user data
      final dynamic memolidaysUser = await getMemolidaysUser();

      final String memolidaysUserId = memolidaysUser['data'][0]['id'].toString();

      //! Instanciate and return User 
      final entity.User userEntity = new entity.User(user.uid, user.displayName, user.email, memolidaysUserId);

      //! Store user ids on local storage
      var storageBox = Hive.box('storageBox');
      storageBox.put('googleId', userEntity.googleId);
      storageBox.put('memolidaysId', userEntity.memolidaysId);

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

  //! Get Memolidays user data using mail and id (not dynamic for now)
  Future<dynamic> getMemolidaysUser() async {
    final String api = "http://94.23.11.60:8081/memoservices/api/v2/";
    final String link = api+'user/find';
    final dynamic request = await http.post(
      link,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "email": "00708valentin@gmail.com",
        "user": "799",
      }),
    ); 

    if (request.statusCode != 200) throw Exception;

    final Map<String, dynamic> userData = jsonDecode(request.body);

    return userData;
  }
  
}