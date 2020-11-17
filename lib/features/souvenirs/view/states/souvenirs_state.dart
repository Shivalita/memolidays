import 'package:flutter/material.dart';
import 'package:memolidays/core/components/error_snackbar.dart';
import 'package:memolidays/features/login/data/sources/local_source.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_all_categories.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_all_souvenirs.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:memolidays/core/states/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_user.dart';

class SouvenirsState {

  List<Category> allCategoriesList;
  Category selectedCategory;
  List<Souvenir> souvenirsList;
  Souvenir selectedSouvenir;
  bool isLocalizationEnabled;
  Position position;
  final LocalSource localSource = LocalSource();


  Future<void> init(BuildContext context) async {
    print('is connected = ${localSource.getIsConnected()}');
    if (localSource.getIsConnected() != true) {
      await GetUser()();
    }
    allCategoriesList = await getAllCategories(context);
    if (souvenirsList == null) {
      souvenirsList = await getSouvenirsList(context);
    }
  }

  Future<List<Category>> getAllCategories(BuildContext context) async {
    try {
      allCategoriesList = await GetAllCategories()();
    }

    on Exception {
      final ErrorSnackbar errorSnackbar = ErrorSnackbar(context, 'Server error : Please try again.');
      errorSnackbar.displayErrorSnackbar();
    }
    
    return allCategoriesList;
  }

  Future<List<Souvenir>> getSouvenirsList(BuildContext context) async {
    if ((selectedCategory != null) && (selectedCategory.id != 0)) {
      // souvenirsList = selectedCategory.souvenirsList;
      // return souvenirsList;
    } else {
      try {
        await localizationState.setState((state) => state.checkPosition());

        if ((localizationState.state.isPermissionAllowed) && (localizationState.state.isLocationServiceEnabled)) {
          isLocalizationEnabled = true;
          position = localizationState.state.currentPosition;
        } else {
          isLocalizationEnabled = false;
        }

        List<Souvenir> allSouvenirsList = await GetAllSouvenirs()();

        allSouvenirsList.forEach((souvenir) async {
        //   String souvenirPlace = await getPlaceFromCoordinates(souvenir);
        //   souvenir.place = souvenirPlace;
          
          if (isLocalizationEnabled) {
            String distance = getDistance(souvenir, position);
            souvenir.distance = distance;
          }
        });

        souvenirsList = allSouvenirsList;
      }

      on Exception {
        final ErrorSnackbar errorSnackbar = ErrorSnackbar(context, 'Server error : Please try again.');
        errorSnackbar.displayErrorSnackbar();
      }

    }
    return souvenirsList;
  }

  String getDistance(souvenir, position) {
    double distanceInMeters = Geolocator.distanceBetween(souvenir.latitude, souvenir.longitude, position.latitude, position.longitude);
    int distanceNumber;
    String distance;

    if (distanceInMeters >= 1000) {
      distanceNumber = (distanceInMeters/1000).round();
      distance = distanceNumber.toString() + " Km";
    } else {
      distanceNumber = (distanceInMeters).round();
      distance = distanceNumber.toString() + " m"; 
    }

    return distance;
  }

  Future<String> getPlaceFromCoordinates(souvenir) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(souvenir.lat, souvenir.lon);
    String souvenirPlace = placemarks[0].locality;
    // print(placemarks);
    return souvenirPlace;
  }

  Future<Category> selectCategory(BuildContext context, Category category) async {
    if ((selectedCategory == null) || (selectedCategory.id != category.id)) {
      selectedCategory = category;
      souvenirsList = await getSouvenirsList(context);
    }
    return selectedCategory;
  }

  void addSouvenir(data) {
    String date = data['date'].toString();
    String formattedDate = date.substring(0, 10);
    data['date'] = formattedDate;

    print('data = $data');
    Souvenir newSouvenir = Souvenir.fromForm(data);

    registerCategories(data, newSouvenir);
    print('allCategoriesList.length = ${allCategoriesList.length}');
    print('allCategoriesList[0].name = ${allCategoriesList[0].name}');
  }

  registerCategories(Map data, Souvenir newSouvenir) {
    List<Category> existingCategories = [];
    List<Category> newCategories = [];
    List<Category> existingResult = [];
    List<Category> newResult = [];
    List<dynamic> tagsList = data['tags'];

    tagsList.forEach((tag) {
      existingResult = allCategoriesList.where((category) => (category.name.contains(tag.name))).toList();
      if (existingResult.length >= 1) {
        // existingCategories.add(existingResult[0]);
        existingCategories.insert(0, existingResult[0]);
      }
    });

    tagsList.forEach((tag) {
      newResult = allCategoriesList.where((category) => !(category.name.contains(tag.name))).toList();
      if (newResult.length >= 1) {
        newCategories.insert(0, newResult[0]);
      }
    });

  }

}