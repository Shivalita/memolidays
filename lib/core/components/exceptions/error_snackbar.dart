//! Snackbar to display on errors
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class ErrorSnackbar {

  BuildContext context;
  String message;

  ErrorSnackbar(BuildContext context, message) {
    this.context = context;
    this.message = message;
  }

  displayErrorSnackbar() {
    return Flushbar(
      message: message,
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