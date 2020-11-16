import 'package:flutter/material.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/view/components/category_component.dart';
import 'package:memolidays/features/souvenirs/view/components/memories_component.dart';

class ListSouvenirsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: souvenirsState.whenRebuilder(
        initState: () => souvenirsState.setState((state) async => await state.init(context)),
        onIdle: () => Center(child: SizedBox(child: CircularProgressIndicator(strokeWidth: 2))),
        onWaiting: () => Center(child: SizedBox(child: CircularProgressIndicator(strokeWidth: 2))),
        onError: (error) {
          throw error;
        },
        onData: () {
          return Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  // CategoryComponent(),
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
