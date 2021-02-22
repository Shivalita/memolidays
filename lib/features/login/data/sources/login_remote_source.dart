import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:memolidays/features/login/domain/models/user.dart' as entity;
import 'package:http/http.dart' as http;
import 'package:memolidays/features/login/data/sources/local_source.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class LoginRemoteSource {

  final LocalSource localSource = LocalSource();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn ();

  // Singleton initialization
  LoginRemoteSource._();
  static LoginRemoteSource _cache;
  factory LoginRemoteSource() => _cache ??= LoginRemoteSource._();

  // Get localhost from .env file
  final LOCALHOST = env['LOCALHOST'];

  User user;
  entity.User userEntity;
  int userId;
  Map<String, dynamic> userData;


  // Login with Google account & call user getter method
  Future<entity.User> login() async {
    user = await signInWithGoogle();
    userEntity = await getUser(user.email);
    return userEntity;
  }

  // Set Google authentication
  Future<User> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final authResult = await _auth.signInWithCredential(credential);
      user = authResult.user;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
    }

    catch (error) {
      print('ERROR : $error');
      throw Exception();
    }

    return user;
  }


  // If user exists in database get user from API, else call user creation method
  Future<entity.User> getUser(email) async {
    String url = "http://" + LOCALHOST + "/api/users?email=$email";
    entity.User userEntity;

    final response = await http.get(url);
    if (response.statusCode != 200) throw Exception;

    final Map<String, dynamic> data = json.decode(response.body);

    //! ---------------------------------------------------------------------------
    print("data['hydra:member'][0] ------------------------------------------------------------------");
    print(data['hydra:member'][0]);

    print("data['hydra:member'][0]['name'] ------------------------------------------------------------------");
    print(data['hydra:member'][0]['name']);

    print("data['hydra:member'][0]['categories'] ------------------------------------------------------------------");
    print(data['hydra:member'][0]['categories']);

    print("data['hydra:member'][0]['categories'][0]['name'] ------------------------------------------------------------------");
    print(data['hydra:member'][0]['categories'][0]['name']);

    print("data['hydra:member'][0]['categories'][0]['pin']['color'] ------------------------------------------------------------------");
    print(data['hydra:member'][0]['categories'][0]['pin']['color']);

    print("data['hydra:member'][0]['souvenirs'] ------------------------------------------------------------------");
    print(data['hydra:member'][0]['souvenirs']);

    print("data['hydra:member'][0]['souvenirs'][0]['title'] ------------------------------------------------------------------");
    print(data['hydra:member'][0]['souvenirs'][0]['title']);

    print("data['hydra:member'][0]['souvenirs'][0]['files'][0]['path'] ------------------------------------------------------------------");
    print(data['hydra:member'][0]['souvenirs'][0]['files'][0]['path']);
    //! ---------------------------------------------------------------------------

    if (data['hydra:member'].isNotEmpty) {
      userEntity = entity.User.fromJson(data['hydra:member'][0]);
    } else {
      userData = await createUser();
      userEntity = entity.User.fromJson(userData);
    }

    return userEntity;
  }


  // Create user from Google account user data, set isPremium to false by default
  Future<Map<String, dynamic>> createUser() async {
    String url = "http://" + LOCALHOST + "/api/users";

    String data = json.encode({
      "googleId" : user.uid, 
      "name" : user.displayName, 
      "email" : user.email, 
      "avatar" : user.photoURL.toString(),
      "isPremium" : false, 
    });

    Map<String,String> headers = {
      'Content-type' : 'application/json; charset=UTF-8', 
      'Accept': 'application/json',
    };

    final response = await http.post(url, body: data, headers: headers);
    if (response.statusCode != 201) throw Exception;

    final Map<String, dynamic> responseJson = json.decode(response.body);
    return responseJson;
  }


  // Disconnect from Google account
  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
  }

}