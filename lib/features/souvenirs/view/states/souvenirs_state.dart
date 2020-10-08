//! Souvenirs state
import 'package:memolidays/features/login/data/sources/user_storage.dart';
import 'package:memolidays/features/souvenirs/data/repositories/list_souvenirs_repository.dart';

class SouvenirsState {

    init() async {

        final ListSouvenirsRepository repository = ListSouvenirsRepository();
        final UserStorage userStorage = UserStorage();

        final idsMap = userStorage.getUserIds();
        final memolidaysId = idsMap['memolidaysId'];
        print('user storage memolidays id');
        print(memolidaysId);

        repository.getAllHeadings(memolidaysId);

    }

}

