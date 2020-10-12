import 'package:flutter/material.dart';
import 'package:memolidays/core/components/exceptions/exception_model.dart';

class ConnectivityException implements ExceptionModel {

  final BuildContext context;
  final String message = 'Please check your network connexion and try again.';

  ConnectivityException(this.context);

  void displayError() {
    final ExceptionModel exceptionModel = ExceptionModel(context, message);
    exceptionModel.displayError();
  }

}