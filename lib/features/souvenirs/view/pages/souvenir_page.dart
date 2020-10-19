import 'package:flutter/material.dart';
import 'package:memolidays/features/souvenirs/view/components/souvenir_header.dart';
import 'package:memolidays/features/souvenirs/view/components/masonery_grid.dart';
import 'package:get/get.dart';

class SouvenirPage extends StatefulWidget {
  @override
  _SouvenirPageState createState() => _SouvenirPageState();
}

class _SouvenirPageState extends State<SouvenirPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Vacances Rome'),
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed("/home");
                    },
                    child: Row(
                      children: [
                        Icon(Icons.settings),
                        SizedBox(width: 5),
                        Text("Settings"),
                      ],
                    )
                  ),
                ),
              ]
            )
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[SouvenirHeader(), MasoneryGrid()],
            ),
          ),
        ));
  }
}
