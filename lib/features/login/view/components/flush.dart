//! Snackbar to display on connectivity fail
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class Flush {

  displayFlushbar(BuildContext context) {
    return Flushbar(
      message: "Please check your network connexion and try again.",
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.white,
        ),
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      backgroundColor: Colors.red,
    )..show(context);
  }

}