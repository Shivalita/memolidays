import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:memolidays/core/home/home.dart';
import 'package:memolidays/core/thumbnail_link.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:memolidays/features/souvenirs/view/components/date_picker.dart';
import 'package:memolidays/features/souvenirs/view/components/input.dart';
import 'package:memolidays/features/souvenirs/view/components/update_tags.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class UpdateSouvenirPage extends StatefulWidget {
  @override
  _UpdateSouvenirPageState createState() => _UpdateSouvenirPageState();
}

class _UpdateSouvenirPageState extends State<UpdateSouvenirPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;

  DateTime pickedDate;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
  }

  Souvenir souvenir = souvenirsState.state.selectedSouvenir;
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.to(MyHomePage());
        return false;
      },
      child: Scaffold(
        // backgroundColor: Colors.black,
        appBar: AppBar(
          // backgroundColor: Colors.black,
          title: Text('Update ${souvenir.title}'),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    "Changes will be lost, are you sure ?",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  RaisedButton(
                                    child: Text("No"),
                                    color: Colors.red,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  RaisedButton(
                                    child: Text("Yes"),
                                    color: Colors.orange,
                                    // On pressed delete selected file in state & redirect to home page
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Get.back();
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
          // ],
        ),
        body: Container(
          // Rebuild view when state is modified and call init method
          child: souvenirsState.whenRebuilder(
            // initState: () => souvenirsState.setState((state) async => await state.init(context)),
            onIdle: () => Center(child: SizedBox(child: CircularProgressIndicator(strokeWidth: 2))),
            onWaiting: () => Center(child: SizedBox(child: CircularProgressIndicator(strokeWidth: 2))),
            onError: (error) {
              throw error;
            },
            onData: () {
          return FormBuilder(
            initialValue: {
              'title': souvenir.title, 
              'location': souvenir.place,
              'tags': souvenir.categoriesId,
              'date' : souvenir.eventDate,
              'email': souvenir.email,
              'phone' : souvenir.phone,
              'comment' : souvenir.comment
            },
            key: _fbKey,
            child: Container(
              margin: EdgeInsets.only(right: 25, left: 25),
              child: Column(
                children: <Widget>[
                  // Container(
                  //   margin: EdgeInsets.only(top: 20),
                  //   child: Stack(
                  //     alignment: Alignment.bottomLeft, 
                  //     children: <Widget>[
                  //       Container(
                  //         child: ClipRRect(
                  //           // Display sized thumbnail from cache if stored, else store it
                  //           child : CachedNetworkImage(
                  //             imageUrl: ThumbnailLink().getThumbnailLink(souvenir.cover, 400),
                  //             progressIndicatorBuilder: (context, url, downloadProgress) => 
                  //               Center(child: CircularProgressIndicator(value: downloadProgress.progress, strokeWidth: 2)),
                  //             errorWidget: (context, url, error) => Icon(Icons.error),
                  //             fit: BoxFit.cover,
                  //           ),
                  //         ),
                  //       ),
                  //     ]
                  //   ),
                  // ),
                  SizedBox(height: 20),
                  UpdateTags(),
                  SizedBox(height: 40),
                  Input('Title', Icon(Icons.title_rounded, size: 20)),
                  SizedBox(height: 20),
                  Input('Location', Icon(Icons.public, size: 20)),
                  SizedBox(height: 20),
                  DatePicker(),
                  SizedBox(height: 20),
                  Input('Comment', Icon(Icons.comment, size: 20)),
                  SizedBox(height: 20),
                  Input('Phone', Icon(Icons.phone, size: 20)),
                  SizedBox(height: 20),
                  Input('Email', Icon(Icons.mail, size: 20)),
                  SizedBox(height: 80),
                  buildTextWithIcon(),
                  SizedBox(height: 40)
                ],
              )
            ),
          );
        })
      ))
    );
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
        // Future.delayed(Duration(seconds: 1), () {
          setState(() {
            if (_fbKey.currentState.saveAndValidate()) {
              Map<String, dynamic> data = _fbKey.currentState.value;
              souvenirsState.setState((state) async => await state.updateSouvenir(data));
              stateTextWithIcon = ButtonState.success;
            } else {
              stateTextWithIcon = ButtonState.fail;
            }
          });
        // });
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
