//! Affichage de la page d'ajout de souvenir

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/view/components/date_picker.dart';
import 'package:memolidays/features/souvenirs/view/components/input_location.dart';
import 'package:memolidays/features/souvenirs/view/components/input_title.dart';
import 'package:memolidays/features/souvenirs/view/components/more_info.dart';
import 'package:memolidays/features/souvenirs/view/components/tags.dart';


class AddSouvenirsPage extends StatefulWidget {
  @override
  _AddSouvenirsPageState createState() => _AddSouvenirsPageState();
}

class _AddSouvenirsPageState extends State<AddSouvenirsPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  DateTime pickedDate;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: FormBuilder(
          initialValue: {'title': '', 'location' :''},
          key: _fbKey,
          child: Column(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            new IconButton(
                                iconSize: 40.0,
                                icon: Icon(Icons.camera_enhance,
                                    color: Colors.orange),
                                onPressed: () {}),
                            new Text('Take images',
                                style: TextStyle(fontSize: 15.0)),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            IconButton(
                                iconSize: 40.0,
                                icon: Icon(Icons.photo_library,
                                    color: Colors.orange),
                                onPressed: () {}),
                            new Text('Choose images',
                                style: TextStyle(fontSize: 15.0)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              InputTitle(),
              SizedBox(
                height: 10,
              ),
              InputLocation(),
              SizedBox(
                height: 10,
              ),
              Tags(),
              SizedBox(
                height: 10,
              ),
              DatePicker(),
              SizedBox(
                height: 10,
              ),
              MoreInfo(),
              RaisedButton(
                elevation: 3,
                child: Text('Valider'),
                onPressed: () {
                  souvenirsState.setState((state) => state.getTata()); 
                  if (_fbKey.currentState.saveAndValidate()) {
                    var data = _fbKey.currentState.value;
                  //   print(_fbKey.currentState.value);
                  //   print(_fbKey.currentState.value.runtimeType);
                    print(souvenirsState.state.toto);
                    // souvenirsState.setState((state) => state.addSouvenir(data)); 
                    souvenirsState.setState((state) => state.getTata()); 

                  }
                },
              )
            ],
          ),
        ));
  }
}
