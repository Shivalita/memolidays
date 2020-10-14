import 'package:flutter/material.dart';
import 'package:memolidays/features/souvenirs/view/components/souvenir_header.dart';
import 'package:memolidays/features/souvenirs/view/components/masonery_grid.dart';


class SouvenirPage extends StatefulWidget {
  @override
  _SouvenirPageState createState() => _SouvenirPageState();
}

class _SouvenirPageState extends State<SouvenirPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vacances Rome'),
        centerTitle: true,
      ),
      body: Container(   
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SouvenirHeader(),
              MasoneryGrid()
            ],
          ),
        ),
      )
    );
  }
}
