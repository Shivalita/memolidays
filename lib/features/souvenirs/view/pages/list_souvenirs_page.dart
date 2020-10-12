import 'package:flutter/material.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/view/components/category.dart';
import 'package:memolidays/features/souvenirs/view/components/memories.dart';

class ListSouvenirsPage extends StatefulWidget {
  @override
  _ListSouvenirsPageState createState() => _ListSouvenirsPageState();
}

class _ListSouvenirsPageState extends State<ListSouvenirsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: souvenirsState.whenRebuilder(
        //! Check connectivity on application launch 
        initState: () => souvenirsState.setState((state) => state.init(context)),
        onIdle: () =>
            CircularProgressIndicator(),
        onWaiting: () =>
            CircularProgressIndicator(),
        onError: (error) => Text(error.toString()),
        onData: () {
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
      )
    );
  }
}
