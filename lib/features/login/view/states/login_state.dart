import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memolidays/core/home/home.dart';
import 'package:memolidays/features/login/data/sources/local_source.dart';
import 'package:memolidays/features/login/domain/models/user.dart';
import 'package:memolidays/features/login/domain/usecases/login.dart';
import 'package:memolidays/features/login/domain/usecases/logout.dart';
import 'package:memolidays/features/login/view/pages/login_page.dart';
import 'package:memolidays/core/components/error_snackbar.dart';


class LoginState {

  bool hasConnectivity;
  bool isConnected;
  final LocalSource localSource = LocalSource();

  // On login page built, check connectivity 
  init(BuildContext context) async {
    await checkConnectivity(context);
  }


  // Check device connectivity
  Future<void> checkConnectivity(BuildContext context) async {
    bool hasConnection = await DataConnectionChecker().hasConnection;

    if (!hasConnection == true) {
      print('Connectivity error. Exception : ${DataConnectionChecker().lastTryResults}');
      hasConnectivity = false;
      final ErrorSnackbar errorSnackbar = ErrorSnackbar(context, 'Error : Please check your device connectivity.');
      errorSnackbar.displayErrorSnackbar();

    } else {
      hasConnectivity = true;
    }
  }


  // If has connectivity, login and redirect to home page
  Future<void> signInWithGoogle(BuildContext context) async {
    if (hasConnectivity) {
      try {
        User user = await Login()();    

        if (user != null) {
          isConnected = true;
          return Get.to(MyHomePage());
        }
      }

      on Exception {
        print('PPL exception signInGoogle login_state');
        final ErrorSnackbar errorSnackbar = ErrorSnackbar(context, 'Error : Authentication failed.');
        errorSnackbar.displayErrorSnackbar();
      }
    }

  }

  // Logout and redirect to login page
  Future<void> signOutGoogle(BuildContext context) async {
    try {
      await Logout()();
      isConnected = false;
    }

    on Exception {
      final ErrorSnackbar errorSnackbar = ErrorSnackbar(context, 'Error : Please try again.');
      errorSnackbar.displayErrorSnackbar();
    }
    
    return Get.to(LoginPage());
  }

}