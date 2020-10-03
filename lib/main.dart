import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memolidays/core/home/home.dart';
import 'features/login/view/pages/login_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

   @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print('Error');
        }

        // Once complete, show login page
        if (snapshot.connectionState == ConnectionState.done) {
          
          return GetMaterialApp(
            title: 'Motion Tab Bar Sample',
            theme: ThemeData(
              primarySwatch: Colors.orange,
            ),
            home: LoginPage(),
            debugShowCheckedModeBanner: false,
            getPages: [
              GetPage(name: '/home', page: () => MyHomePage()),
            ],
          );
          
        }

        // Otherwise, show something while waiting for initialization to complete
          print('Loading');

        return Container(width: 0, height: 0);
      },

    );
  }

}