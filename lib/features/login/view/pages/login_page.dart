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
            initState: () => loginState.setState((state) => state.init(context)),
            onIdle: () =>
                CircularProgressIndicator(), // ce qu'on affiche à la base
            onWaiting: () =>
                CircularProgressIndicator(), // pendant qu'on attend l'async
            onError: (_) => Text('Error'), // quand y'a une erreur
            onData: () {
              // une fois que c'est fini et que les datas ont changé dans le state
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
                          loginRepository.signInWithGoogle(context);
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



    // return Scaffold(
    //   body: Column(
    //     children: <Widget>[
    //       ClipPath(
    //         clipper: MyClipper(),
    //         child: Container(
    //           height: 430,
    //           decoration: BoxDecoration(color: Colors.orange, boxShadow: [
    //             BoxShadow(color: Colors.black, blurRadius: 7, spreadRadius: 5)
    //           ]),
    //           child: Center(
    //             child: Image(image: AssetImage('assets/images/icon.png'))
    //           ),
    //         ),
    //       ),
    //       Center(
    //         child: Container(
    //           padding: EdgeInsets.all(50),
    //           child: GoogleSignInButton(
    //             onPressed: () {
    //               loginRepository.signInWithGoogle(context);
    //             },
    //             splashColor: Colors.orange
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
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