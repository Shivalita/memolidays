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
          child: rowChips(),
        )
      ]),
    );
  }

  Widget rowChips() {
    List<Category> categoriesList = souvenirsState.state.allCategoriesList;
    Category allCategory = Category(id: 0, name: 'All');
    List<Widget> widgetsList = [chipForRow(allCategory)];

    categoriesList.forEach((category) {
      widgetsList.add(chipForRow(category));
    });

    return Row(
      children: widgetsList,
    );
  }

  Widget chipForRow(Category category) {
    bool isSelected = ((souvenirsState.state.selectedCategory != null) && (souvenirsState.state.selectedCategory.id == category.id));

    return Container(
      margin: EdgeInsets.all(6.0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => selectCategory(category),
            child: isSelected ? Chip(
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
            : Chip(
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

  selectCategory(Category category) async {
    if ((category.id != 0) || (souvenirsState.state.selectedCategory.id != category.id)) { //! setState even if selects the same category
      souvenirsState.setState((state) => state.selectedCategory = category);
      print(souvenirsState.state.selectedCategory.id);
    }
  }

}