import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:memolidays/features/login/data/repositories/login_repository.dart';
import 'package:memolidays/features/login/dependencies.dart';

class LoginPage extends StatelessWidget {
  final loginRepository = LoginRepository();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: loginState.whenRebuilder(
        initState: () => loginState.setState((state) => state.checkConnectivity(context)),
        onIdle: () => CircularProgressIndicator(),
        onWaiting: () => CircularProgressIndicator(),
        onError: (_) => Text('Error'),
        onData: () {
          return Column(
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
                      loginState.setState((state) => state.signInWithGoogle(context));
                    },
                    splashColor: Colors.orange
                  ),
                ),
              ),
            ],
          );
        }
      )
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