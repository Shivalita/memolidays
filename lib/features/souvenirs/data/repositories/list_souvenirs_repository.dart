//! Handle 
import 'package:memolidays/features/souvenirs/data/sources/list_souvenirs_remote_source.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';

class ListSouvenirsRepository {
  
  final ListSouvenirsRemoteSource repository = ListSouvenirsRemoteSource();

  ListSouvenirsRepository._();
  static ListSouvenirsRepository _cache;
  factory ListSouvenirsRepository() => _cache ??= ListSouvenirsRepository._();

  //! Get user headings list
  Future<List<Category>> getAllHeadings(userId) async {
    final dynamic headings = await repository.getAllHeadings(userId);
    return headings;
  }

}
