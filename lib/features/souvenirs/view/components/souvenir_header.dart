import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:memolidays/features/souvenirs/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';

// ignore: must_be_immutable
class SouvenirHeader extends StatelessWidget {
  Souvenir souvenir = souvenirsState.state.selectedSouvenir;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      child: Stack(
        alignment: Alignment.bottomLeft, 
        children: <Widget>[
        Container(
          child: ClipRRect(
            // borderRadius: BorderRadius.circular(12),
             child: Image.network(
              // "https://source.unsplash.com/S0hS0HfH_B8" //Portrait
              souvenir.cover, //Paysage
            // child: Image.network(
            //   // "https://source.unsplash.com/S0hS0HfH_B8" //Portrait
            //   "https://source.unsplash.com/VFRTXGw1VjU/", //Paysage
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            souvenir.title,
            maxLines: 4,
            style: TextStyle(
              fontSize: 35,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 10.0,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        ]
      ),
    );
  }
}