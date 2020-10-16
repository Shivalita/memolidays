import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';

// ignore: must_be_immutable
class CategoryComponent extends StatelessWidget {

  String chargement = "waiting"; //!

  @override
  Widget build(BuildContext context) {
    return Container(
        // return chargement == "idle" ? Container( //!
          child: Column(
            children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {Get.toNamed('/');},
                    child: rowChips(),
                  )
                ],
              ),
            ),
            ]
          )
        );
      // ])) : //!
      // chargement == "waiting" ?  //!
  }

  Widget rowChips() {
    List<Category> categoriesList = souvenirsState.state.allCategoriesList;
    List<Widget> widgetsList = [];

    categoriesList.forEach((element) {
      widgetsList.add(chipForRow(element.name, Color(0xFF4fc3f7)));
      print(widgetsList);
    });

    return Row(
      // children: widgetsList,
      children: <Widget>[
        chipForRowDisable('Disable', Color(0xFFd3d3d3)),
        chipForRowDisable('Disable', Color(0xFFd3d3d3)),
        chipForRow('Selected', Color(0xFFFF9800)),
        chipForRowDisable('Disable', Color(0xFFd3d3d3)),
        chipForRowDisable('Disable', Color(0xFFd3d3d3)),
      ],
    );
  }

  Widget chipForRow(String label, Color color) {
    return Container(
      margin: EdgeInsets.all(6.0),
      child: Chip(
        labelPadding: EdgeInsets.all(5.0),
        label: Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600
          ),
        ),
        
        backgroundColor: color,
        elevation: 6.0,
        shadowColor: Colors.grey[60],
        padding: EdgeInsets.all(6.0),
      ),
    );
  }

   Widget chipForRowDisable(String label, Color color) {
    return Container(
      margin: EdgeInsets.all(6.0),
      child: Chip(
        labelPadding: EdgeInsets.all(5.0),
        label: Text(
          label,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        
        backgroundColor: color,
        elevation: 3.0,
        shadowColor: Colors.grey[60],
        padding: EdgeInsets.all(6.0),
      ),
    );
  }

}