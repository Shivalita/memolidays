import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:memolidays/features/souvenirs/domain/models/user.dart' as entity;
import 'package:memolidays/features/souvenirs/data/sources/local_source.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:memolidays/features/souvenirs/domain/models/file.dart';

class SouvenirsRemoteSource {

  // Singleton intialization
  SouvenirsRemoteSource._();
  static SouvenirsRemoteSource _cache;
  factory SouvenirsRemoteSource() => _cache ??= SouvenirsRemoteSource._();

  final LocalSource localSource = LocalSource();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn ();

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
    String url = "http://192.168.1.110:8000/api/users?email=$email";
    entity.User userEntity;

    final response = await http.get(url);
    if (response.statusCode != 200) throw Exception;

    final Map<String, dynamic> data = json.decode(response.body);

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
    String url = "http://192.168.1.110:8000/api/users";

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


  // -------------------- GET --------------------

  // Get all user's categories & add an "All" category (for display all souvenirs)
  Future<List<Category>> getAllCategories(int userId) async {
    final String url = "http://192.168.1.110:8000/api/categories?user=$userId";
    final http.Response response = await http.get(url);

    if (response.statusCode != 200) throw Exception;
    List data = json.decode(response.body)['hydra:member'];

    List<Category> categoriesList = data.map((category) => Category.fromJson(category)).toList();

    Category allCategory = Category.all({'id': 0, 'userId': userId, 'name': "All"});
    categoriesList.insert(0, allCategory);

    return categoriesList;
  }


  // Get all user's souvenirs and call get files method for each one
  Future<List<Souvenir>> getAllSouvenirs(int userId) async {
    final String url = "http://192.168.1.110:8000/api/souvenirs?user=$userId";
    final http.Response response = await http.get(url);

    if (response.statusCode != 200) throw Exception;
    List data = json.decode(response.body)['hydra:member'];

    List<Souvenir> souvenirsList = data.map((souvenir) => Souvenir.fromJson(souvenir)).toList();

    for (int i = 0; i < souvenirsList.length; i++) {
      Souvenir souvenir = souvenirsList[i];
      await getSouvenirFiles(souvenir);
    }

    return souvenirsList;
  }


  // Get all souvenir's files and add cover to files list
  Future<List<File>> getSouvenirFiles(Souvenir souvenir) async {
    int souvenirId = souvenir.id;

    final String url = "http://192.168.1.110:8000/api/files?souvenir=$souvenirId";
    final response = await http.get(url);

    if (response.statusCode != 200) throw Exception;
    List data = json.decode(response.body)['hydra:member'];
    
    List<File> filesList = data.map((file) => File.fromJson(file)).toList();

    souvenir.thumbnails = filesList;

    File coverFile = File.fromCover(souvenir.id, souvenir.cover);
    souvenir.thumbnails.insert(0, coverFile);

    return filesList;
  }


  // -------------------- DELETE --------------------

  Future<void> deleteFile(int fileId) async {
    final String url = "http://192.168.1.110:8000/api/files/$fileId";
    final response = await http.delete(url);
    if (response.statusCode != 204) throw Exception;
  }


  Future<void> deleteSouvenir(int souvenirId) async {
    final String url = "http://192.168.1.110:8000/api/souvenirs/$souvenirId";
    final response = await http.delete(url);
    if (response.statusCode != 204) throw Exception;
  }


  // -------------------- UPDATE --------------------

  // Update souvenir and return new souvenir from updated data
  Future<Souvenir> updateSouvenir(int souvenirId, Souvenir newSouvenirData) async {
    String url = "http://192.168.1.110:8000/api/souvenirs/$souvenirId";

    String data = json.encode(newSouvenirData.toJson());

    Map<String,String> headers = {
      'Content-type' : 'application/merge-patch+json;charset=UTF-8', 
    };

    final response = await http.patch(url, body: data, headers: headers);

    if (response.statusCode != 200) throw Exception;

    final Map<String, dynamic> responseJson = json.decode(response.body);

    Souvenir updatedSouvenir = Souvenir.fromJson(responseJson);
    return updatedSouvenir;
  }


}