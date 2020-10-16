import 'package:memolidays/features/login/data/sources/local_source.dart';
import 'package:memolidays/features/souvenirs/data/sources/list_souvenirs_remote_source.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';

class ListSouvenirsRepository {
  
  final ListSouvenirsRemoteSource listSouvenirsRemoteSource = ListSouvenirsRemoteSource();
  final LocalSource localSource = LocalSource();
  
  ListSouvenirsRepository._();
  static ListSouvenirsRepository _cache;
  factory ListSouvenirsRepository() => _cache ??= ListSouvenirsRepository._();

  int getMemolidaysId() {
    final Map<String, dynamic> idsMap = localSource.getUserIds();
    final int memolidaysId = idsMap['memolidaysId'];
    return memolidaysId;
  }

  Future<List<Category>> getCategoriesList() async {
    final int userId = getMemolidaysId();
    final List<Category> categoriesList = await listSouvenirsRemoteSource.getCategoriesList(userId);
    return categoriesList;
  }

}
