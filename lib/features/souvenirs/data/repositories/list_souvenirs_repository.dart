import 'package:memolidays/features/login/data/sources/local_source.dart';
import 'package:memolidays/features/souvenirs/data/sources/list_souvenirs_remote_source.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';

class ListSouvenirsRepository {
  
  final ListSouvenirsRemoteSource listSouvenirsRemoteSource = ListSouvenirsRemoteSource();
  
  ListSouvenirsRepository._();
  static ListSouvenirsRepository _cache;
  factory ListSouvenirsRepository() => _cache ??= ListSouvenirsRepository._();

  int getMemolidaysId() {
    final LocalSource localSource = LocalSource();
    final Map<String, dynamic> idsMap = localSource.getUserIds();
    final int memolidaysId = idsMap['memolidaysId'];
    return memolidaysId;
  }

  Future<List<Category>> getCategoriesList() async {
    final int userId = getMemolidaysId();
    final List<Category> categoriesList = await listSouvenirsRemoteSource.getCategoriesList(userId);
    return categoriesList;
  }

  Future<List<Souvenir>> getSouvenirsByCategory(int categoryId, int userId) async {
    final int userId = getMemolidaysId();
    final List<Souvenir> souvenirsList = await listSouvenirsRemoteSource.getSouvenirsByCategory(categoryId, userId);
    return souvenirsList;
  }

  Future<List<List<Souvenir>>> getAllSouvenirsList() async {
    final int userId = getMemolidaysId();
    final List<List<Souvenir>> allSouvenirsList = await listSouvenirsRemoteSource.getAllSouvenirsList(userId);
    return allSouvenirsList;
  }

}
