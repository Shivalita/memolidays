import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/view/components/date_picker.dart';
import 'package:memolidays/features/souvenirs/view/components/input.dart';
import 'package:memolidays/features/souvenirs/view/components/location_input.dart';
import 'package:memolidays/features/souvenirs/view/components/tags.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AddSouvenirsPage extends StatefulWidget {
  AddSouvenirsPage(this.changeScreen, {Key key}) : super(key: key);
  final Function changeScreen;

  @override
  _AddSouvenirsPageState createState() => _AddSouvenirsPageState();
}

class _AddSouvenirsPageState extends State<AddSouvenirsPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;
  DateTime pickedDate;
  // storageFilePicker
  List<AssetEntity> assets = [];
  // cameraFilePicker  
  File _image;


  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
  }

  openStorageFilePicker() async {
    final List<AssetEntity> result = await AssetPicker.pickAssets(
      context,
      maxAssets: 15,
      pageSize: 320,
      pathThumbSize: 80,
      gridCount: 4,
      requestType: RequestType.image,
      selectedAssets: assets,
      themeColor: Colors.orange,
      textDelegate: EnglishTextDelegate(),
      routeCurve: Curves.easeIn,
      routeDuration: const Duration(milliseconds: 500),
    );

    setState(() {
      assets = result;
    });
  }

  Future openCameraFilePicker() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }


   Widget buildGridView() {
    if (assets.isNotEmpty) {
      return Container(
        child: GridView.count(
          padding: EdgeInsets.all(10),
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          shrinkWrap: true,
          crossAxisCount: 3,
          children: List.generate(assets.length, (index) {
            AssetEntity asset = assets[index];
            return Image(
              image: AssetEntityImageProvider(asset, isOriginal: false),
              width: 300,
              height: 300,
            );
          }),
        ),
      );
    }
    else
      return Container(color: Colors.red);
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
                          onPressed: openStorageFilePicker,
                          child: Icon(
                            Icons.photo_library,
                            size: 35,
                          ),
                          elevation: 3,
                          backgroundColor: Colors.white,
                        ),
                        FloatingActionButton(
                          onPressed: () => openCameraFilePicker(),
                          child: Icon(
                            Icons.camera_enhance,
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
                      buildGridView()
                    ],
                  ),
                  SizedBox(height: 10),
                  LocationInput(),
                  SizedBox(height: 10),
                  Input('Title', Icon(Icons.title_rounded, size: 20)),
                  SizedBox(height: 10),
                  Tags(),
                  SizedBox(height: 10),
                  DatePicker(),
                  SizedBox(height: 10),
                  Input('Comment', Icon(Icons.comment, size: 20)),
                  SizedBox(height: 10),
                  Input('Phone', Icon(Icons.phone, size: 20)),
                  SizedBox(height: 10),
                  Input('Email', Icon(Icons.mail, size: 20)),
                  SizedBox(height: 10),
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
                  souvenirsState.setState((state) async {
                    await state.addSouvenir(context, data, assets);
                    widget.changeScreen(0);
                  });
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
