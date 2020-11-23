import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';

class Tags extends StatelessWidget {
  final List<Category> allCategoriesList = souvenirsState.state.allCategoriesList;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: FormBuilderChipsInput(
        attribute: 'categories',
        initialValue: [],
        decoration: InputDecoration(
          hintText: 'Add category',
          filled: true,
          fillColor: Colors.grey[100],
          prefixIcon: Icon(Icons.tag, size: 20),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.black54),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.orange),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(
            left: 16,
            right: 20,
            top: 14,
            bottom: 0,
          ),
        ),
        findSuggestions: (String query) {
          if (query.length != 0) {
            String lowercaseQuery = query.toLowerCase();

            List<Category> suggestions = allCategoriesList.where((category) {
              return category.name.toLowerCase().contains(query.toLowerCase());
            }).toList(growable: false);

            if (suggestions.isEmpty) return <Category>[Category(name: query)];

            suggestions.sort((a, b) => a.name
                .toLowerCase()
                .indexOf(lowercaseQuery)
                .compareTo(b.name.toLowerCase().indexOf(lowercaseQuery)));

            return suggestions;
          } 
          else return <Category>[];
        },
        suggestionBuilder: (context, state, category) {
          return ListTile(
            tileColor: Colors.white,
            key: ObjectKey(category),
            title: Text(category.name),
            onTap: () => state.selectSuggestion(category),
          );
        },
        chipBuilder: (context, state, category) {
          return InputChip(
            key: ObjectKey(category),
            label: Text(category.name),
            onDeleted: () => state.deleteChip(category),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          );
        },
      ),
    );
  }
}