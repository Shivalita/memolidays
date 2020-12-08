import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:memolidays/features/souvenirs/view/components/input.dart';
import 'package:memolidays/features/souvenirs/view/components/update_date_picker.dart';
import 'package:memolidays/features/souvenirs/view/components/update_tags.dart';

class UpdateSouvenirPage extends StatefulWidget {
  @override
  _UpdateSouvenirPageState createState() => _UpdateSouvenirPageState();
}

class _UpdateSouvenirPageState extends State<UpdateSouvenirPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;

  DateTime pickedDate;
  Souvenir souvenir = souvenirsState.state.selectedSouvenir;

  void initState() {
    super.initState();
    pickedDate = DateTime.now();
  }
  
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Update ${souvenir.title}'),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              // Display a confirmation modal when going back without saving changes
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
                              )))), //TextStyle //Text //Center //Container
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
                                    color: Colors.green,
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Get.toNamed('/souvenir');
                              })])
                      ])));
                });
        })),
        // Prevents the keyboard from causing an overflow when unfolding
        resizeToAvoidBottomPadding: false,
        body: Container(
          // Rebuild view when the state is modified
          child: souvenirsState.whenRebuilder(
            onIdle: () => Center(child: SizedBox(
              child: CircularProgressIndicator(strokeWidth: 2))),
            onWaiting: () => Center(child: SizedBox(
              child: CircularProgressIndicator(strokeWidth: 2))),
            onError: (error) {
              throw error;
            },
            onData: () {
              // Create a form pre-filled with current souvenir data
              return FormBuilder(
                initialValue: {
                  'title': souvenir.title, 
                  'place': souvenir.place,
                  'categories': souvenir.categoriesId,
                  'eventDate' : souvenir.eventDate,
                  'email': souvenir.email,
                  'phone' : souvenir.phone,
                  'comment' : souvenir.comment
                },
                key: _fbKey,
                child: Container(
                  margin: EdgeInsets.only(right: 25, left: 25),
                  child: Column(
                    // Form fields
                    children: <Widget>[
                      SizedBox(height: 20),
                      UpdateTags(),
                      SizedBox(height: 40),
                      Input('Title', Icon(Icons.title_rounded, size: 20)),
                      SizedBox(height: 20),
                      Input('Place', Icon(Icons.public, size: 20)),
                      SizedBox(height: 20),
                      UpdateDatePicker(),
                      SizedBox(height: 20),
                      Input('Comment', Icon(Icons.comment, size: 20)),
                      SizedBox(height: 20),
                      Input('Phone', Icon(Icons.phone, size: 20)),
                      SizedBox(height: 20),
                      Input('Email', Icon(Icons.mail, size: 20)),
                      SizedBox(height: 80),
                      buildTextWithIcon(),
                      SizedBox(height: 40)
                  ])
              ));
        }))
    );
  }

  // Validation button
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

  // Validation button process
  void onPressedIconWithText() {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIcon = ButtonState.loading;
              Future.delayed(Duration(milliseconds : 500), () {

          setState(() {
            // If form is validated, call update souvenir method
            if (_fbKey.currentState.saveAndValidate()) {
                Map<String, dynamic> data = _fbKey.currentState.value;
                stateTextWithIcon = ButtonState.success;
                Future.delayed(Duration(milliseconds : 1000), () {
                  souvenirsState.setState((state) async => 
                    await state.updateSouvenir(data));
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
