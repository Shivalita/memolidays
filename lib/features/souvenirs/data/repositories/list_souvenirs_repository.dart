import 'package:flutter/material.dart';
import 'package:memolidays/core/components/exceptions/api_exception.dart';
import 'package:memolidays/features/login/data/sources/local_source.dart';
import 'package:memolidays/features/souvenirs/data/sources/list_souvenirs_remote_source.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';

class ListSouvenirsRepository {
  
  final ListSouvenirsRemoteSource listSouvenirsRemoteSource = ListSouvenirsRemoteSource();

  ListSouvenirsRepository._();
  static ListSouvenirsRepository _cache;
  factory ListSouvenirsRepository() => _cache ??= ListSouvenirsRepository._();

  int getMemolidaysId() {
    final LocalSource localSource = LocalSource();
    final Map<String, dynamic> idsMap = localSource.getUserIds();
    final int memolidaysId = idsMap['memolidaysId'];
    return memolidaysId;
  }

  Future<List<Category>> getCategoriesList(BuildContext context) async {
    try {
      final int userId = getMemolidaysId();
      final List<Category> categoriesList = await listSouvenirsRemoteSource.getCategoriesList(userId);
      return categoriesList;
    }

    on ApiException {
      print('ERROR : API request failed');
      final ApiException apiException = ApiException(context);
      apiException.displayError();
    }
  }

  Future<List<List<Souvenir>>> getSouvenirsList(BuildContext context) async {
    try {
      final int userId = getMemolidaysId();
      final List<List<Souvenir>> souvenirsList = await listSouvenirsRemoteSource.getSouvenirsList(userId);
      return souvenirsList;
    }

    on ApiException {
      print('ERROR : API request failed');
      final ApiException apiException = ApiException(context);
      apiException.displayError();
    }
  }

}
