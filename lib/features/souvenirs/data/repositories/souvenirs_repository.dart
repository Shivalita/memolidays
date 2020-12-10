import 'package:memolidays/features/souvenirs/data/sources/local_source.dart';
import 'package:memolidays/features/souvenirs/data/sources/souvenirs_remote_source.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:memolidays/features/souvenirs/domain/models/user.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';


class SouvenirsRepository {
  
  // Singleton initialization
  SouvenirsRepository._();
  static SouvenirsRepository _cache;
  factory SouvenirsRepository() => _cache ??= SouvenirsRepository._();

  final SouvenirsRemoteSource souvenirsRemoteSource = SouvenirsRemoteSource();
  final LocalSource localSource = LocalSource();

  User user;


  // If connected get user from local storage, else call login method & set isConnected to true
  Future<User> login() async {
    bool isConnected = localSource.getIsConnected();

    if (isConnected != null && isConnected == true) {
      user = getUserFromLocalStorage();

    } else {
      user = await souvenirsRemoteSource.login();
      localSource.storeUserData(user.id, user.googleId, user.name, user.email, user.avatar, user.isPremium);
    }

    localSource.setIsConnected(true);
    return user;
  }


  // Instanciate user from data stored in local storage
  User getUserFromLocalStorage() {
    Map<String, dynamic> userData = localSource.getUserData();
    user = User.fromLocal(userData);
    return user;
  }


  // Call Google logout method, set isConnected to false & clear state categories list 
  Future<void> signOutGoogle() async {
    await souvenirsRemoteSource.signOutGoogle();
    localSource.setIsConnected(false);
    souvenirsState.setState((state) => state.allCategoriesList = null); 
  }


  // -------------------- GET --------------------

  // Get userId from local storage
  int getUserId() {
    final int userId = localSource.getUserId();
    return userId;
  }


  Future<List<Category>> getAllCategories() async {
    final int userId = getUserId();
    final List<Category> categoriesList = await souvenirsRemoteSource.getAllCategories(userId);
    return categoriesList;
  }


  Future<List<Souvenir>> getAllSouvenirs() async {
    final int userId = getUserId();
    final List<Souvenir> souvenirsList = await souvenirsRemoteSource.getAllSouvenirs(userId);
    return souvenirsList;
  }


  // -------------------- DELETE --------------------

  Future<void> deleteFile(int fileId) async {
    await souvenirsRemoteSource.deleteFile(fileId);
  }


  Future<void> deleteSouvenir(int souvenirId) async {
    await souvenirsRemoteSource.deleteSouvenir(souvenirId);
  }


  // -------------------- UPDATE --------------------

  Future<Souvenir> updateSouvenir(int souvenirId, Souvenir newSouvenirData) async {
    Souvenir updatedSouvenir = await souvenirsRemoteSource.updateSouvenir(souvenirId, newSouvenirData);
    return updatedSouvenir;
  }

}
