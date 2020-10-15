import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';

class CategoryComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
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
      ])
    );
  }

  Widget rowChips() {
    List<Category> categoriesList = souvenirsState.state.allCategoriesList;
    List<Widget> widgetsList = [];

    categoriesList.forEach((element) {
      widgetsList.add(chipForRow(element.name, Color(0xFF4fc3f7)));
    });

    return Row(
      children: widgetsList,
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
            color: Colors.white,
          ),
        ),
        
        backgroundColor: color,
        elevation: 6.0,
        shadowColor: Colors.grey[60],
        padding: EdgeInsets.all(6.0),
      ),
    );
  }

}