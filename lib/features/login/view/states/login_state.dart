//! Connection state
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get/get.dart';
import 'package:memolidays/core/components/exceptions/connectivity_exception.dart';
import 'package:memolidays/core/home/home.dart';
import 'package:memolidays/features/login/domain/models/user.dart';
import 'package:memolidays/features/login/domain/usecases/login.dart';
import 'package:memolidays/features/login/domain/usecases/logout.dart';
import 'package:memolidays/features/login/view/pages/login_page.dart';

class LoginState {

  bool hasConnectivity;
  bool isConnected;

  init() async {

  }

  Future<void> checkConnectivity(context) async {

    //! Handle connectivity error
    bool hasConnection = await DataConnectionChecker().hasConnection;

    if (!hasConnection == true) {

      print('ERROR: No connectivity. Exception :');
      print(DataConnectionChecker().lastTryResults);

      hasConnectivity = false;
      print('connectivity = false');

      final ConnectivityException connectivityException = ConnectivityException(context);
      connectivityException.displayError();

    } else {
      hasConnectivity = true;
      print('connectivity = true');
    }

  }

  Future<void> signInWithGoogle(context) async {

    await checkConnectivity(context);
    print("STATE :");
    print(hasConnectivity);

    if (hasConnectivity == true) {
      User user = await Login()(context);

      if (user != null) {
        isConnected = true;
        print('connected = true');
        return Get.to(MyHomePage());
      }
    }

  }

  Future<void> signOutGoogle(context) async {

    if (!isConnected == true) print('Not connected to Google.');
    
    String disconnectionMessage = await Logout()(context);
    print(disconnectionMessage);

    isConnected = false;

    return Get.to(LoginPage());

  }


}