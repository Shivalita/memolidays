import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:memolidays/features/souvenirs/view/pages/update_souvenir_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';



class PopUpOptionMenu extends StatelessWidget {
  Souvenir souvenir = souvenirsState.state.selectedSouvenir;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: ListTile(
            leading: Icon(
              Icons.info_outline,
              color: Colors.black,
            ),
            title: Text("Infos"),
          ),
        ),
        PopupMenuItem(
          value: 0,
          child: GestureDetector(
          // On tap redirect to update page
            onTap: () {
              return Get.to(UpdateSouvenirPage());
            },
            child: ListTile(
              leading: Icon(
                Icons.edit,
                color: Colors.black,
              ),
              title: Text("Edit"),
            ),
          ),
        ),
        PopupMenuItem(
          value: 1,
          child: GestureDetector(
            // On tap display a confirmation modal
            onTap: () {
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
                                "Are you sure you want to delete this souvenir ?",
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
                                color: Colors.green,
                                // On pressed delete selected souvenir & redirect to home page
                                onPressed: () {
                                  souvenirsState.setState((state) => state.deleteSouvenir(context, souvenir.id)); 
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
            child: ListTile(
              leading: Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),
              title: Text(
                "Delete", 
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
        )
      ],
      onSelected: (result) {
        if (result == 0) {
          return showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            "Edit this title",
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
                      FormBuilder(
                        child: FormBuilderTextField(
                          attribute: "title",
                          readOnly: false,
                          decoration: InputDecoration(
                            hintText: 'Title',
                            filled: true,
                            fillColor: Colors.grey[100],
                            prefixIcon: Icon(Icons.title_rounded, size: 20),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(color: Colors.black54),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(
                              left: 16,
                              right: 20,
                              top: 14,
                              bottom: 14,
                            ),
                          ),
                        )
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          RaisedButton(
                            child: Text("Cancel"),
                            color: Colors.grey,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          RaisedButton(
                            child: Text("Yes"),
                            color: Colors.orange,
                            onPressed: () {
                              //Delete This Image
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
          );
        }
        if (result == 1) {
          return showModalBottomSheet(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 0,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              souvenir.title,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            souvenir.comment,
                            style: TextStyle(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(Icons.location_on,
                                    color: Colors.red, size: 35),
                                Text(
                                  souvenir.place,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              souvenir.eventDate,
                              style: TextStyle(
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              souvenir.email,
                              style: TextStyle(
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              souvenir.phone,
                              style: TextStyle(
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              "Share it with the world !",
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.envelope,
                                size: 30,
                                color: HexColor("#000000"),
                              ),
                              onPressed: () {
                                launch(_emailLaunchUri.toString());
                              }
                            ),
                            IconButton(
                                icon: FaIcon(
                                  FontAwesomeIcons.facebook,
                                  size: 30,
                                  color: HexColor("#0674E7"),
                                ),
                                onPressed: () {}),
                            IconButton(
                                icon: FaIcon(
                                  FontAwesomeIcons.instagram,
                                  size: 30,
                                  color: HexColor("#C13584"),
                                ),
                                onPressed: () {}),
                            IconButton(
                                icon: FaIcon(
                                  FontAwesomeIcons.twitter,
                                  size: 30,
                                  color: HexColor("#1da1f2"),
                                ),
                                onPressed: () {}),
                            IconButton(
                                icon: FaIcon(
                                  FontAwesomeIcons.userCircle,
                                  size: 30,
                                  color: Colors.orange,
                                ),
                                onPressed: () {}),
                          ],
                        ),
                        SizedBox(height: 5)
                      ]
                  ),
                ),
              );
            }
          );
        }
      },
    );
  }
}

final Uri _emailLaunchUri = Uri(
  scheme: 'mailto',
  path: '',
  queryParameters: {
    'subject': 'Example Subject & Symbols are allowed!'
  }
);