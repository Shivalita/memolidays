import 'package:flutter/material.dart';
import 'package:memolidays/core/components/exceptions/exception_model.dart';

class ApiException implements ExceptionModel {

  final BuildContext context;
  final String message = 'An error has occurred.';

  ApiException(this.context);

  void displayError() {
    final ExceptionModel exceptionModel = ExceptionModel(context, message);
    exceptionModel.displayError();
  }

}