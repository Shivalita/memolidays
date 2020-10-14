import 'package:flutter/material.dart';
import 'package:memolidays/core/usecase.dart';
import 'package:memolidays/features/souvenirs/data/repositories/list_souvenirs_repository.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';

class GetSouvenirs implements Usecase {

  final ListSouvenirsRepository repository = ListSouvenirsRepository();
  @override

  Future<List<List<Souvenir>>> call(BuildContext context) async {
    List<List<Souvenir>> souvenirs = await repository.getSouvenirsList(context);
    return souvenirs;
  }
  
}