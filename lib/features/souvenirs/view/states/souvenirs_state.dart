//! Souvenirs state
import 'package:memolidays/features/souvenirs/data/repositories/list_souvenirs_repository.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_souvenirs.dart';

class SouvenirsState {

    init(context) async {

      final ListSouvenirsRepository repository = ListSouvenirsRepository();

      List<Category> categories = await GetSouvenirs()(context);

    }

}

