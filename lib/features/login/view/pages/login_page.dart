import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:get/get.dart';
import 'package:memolidays/core/home/home.dart';
import 'package:flushbar/flushbar.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              height: 430,
              decoration: BoxDecoration(color: Colors.orange, boxShadow: [
                BoxShadow(color: Colors.black, blurRadius: 7, spreadRadius: 5)
              ]),
              child: Center(
                child: Image(image: AssetImage('assets/images/icon.png'))
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(50),
              child: GoogleSignInButton(
                onPressed: () {
                  Get.to(MyHomePage());
                  // Flushbar(
                  //   message: "Please check your network connexion and try again.",
                  //   icon: Icon(
                  //     Icons.info_outline,
                  //     size: 28.0,
                  //     color: Colors.white,
                  //     ),
                  //   duration: Duration(seconds: 3),
                  //   margin: EdgeInsets.all(8),
                  //   borderRadius: 8,
                  //   backgroundColor: Colors.red,
                  // )..show(context);
                },
                splashColor: Colors.orange
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height - 150, size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}