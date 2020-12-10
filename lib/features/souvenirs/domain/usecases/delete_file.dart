import 'package:memolidays/features/souvenirs/data/repositories/souvenirs_repository.dart';

final SouvenirsRepository repository = SouvenirsRepository();

class DeleteFile {

  Future<void> call(int fileId) async {
    await repository.deleteFile(fileId);
  }
  
}