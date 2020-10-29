// import 'package:flutter/material.dart';
// import 'package:material_tag_editor/tag_editor.dart';


// class Tags extends StatefulWidget {
//   Tags({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _TagsState createState() => _TagsState();
// }

// class _TagsState extends State<Tags> {
//   List<String> values = [];

//   onDelete(index) {
//     setState(() {
//       values.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TagEditor(
//               length: values.length,
//               delimeters: [',', ' '],
//               hasAddButton: false,
//               resetTextOnSubmitted: true,
//               onSubmitted: (outstandingValue) {
//                 setState(() {
//                   values.add(outstandingValue);
//                 });
//               },
//               inputDecoration: const InputDecoration(
//                 hintText: 'Add Category',
//                 enabledBorder: const OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.orange,
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.orange),
//                   ),
//                   border: InputBorder.none,
//                   contentPadding: const EdgeInsets.only(
//                     left: 16,
//                     right: 20,
//                     top: 14,
//                     bottom: 14,
//                   ),
//               ),
//               onTagChanged: (newValue) {
//                 setState(() {
//                   values.add(newValue);
//                 });
//               },
//               tagBuilder: (context, index) => _Chip(
//                 index: index,
//                 label: values[index],
//                 onDeleted: onDelete,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _Chip extends StatelessWidget {
//   const _Chip({
//     @required this.label,
//     @required this.onDeleted,
//     @required this.index,
//   });

//   final String label;
//   final ValueChanged<int> onDeleted;
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     return Chip(
//       elevation: 3,
//       backgroundColor: Colors.orange,
//       labelPadding: const EdgeInsets.only(left: 8.0),
//       label: Text(label),
//       deleteIcon: Icon(
//         Icons.close,
//         size: 18,
//       ),
//       onDeleted: () {
//         onDeleted(index);
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';

class Tags extends StatelessWidget {
  final List<Category> allCategoriesList = souvenirsState.state.allCategoriesList;
  // List<String> tagsList = [];

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: FormBuilderChipsInput(
        attribute: 'tags',
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
            var lowercaseQuery = query.toLowerCase();

            List<Category> suggestions = allCategoriesList.where((category) {
              return category.name.toLowerCase().contains(query.toLowerCase());
            }).toList(growable: false);

            print(suggestions);

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