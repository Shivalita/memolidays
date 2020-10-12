import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

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
    ]));
  }
}
 rowChips() {
    return Row(
      children: <Widget>[
        chipForRow('Health', Color(0xFFff8a65)),
        chipForRow('Food', Color(0xFF4fc3f7)),
        chipForRow('Lifestyle', Color(0xFF9575cd)),
        chipForRow('Sports', Color(0xFF4db6ac)),
        chipForRow('Nature', Color(0xFF5cda65)),
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