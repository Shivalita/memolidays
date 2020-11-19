import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memolidays/core/home/home.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:memolidays/features/souvenirs/view/components/pop_up_menu.dart';
import 'package:memolidays/features/souvenirs/view/components/souvenir_header.dart';
import 'package:memolidays/features/souvenirs/view/components/masonery_grid.dart';

// ignore: must_be_immutable
class SouvenirPage extends StatelessWidget {
  Souvenir souvenir = souvenirsState.state.selectedSouvenir;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.to(MyHomePage());
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(souvenir.title),
            centerTitle: true,
            actions: [
              IconButton(icon: Icon(Icons.add_a_photo), onPressed: () {}),
              PopUpOptionMenu(),
            ],
          ),
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[SouvenirHeader(), MasoneryGrid()],
              ),
            ),
          )),
    );
  }
}




