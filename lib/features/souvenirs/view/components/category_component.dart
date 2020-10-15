import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memolidays/features/login/data/sources/local_source.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';

class CategoryComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: rowChips(),
        )
      ]),
    );
  }

  Widget rowChips() {
    List<Category> categoriesList = souvenirsState.state.allCategoriesList;
    List<Widget> widgetsList = [chipForRow(1, 'All')];

    categoriesList.forEach((element) {
      widgetsList.add(chipForRow(element.id, element.name));
    });

    return Row(
      children: widgetsList,
    );
  }

  Widget chipForRow(int id, String label) {
    bool isSelected = ((souvenirsState.state.selectedCategoryId != 0) && (souvenirsState.state.selectedCategoryId == id));

    return Container(
      margin: EdgeInsets.all(6.0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => selectCategory(id),
            child: isSelected ? Chip(
              labelPadding: EdgeInsets.all(5.0),
              label: Text(
                label,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600
                ),
              ),
          
              backgroundColor: Color(0xFFFF9800),
              elevation: 6.0,
              shadowColor: Colors.grey[60],
              padding: EdgeInsets.all(6.0),
            ) 
            : Chip(
              labelPadding: EdgeInsets.all(5.0),
              label: Text(
                label,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              
              backgroundColor: Color(0xFFd3d3d3),
              elevation: 3.0,
              shadowColor: Colors.grey[60],
              padding: EdgeInsets.all(6.0),
            ),
          ),
        ]
      )  
    ); 
  }

  selectCategory(int categoryId) async {
    if (souvenirsState.state.selectedCategoryId != categoryId) {
      souvenirsState.setState((state) => state.selectedCategoryId = categoryId);
      print(souvenirsState.state.selectedCategoryId);
    }
  }

}