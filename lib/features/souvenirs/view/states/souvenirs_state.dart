//! Souvenirs state
import 'package:memolidays/features/souvenirs/data/repositories/list_souvenirs_repository.dart';

class SouvenirsState {

    init() async {
        final ListSouvenirsRepository repository = ListSouvenirsRepository();
        repository.getAllHeadings('799');
    }

}

