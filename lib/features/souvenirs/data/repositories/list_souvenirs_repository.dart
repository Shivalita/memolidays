//! Handle 
import 'package:memolidays/features/login/data/sources/local_source.dart';
import 'package:memolidays/features/souvenirs/data/sources/list_souvenirs_remote_source.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';

class ListSouvenirsRepository {
  
  final ListSouvenirsRemoteSource listSouvenirsRemoteSource = ListSouvenirsRemoteSource();

  ListSouvenirsRepository._();
  static ListSouvenirsRepository _cache;
  factory ListSouvenirsRepository() => _cache ??= ListSouvenirsRepository._();

  //! Get user headings list
  Future<List<Category>> getCategoriesList() async {

    //! Get user memolidays id
    final LocalSource localSource = LocalSource();
    final Map<String, String> idsMap = localSource.getUserIds();
    final String memolidaysId = idsMap['memolidaysId'];

    final dynamic headings = await listSouvenirsRemoteSource.getCategoriesList(memolidaysId);
    final headingId = headings[1].id;

    var souvenirs = listSouvenirsRemoteSource.getSouvenirsByHeading(headingId, memolidaysId);


    return headings;

  }

  // Future getSouvenirsByHeading() async {

  //   var souvenirs = listSouvenirsRemoteSource.getSouvenirsByHeading(headingId, memolidaysId);
  //   return souvenirs;

  // }

}
