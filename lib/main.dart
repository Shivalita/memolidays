// import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:memolidays/core/home/home.dart';
import 'package:memolidays/features/login/data/sources/local_source.dart';
import 'package:memolidays/features/souvenirs/view/pages/souvenir_page.dart';
import 'package:memolidays/features/souvenirs/view/components/details_photo.dart';
import 'features/login/view/pages/login_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import "package:flutter/foundation.dart";

final LocalSource localSource = LocalSource();

//! Set this flag to FALSE for production
bool isDevelopmentMode = false;

bool checkIfConnected() {
  bool isConnected = false;

  if (!isDevelopmentMode) {
    if (localSource.getIsConnected() == true) {
      isConnected = true;
    }
  }

  return isConnected;
}

void main() async {
  // Initialize Hive and open storage box for local data
  await Hive.initFlutter();
  await Hive.openBox('storageBox');

  // await DotEnv().load('.env');
  await DotEnv.load(fileName: ".env");

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
      // Initialize FlutterFire (connection to Firebase)
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Error');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            title: 'Motion Tab Bar Sample',
            theme: ThemeData(
              primarySwatch: Colors.orange,
              scaffoldBackgroundColor: Colors.white,
              canvasColor: Colors.transparent,
            ),
            // If connected yet redirect to home page, else to login page
            home: (isConnected == true) ? MyHomePage() : LoginPage(),
            debugShowCheckedModeBanner: false,
            getPages: [
              GetPage(name: '/home', page: () => MyHomePage()),
              GetPage(name: '/souvenir', page: () => SouvenirPage()),
              GetPage(name: '/detailsphoto', page: () => DetailsPhoto()),
            ],
          );
        }

        return Container(width: 0, height: 0);
      },
    );
  }
}
