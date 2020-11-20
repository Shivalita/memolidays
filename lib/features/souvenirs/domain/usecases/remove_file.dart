import 'package:memolidays/features/souvenirs/data/repositories/list_souvenirs_repository.dart';

final ListSouvenirsRepository repository = ListSouvenirsRepository();

class RemoveFile {

  Future<void> call(int fileId) async {
    await repository.removeFile(fileId);
  }
  
}