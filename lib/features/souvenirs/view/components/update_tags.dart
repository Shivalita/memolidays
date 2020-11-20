import 'package:flutter/material.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';

class UpdateTags extends StatelessWidget {
  Souvenir souvenir = souvenirsState.state.selectedSouvenir;
  List<Category> categoriesList = souvenirsState.state.allCategoriesList;
  List<Category> souvenirCategories = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Row(children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: rowChips(context, categoriesList),
          )
      ])),
      );
  }


  // Create chips for all categories
  Widget rowChips(BuildContext context, List<Category> categoriesList) {
    List<Widget> widgetsList = [];

    souvenirsState.setState((state) => state.temporaryCategoriesId = souvenir.categoriesId);
    List<int> souvenirCategoriesId = souvenirsState.state.temporaryCategoriesId;

    // categoriesList.removeWhere((category) => category.name == 'All');

    categoriesList.forEach((category) {
      bool isSouvenirCategory = souvenirCategoriesId.contains(category.id);

      if (isSouvenirCategory) {
        souvenirCategories.add(category);
      }

      widgetsList.add(chipForRow(context, category));
    });

    return Row(
      children: widgetsList,
    );
  }

  Widget chipForRow(BuildContext context, Category category) {
    return Container(
      margin: EdgeInsets.all(6.0),
      child: Material(
        child: Row(
          children: <Widget>[
            (souvenirCategories.contains(category)) ? 
            GestureDetector(
              // OnTap selects related category & displays highlighted chip for selected category
              onTap: () => souvenirsState.setState((state) => state.updateSouvenirCategory(souvenir, category)),
              child: Chip(
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
            ) 
            : GestureDetector(
              // OnTap selects related category & displays highlighted chip for selected category
              onTap: () => souvenirsState.setState((state) => state.updateSouvenirCategory(souvenir, category)),
              child: Chip(
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
      )  
    );
  }

}