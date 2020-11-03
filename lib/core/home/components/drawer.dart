import 'package:flutter/material.dart';
import 'package:memolidays/features/login/data/sources/local_source.dart';
import 'package:memolidays/features/login/dependencies.dart';

class MyDrawer extends StatelessWidget {
  LocalSource localSource = LocalSource();
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        canvasColor: Colors.white
      ),
      child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.orange,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 20, bottom: 5),
                      decoration: BoxDecoration(
                        boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 3),
                          blurRadius: 5.0,
                        ),
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                              localSource.getgooglePicture()),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Text(
                      localSource.getgoogleName(),
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    Text(
                      localSource.getIsPremium() ? "Premium" : "Free",
                      style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ),
            CustomListTile(Icons.person, Colors.orange , 'Profile', () {}),
            CustomListTile(Icons.settings, Colors.green , 'Settings', () {}),
            CustomListTile(Icons.exit_to_app, Colors.red , 'Disconnect', () {
              loginState.setState((state) => state.signOutGoogle(context));
            }),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomListTile extends StatelessWidget {
  IconData icon;
  Color color;
  String text;
  Function onTap;

  CustomListTile(this.icon,this.color, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 30,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            fontSize: 15),
      )
    );
  }
}