import 'package:flutter/material.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:memolidays/features/souvenirs/view/components/souvenir_header.dart';
import 'package:memolidays/features/souvenirs/view/components/masonery_grid.dart';
import 'package:get/get.dart';

class SouvenirPage extends StatelessWidget {
  Souvenir souvenir = souvenirsState.state.selectedSouvenir;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(souvenir.title),
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
