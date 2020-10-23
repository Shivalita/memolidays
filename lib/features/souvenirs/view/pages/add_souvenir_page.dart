//! Affichage de la page d'ajout de souvenir

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/view/components/date_picker.dart';
import 'package:memolidays/features/souvenirs/view/components/input_location.dart';
import 'package:memolidays/features/souvenirs/view/components/input_title.dart';
import 'package:memolidays/features/souvenirs/view/components/more_info.dart';
import 'package:memolidays/features/souvenirs/view/components/tags.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

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

  //! Code Pour La Selection De Photo Via La Gallery Du Telephone
  List<Asset> images = List<Asset>();
  String _error;

  Widget buildGridView() {
    if (images != null)
      return Container(
        child: GridView.count(
          padding: EdgeInsets.all(10),
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          children: List.generate(images.length, (index) {         
            Asset asset = images[index];
            return AssetThumb(
              asset: asset,
              width: 300,
              height: 300,
            );
          }),
        ),
      );
    else 
      return Container(
        color: Colors.red
      );
  }

  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error == null) _error = 'No Error Dectected';
    });
  }

  //! Code Pour La Prise de Photo Via La Camera
  File _image;
  final picker = ImagePicker();

  getImage() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 100);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  
  Widget cameraView() {
    if (_image != null)
      return ClipRRect(
        child: Container(
          child: Align(
            alignment: Alignment.center,
            widthFactor: 0.5,
            heightFactor: 0.5,
            child: Image.file(
              _image,
              height: 230,
              width: 230,
            )
          )
        )
      );
    else
      return Container();
  }

  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: FormBuilder(
          initialValue: {'title': '', 'location' :''},
          key: _fbKey,
          child: Column(
            children: <Widget>[
              Container(
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey,
                )
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () {
                        getImage();
                      },
                      child: Icon(
                        Icons.photo_camera,
                        size: 35,
                      ),
                      elevation: 3,
                      backgroundColor: Colors.white,
                    ),
                    FloatingActionButton(
                      onPressed: 
                        loadAssets,
                      child: Icon(
                        Icons.photo_library,
                        size: 35,
                      ),
                      elevation: 3,
                      backgroundColor: Colors.white,
                    )
                  ],
                ),
              ),
              Stack(
                children: [
                  buildGridView(),
                  cameraView(),
                ],
              ),
              SizedBox(height: 10),
              InputTitle(),
              SizedBox(height: 10),
              InputLocation(),
              SizedBox(height: 10),
              Tags(),
              SizedBox(height: 10),
              DatePicker(),
              SizedBox(height: 10),
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
        ),
      ),
    );
  }
}
