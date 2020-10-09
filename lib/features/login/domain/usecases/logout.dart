import 'package:flutter/material.dart';
import 'package:memolidays/core/usecase.dart';
import 'package:memolidays/features/login/data/repositories/login_repository.dart';

class Logout implements Usecase {

  final LoginRepository repository = LoginRepository();

  @override
  Future<String> call(BuildContext context) async {
    String disconnectionMessage = await repository.signOutGoogle(context);
    return disconnectionMessage;
  }

}