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
        onIdle: () => Center(
          child: CircularProgressIndicator()
        ),
        onWaiting: () => Center(
          child: CircularProgressIndicator()
        ),
        onError: (_) => Text('Error'),
        onData: () {
          return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
              minWidth: MediaQuery.of(context).size.width,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.orange[800],
                  Colors.orange
                ],
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
              )
            ),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/1.5,
                  child: Center(
                    child: Image(image: AssetImage('assets/images/icon.png'))
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40) ,
                      topRight: Radius.circular(40),
                    ),
                    boxShadow: [],
                    color: Colors.white
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Center(
                          child: Text(
                            "Welcome",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              fontStyle: FontStyle.italic
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Center(
                          child: GoogleSignInButton(
                            onPressed: () {
                              loginState.setState((state) => state.signInWithGoogle(context));
                            },
                            splashColor: Colors.orange
                        ),
                        )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      )
    );
  }
}