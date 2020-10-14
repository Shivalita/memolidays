import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
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

  Future<void> checkConnectivity(BuildContext context) async {
    bool hasConnection = await DataConnectionChecker().hasConnection;

    if (!hasConnection == true) {
      print('ERROR: No connectivity. Exception :');
      print(DataConnectionChecker().lastTryResults);

      hasConnectivity = false;
      final ConnectivityException connectivityException = ConnectivityException(context);
      connectivityException.displayError();

    } else {
      hasConnectivity = true;
      print('Connectivity ok');
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    await checkConnectivity(context);

    if (hasConnectivity == true) {
      User user = await Login()(context);

      if (user != null) {
        isConnected = true;
        print('User connected');
        return Get.to(MyHomePage());
      }
    }
  }

  Future<void> signOutGoogle(BuildContext context) async {
    if (!isConnected == true) print('Not connected to Google anyway.');

    String disconnectionMessage = await Logout()(context);
    print(disconnectionMessage);
    isConnected = false;
    
    return Get.to(LoginPage());
  }

}