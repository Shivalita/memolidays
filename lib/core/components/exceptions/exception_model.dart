import 'package:flutter/material.dart';
import 'package:memolidays/core/components/exceptions/error_snackbar.dart';

class ExceptionModel implements Exception {

  final BuildContext context;
  final String message;

  ExceptionModel(this.context, this.message);

  //! Displays snackbar with error message
  void displayError() {
    final ErrorSnackbar snackbar = ErrorSnackbar(context, message);
    snackbar.displayErrorSnackbar();
  }

}