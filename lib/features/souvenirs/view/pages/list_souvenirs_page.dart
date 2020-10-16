import 'package:flutter/material.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/view/components/category_component.dart';
import 'package:memolidays/features/souvenirs/view/components/memories_component.dart';

class ListSouvenirsPage extends StatefulWidget {
  @override
  _ListSouvenirsPageState createState() => _ListSouvenirsPageState();
}

class _ListSouvenirsPageState extends State<ListSouvenirsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: souvenirsState.whenRebuilder(
        initState: () => souvenirsState.setState((state) async => await state.init(context)),
        onIdle: () => CircularProgressIndicator(),
        onWaiting: () => CircularProgressIndicator(),
        onError: (error) => Text(error.toString()),
        onData: () {
          return Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CategoryComponent(),
                  MemoriesComponent(),
                ],
              ),
            )
          );
        }
      )
    );
  }
}
