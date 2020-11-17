import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:memolidays/features/login/domain/models/user.dart' as entity;
import 'package:http/http.dart' as http;
import 'package:memolidays/features/login/data/sources/local_source.dart';

class LoginRemoteSource {

  final LocalSource localSource = LocalSource();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn ();

  // Singleton initialization
  LoginRemoteSource._();
  static LoginRemoteSource _cache;
  factory LoginRemoteSource() => _cache ??= LoginRemoteSource._();

  entity.User userEntity;
  int userId;
  Map<String, dynamic> userData;


  // Login with Google account & call user creation method
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

      userData = await createUser(user);  
      entity.User userEntity = entity.User.fromJson(userData);
      return userEntity;
    }

    catch (error) {
      print('ERROR : ');
      print(error);
      throw Exception();
    }
  }


  // Create user from Google account data, set isPremium to false by default
  Future<Map<String, dynamic>> createUser(user) async {
    String url = "http://192.168.1.110:8000/api/users";

    var data = json.encode({
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


  // Disconnect from Google account connection
  Future<String> signOutGoogle() async {
    await googleSignIn.signOut();
    return 'User disconnected';
  }

  // Get registered user from API & instanciate User
  Future<entity.User> getUser(userId) async {
    // String url = "http://192.168.1.110:8000/api/users/$userId";
    //!
    String url = "http://192.168.1.110:8000/api/users/13";

    final response = await http.get(url);
    if (response.statusCode != 200) throw Exception;

    final Map<String, dynamic> data = json.decode(response.body);
    entity.User userEntity = entity.User.fromJson(data);
    return userEntity;
  }

}