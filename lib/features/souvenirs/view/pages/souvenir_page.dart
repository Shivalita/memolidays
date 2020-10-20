import 'package:flutter/material.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:memolidays/features/souvenirs/view/components/souvenir_header.dart';
import 'package:memolidays/features/souvenirs/view/components/masonery_grid.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';

class SouvenirPage extends StatelessWidget {
  Souvenir souvenir = souvenirsState.state.selectedSouvenir;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(souvenir.title),
          centerTitle: true,
          actions: [
                  IconButton(
                      icon: Icon(Icons.info_outline),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                                // height: 200,
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
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
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          souvenir.date,
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
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
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
                      },
                  )
                ], 
          // actions: <Widget>[
          //   PopupMenuButton(
          //     itemBuilder: (context) => [
          //       PopupMenuItem(
          //         child: GestureDetector(
          //           onTap: () {
          //             Get.toNamed("/home");
          //           },
          //           child: Row(
          //             children: [
          //               Icon(Icons.settings),
          //               SizedBox(width: 5),
          //               Text("Settings"),
          //             ],
          //           )
          //         ),
          //       ),
          //     ]
          //   )
          // ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[SouvenirHeader(), MasoneryGrid()],
            ),
          ),
        ));
  }
}
