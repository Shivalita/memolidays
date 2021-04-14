import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/view/components/date_picker.dart';
import 'package:memolidays/features/souvenirs/view/components/input.dart';
import 'package:memolidays/features/souvenirs/view/components/location_input.dart';
import 'package:memolidays/features/souvenirs/view/components/more_info.dart';
import 'package:memolidays/features/souvenirs/view/components/tags.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class AddSouvenirsPage extends StatefulWidget {
  @override
  _AddSouvenirsPageState createState() => _AddSouvenirsPageState();
}

class _AddSouvenirsPageState extends State<AddSouvenirsPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;

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
    if (images.isNotEmpty)
      return Container(
        child: GridView.count(
          padding: EdgeInsets.all(10),
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          shrinkWrap: true,
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
      return Container(color: Colors.red);
  }

  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList = List<Asset>();
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return Container();

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
                  ))));
    else
      return Container();
  }

  @override
  Widget build(BuildContext context) {
    return souvenirsState.rebuilder(() => Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: FormBuilder(
              key: _fbKey,
              child: Column(
                children: <Widget>[
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
                          onPressed: loadAssets,
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
                  LocationInput(_fbKey),
                  SizedBox(height: 10),
                  Input('Title', Icon(Icons.title_rounded, size: 20)),
                  SizedBox(height: 10),
                  // Input('Location', Icon(Icons.public, size: 20)),
                  Tags(),
                  SizedBox(height: 10),
                  DatePicker(),
                  SizedBox(height: 10),
                  // MoreInfo(),
                  Input('Comment', Icon(Icons.comment, size: 20)),
                  SizedBox(height: 10),
                  Input('Phone', Icon(Icons.phone, size: 20)),
                  SizedBox(height: 10),
                  Input('Email', Icon(Icons.mail, size: 20)),
                  SizedBox(height: 10),


                  // RaisedButton(
                  //   elevation: 3,
                  //   child: Text('Valider'),
                  //   onPressed: () {
                  //     if (_fbKey.currentState.saveAndValidate()) {
                  //       var data = _fbKey.currentState.value;
                  //       print('data = $data');
                  //       souvenirsState
                  //           .setState((state) => state.addSouvenir(data));
                  //     }
                  //   },
                  // ),
                  SizedBox(height: 10),
                  buildTextWithIcon(),
                  SizedBox(height: 40)
                ],
              ),
            ),
          ),
        ));
  }



  Widget buildTextWithIcon() {
    return ProgressButton.icon(iconedButtons: {
      ButtonState.idle: IconedButton(
          text: "Confirm",
          icon: Icon(Icons.check, color: Colors.white),
          color: Colors.orange),
      ButtonState.loading: IconedButton(text: "Loading", color: Colors.white),
      ButtonState.fail: IconedButton(
          text: "Failed",
          icon: Icon(Icons.cancel, color: Colors.white),
          color: Colors.red),
      ButtonState.success: IconedButton(
          text: "Success",
          icon: Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          color: Colors.green)
    }, onPressed: onPressedIconWithText, state: stateTextWithIcon);

    
  }

  void onPressedIconWithText() {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIcon = ButtonState.loading;
              Future.delayed(Duration(milliseconds : 500), () {

          setState(() {
            // If form is validated, call add souvenir method
            if (_fbKey.currentState.saveAndValidate() && souvenirsState.state.isSetInputLocation) {
                Map<String, dynamic> data = _fbKey.currentState.value;
                stateTextWithIcon = ButtonState.success;
                Future.delayed(Duration(milliseconds : 1000), () {
                  souvenirsState.setState((state) async => await state.addSouvenir(context, data));
                });
            } else {
              stateTextWithIcon = ButtonState.fail;
            }
              });
        });
        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIcon = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateTextWithIcon = ButtonState.idle;
        break;
    }
    setState(() {
      stateTextWithIcon = stateTextWithIcon;
    });
  }
}
