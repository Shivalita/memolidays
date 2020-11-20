import 'package:memolidays/features/login/data/sources/local_source.dart';
import 'package:memolidays/features/souvenirs/data/sources/list_souvenirs_remote_source.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';

class ListSouvenirsRepository {
  
  final ListSouvenirsRemoteSource listSouvenirsRemoteSource = ListSouvenirsRemoteSource();
  final LocalSource localSource = LocalSource();
  
  // Singleton initialization
  ListSouvenirsRepository._();
  static ListSouvenirsRepository _cache;
  factory ListSouvenirsRepository() => _cache ??= ListSouvenirsRepository._();

  // -------------------- GET --------------------

  // Get userId from local storage
  int getUserId() {
    final int userId = localSource.getUserId();
    return userId;
  }


  Future<List<Category>> getAllCategories() async {
    final int userId = getUserId();
    final List<Category> categoriesList = await listSouvenirsRemoteSource.getAllCategories(userId);
    return categoriesList;
  }


  Future<List<Souvenir>> getAllSouvenirs() async {
    final int userId = getUserId();
    final List<Souvenir> souvenirsList = await listSouvenirsRemoteSource.getAllSouvenirs(userId);
    return souvenirsList;
  }


  // -------------------- DELETE --------------------

  Future<void> removeFile(int fileId) async {
    await listSouvenirsRemoteSource.removeFile(fileId);
  }


  Future<void> removeSouvenir(int souvenirId) async {
    await listSouvenirsRemoteSource.removeSouvenir(souvenirId);
  }


  // -------------------- UPDATE --------------------

  // Future<void> updateSouvenir(int souvenirId, Map<String, dynamic> data) async {
  //   await listSouvenirsRemoteSource.updateSouvenir(souvenirId, data);
  Future<Souvenir> updateSouvenir(int souvenirId, Souvenir newSouvenirData) async {
    Souvenir updatedSouvenir = await listSouvenirsRemoteSource.updateSouvenir(souvenirId, newSouvenirData);
    return updatedSouvenir;
  }

}
