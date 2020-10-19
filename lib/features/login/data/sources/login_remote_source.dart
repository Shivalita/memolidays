import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:memolidays/features/login/domain/models/user.dart' as entity;
import 'package:http/http.dart' as http;

class LoginRemoteSource {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn ();

  entity.User userEntity;

  LoginRemoteSource._();
  static LoginRemoteSource _cache;
  factory LoginRemoteSource() => _cache ??= LoginRemoteSource._();

  Future<entity.User> signInWithGoogle() async {
    
    try {

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

      final dynamic memolidaysUser = await getMemolidaysUser();
      final int memolidaysUserId = memolidaysUser['data'][0]['id'];

      userEntity = entity.User(user.uid, user.displayName, user.email, memolidaysUserId);
      return userEntity;

    }

    catch (error) {
      print('ERROR : ');
      print(error);
      throw Exception();
    }

  }

  Future<String> signOutGoogle() async {
    await googleSignIn.signOut();
    return 'User disconnected';
  }

  Future<dynamic> getMemolidaysUser() async {
    final String api = "http://94.23.11.60:8081/memoservices/api/v2/";
    final String link = '${api}user/find';
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