import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String googleLogo = 'assets/images/google.svg';
    return Scaffold(
      body: souvenirsState.whenRebuilder(
        initState: () => souvenirsState.setState((state) => state.init(context)),
        onIdle: () => Center(
          child: CircularProgressIndicator(strokeWidth: 2)
        ),
        onWaiting: () => Center(
          child: CircularProgressIndicator(strokeWidth: 2)
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
                            "Welcome to Memolidays",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              fontStyle: FontStyle.italic,
                              color: Colors.orange[800]
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Sign in with :",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: (){
                          souvenirsState.setState((state) => state.signInWithGoogle(context));
                        },
                        child: SvgPicture.asset(
                          googleLogo, 
                          height: 35,
                          width: 35
                        ), 
                        backgroundColor: Colors.white, 
                        elevation: 3
                      )
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