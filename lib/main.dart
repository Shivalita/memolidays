import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:memolidays/core/home/home.dart';
import 'package:memolidays/features/login/data/sources/local_source.dart';
import 'package:memolidays/features/souvenirs/view/pages/souvenir_page.dart';
import 'package:memolidays/features/souvenirs/view/components/details_photo.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/login/view/pages/login_page.dart';

final LocalSource localSource = LocalSource();

//!
bool checkIfConnected() {
  bool isConnected = false;
  
  if (localSource.getIsConnected() == true) {
    isConnected = true;
  }

  return isConnected;
}

void main() async {
  //! Initialize Hive and open storage box for local data
  await Hive.initFlutter();
  await Hive.openBox('storageBox');

  runApp(MyApp());
   SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  bool isConnected = checkIfConnected();
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
              scaffoldBackgroundColor: Colors.white,
              canvasColor: Colors.transparent,
            ),        
            // If connected yet redirect to homepage, else to loginpage
            home: (isConnected == true) ? MyHomePage() : LoginPage(), // Interface de demarrage. 
            // home: SouvenirPage(), // [Antonin] Pour raccourcir le chargement de l'appli en dev
            debugShowCheckedModeBanner: false,
            getPages: [
              GetPage(name: '/home', page: () => MyHomePage()),
              GetPage(name: '/souvenir', page: () => SouvenirPage()),
              GetPage(name: '/detailsphoto', page: () => DetailsPhoto()),
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