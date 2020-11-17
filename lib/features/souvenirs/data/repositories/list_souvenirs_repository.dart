import 'package:memolidays/features/login/data/sources/local_source.dart';
import 'package:memolidays/features/souvenirs/data/sources/list_souvenirs_remote_source.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';

class ListSouvenirsRepository {
  
  final ListSouvenirsRemoteSource listSouvenirsRemoteSource = ListSouvenirsRemoteSource();
  final LocalSource localSource = LocalSource();
  
  ListSouvenirsRepository._();
  static ListSouvenirsRepository _cache;
  factory ListSouvenirsRepository() => _cache ??= ListSouvenirsRepository._();

  int getUserId() {
    final int userId = localSource.getUserId();
    return userId;
  }

  Future<List<Category>> getAllCategories() async {
    // final int userId = getUserId();
    final int userId = 13;
    final List<Category> categoriesList = await listSouvenirsRemoteSource.getAllCategories(userId);
    return categoriesList;
  }

  Future<List<Souvenir>> getAllSouvenirs() async {
    // final int userId = getUserId();
    final int userId = 13;
    final List<Souvenir> souvenirsList = await listSouvenirsRemoteSource.getAllSouvenirs(userId);
    return souvenirsList;
  }

}
