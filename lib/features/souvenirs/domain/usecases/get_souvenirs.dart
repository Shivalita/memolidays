//! 
import 'package:memolidays/core/usecase.dart';
import 'package:memolidays/features/souvenirs/data/repositories/list_souvenirs_repository.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';

class GetSouvenirs implements Usecase {

  final ListSouvenirsRepository repository = ListSouvenirsRepository();

    @override
    Future<List<Category>> call(context) async {
    List<Category> categories = await repository.getAllHeadings('799');

    return categories;
    
  }

    // //! If User received from remote source, return User
    // try {

    //   final User user = await repository.signInWithGoogle(context);
    //   return user;
    // } 

    // //! If connectivity exception thrown, display connectivity error snackbar
    // on ConnectivityException {
    //   print('ERROR : No connectivity. Exception :');
    //   final ConnectivityException connectivityException = ConnectivityException(context);
    //   connectivityException.displayError();
    // }
  
}