import 'package:flutter/material.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';

// ignore: must_be_immutable
class CategoryComponent extends StatelessWidget {
  bool isAnyCategory;
  List<Category> categoriesList = souvenirsState.state.allCategoriesList;

  @override
  Widget build(BuildContext context) {
    if (categoriesList == null) {
      isAnyCategory = false;
      print('isAnyCategory = $isAnyCategory');
    } else {
      isAnyCategory = true;
      print('isAnyCategory = $isAnyCategory');
    }

    return isAnyCategory ? Container(
      child: Column(children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: rowChips(context, categoriesList),
        )
      ]),
    ) : Container();
  }

  Widget rowChips(BuildContext context, List<Category> categoriesList) {
    List<Widget> widgetsList;
    Category allCategories = Category(id: 0, name: 'All');
    widgetsList = [chipForRow(context, allCategories)];

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
              label: SizedBox(
                width: 80,
                child: Text(
                  category.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600
                  ),
                  textAlign: TextAlign.center,
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
              label: SizedBox(
                width: 80,
                child: Text(
                  category.name,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
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