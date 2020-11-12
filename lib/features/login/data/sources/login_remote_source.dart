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

      //!
      int userId;
      dynamic isConnected = localSource.getIsConnected();
      print('isConnected = $isConnected');
      if (isConnected == null) {
        Map<String, dynamic> userData = await createUser(user);
        print('userData = $userData');
        userId = userData['id'];
        print('userId = $userId');
      }

      // final dynamic memolidaysUser = await getMemolidaysUser();
      // final int memolidaysUserId = memolidaysUser['data'][0]['id'];

      userEntity = entity.User(userId, user.uid, user.displayName, user.email, user.photoURL.toString());
      print('userEntity.id = ${userEntity.id}');
      print('userEntity.name = ${userEntity.name}');
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
      'Content-type' : 'application/json', 
      'Accept': 'application/json',
    };

    final response = await http.post(url, body: data, headers: headers);
    
    final Map<String, dynamic> responseJson = json.decode(response.body);
    print('responseJson = $responseJson');
    return responseJson;
  }

  Future<dynamic> getUser() {

  }

  Future<String> signOutGoogle() async {
    await googleSignIn.signOut();
    return 'User disconnected';
  }

  // Future<dynamic> getMemolidaysUser() async {
  //   final String api = "http://94.23.11.60:8081/memoservices/api/v2/";
  //   final String link = '${api}user/find';
    
  //   final dynamic request = await http.post(
  //     link,
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       // "email": "00708valentin@gmail.com",
  //       // "user": "899",

  //       "email": "avon.antonin@gmail.com",
  //       "user": "906",

  //     }),
  //   ); 

  //   if (request.statusCode != 200) throw Exception;

  //   final Map<String, dynamic> userData = jsonDecode(request.body);

  //   return userData;
  // }
  
}