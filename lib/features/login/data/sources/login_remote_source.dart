import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:memolidays/features/login/domain/models/user.dart' as entity;
import 'package:http/http.dart' as http;
import 'package:memolidays/features/login/data/sources/local_source.dart';

class LoginRemoteSource {

  final LocalSource localSource = LocalSource();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn ();

  LoginRemoteSource._();
  static LoginRemoteSource _cache;
  factory LoginRemoteSource() => _cache ??= LoginRemoteSource._();

  entity.User userEntity;
  int userId;
  Map<String, dynamic> userData;

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
      print('userData POST = $userData');  
      entity.User userEntity = entity.User.fromJson(userData);
      print('userEntity.id = ${userEntity.id}');
      return userEntity;
    }

    catch (error) {
      print('ERROR : ');
      print(error);
      throw Exception();
    }

  }

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
    print('POST statusCode = ${response.statusCode}');
    if (response.statusCode != 201) throw Exception;

    final Map<String, dynamic> responseJson = json.decode(response.body);
    print('responseJson POST = $responseJson');
    return responseJson;
  }

  Future<String> signOutGoogle() async {
    await googleSignIn.signOut();
    return 'User disconnected';
  }

  Future<entity.User> getUser(userId) async {
    String url = "http://192.168.1.110:8000/api/users/$userId";

    final response = await http.get(url);
    print('GET statusCode = ${response.statusCode}');
    if (response.statusCode != 200) throw Exception;

    final Map<String, dynamic> responseJson = json.decode(response.body);
    print('responseJson GET = $responseJson');
    entity.User userEntity = entity.User.fromJson(responseJson);
    print('userEntity id GET = ${userEntity.id}');   
    return userEntity;
  }

}