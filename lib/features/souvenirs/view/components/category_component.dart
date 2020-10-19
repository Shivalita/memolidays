import 'package:flutter/material.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';

class CategoryComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: rowChips(context),
        )
      ]),
    );
  }

  Widget rowChips(BuildContext context) {
    List<Category> categoriesList = souvenirsState.state.allCategoriesList;
    Category allCategories = Category(id: 0, name: 'All');
    List<Widget> widgetsList = [chipForRow(context, allCategories)];

    if (souvenirsState.state.selectedCategory == null) {
      souvenirsState.setState((state) => state.selectCategory(context, allCategories)); 
    }

    categoriesList.forEach((category) {
      widgetsList.add(chipForRow(context, category));
    });

    return Row(
      children: widgetsList,
    );
  }

  Widget chipForRow(BuildContext context, Category category) {
    return Container(
      margin: EdgeInsets.all(6.0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => souvenirsState.setState((state) => state.selectCategory(context, category)),
            child: ((souvenirsState.state.selectedCategory != null) && (souvenirsState.state.selectedCategory.id == category.id)) ? 
            Chip(
              labelPadding: EdgeInsets.all(5.0),
              label: Text(
                category.name,
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
            : 
            Chip(
              labelPadding: EdgeInsets.all(5.0),
              label: Text(
                category.name,
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

}