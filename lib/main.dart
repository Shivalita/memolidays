import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:memolidays/core/home/home.dart';
import 'features/login/view/pages/login_page.dart';


void main() {
  runApp(MyApp());
   SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Motion Tab Bar Sample',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      getPages: [
            GetPage(name: '/', page: () => LoginPage()),
            GetPage(name: '/home', page: () => MyHomePage()),
      ],
    );
  }
}