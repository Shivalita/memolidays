import 'package:flutter/material.dart';
import 'package:memolidays/features/souvenirs/view/components/category.dart';
import 'package:memolidays/features/souvenirs/view/components/memories.dart';

class ListSouvenirsPage extends StatefulWidget {
  @override
  _ListSouvenirsPageState createState() => _ListSouvenirsPageState();
}

class _ListSouvenirsPageState extends State<ListSouvenirsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Category(),
          Memories(),
        ],
      ),
      )
    );
  }
}
