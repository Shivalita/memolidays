import 'package:flutter/material.dart';
import 'package:memolidays/core/components/error_snackbar.dart';
import 'package:memolidays/features/login/data/sources/local_source.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_all_categories.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_all_souvenirs.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_category_souvenirs.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_distance.dart';
import 'package:geolocator/geolocator.dart';
import 'package:memolidays/features/login/view/states/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_souvenir_categories.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_user.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/select_category.dart';

class SouvenirsState {

  List<Category> allCategoriesList;
  Category selectedCategory;
  List<Souvenir> allSouvenirsList;
  List<Souvenir> souvenirsList;
  Souvenir selectedSouvenir;
  bool isLocalizationEnabled;
  Position position;
  int userId;
  final LocalSource localSource = LocalSource();

  // Launched each time the view is rebuilded
  Future<void> init(BuildContext context) async {
    bool isConnected = localSource.getIsConnected();

    //!
    if (isConnected && userId == null) {
      await GetUser()();
      userId = localSource.getUserId();
    }

    // On first display, get all categories & souvenirs
    if (allCategoriesList == null) {
      allCategoriesList = await getAllCategories(context);
      allSouvenirsList = await getSouvenirsList(context);
      souvenirsList = allSouvenirsList;
    }

    // Select "All" category by default
    selectedCategory = selectCategory(allCategoriesList[0]);
  }

  // Get all categories, if error thrown display an error message
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

  // Get all souvenirs, if error thrown display an error message
  Future<List<Souvenir>> getSouvenirsList(BuildContext context) async {
    List<Souvenir> allSouvenirs;

    try {
      // Check if localization is possible
      await localizationState.setState((state) => state.checkPosition());

      if ((localizationState.state.isPermissionAllowed) && (localizationState.state.isLocationServiceEnabled)) {
        isLocalizationEnabled = true;
        position = localizationState.state.currentPosition;
      } else {
        isLocalizationEnabled = false;
      }

      allSouvenirs = await GetAllSouvenirs()();

      allSouvenirs.forEach((souvenir) async {
        GetSouvenirCategories()(souvenir, allSouvenirs);
        
        // If localization possible, get souvenir's distance
        if (isLocalizationEnabled) {
          String distance = GetDistance()(souvenir, position);
          souvenir.distance = distance;
        }
      });
    }

    on Exception {
      final ErrorSnackbar errorSnackbar = ErrorSnackbar(context, 'Server error : Please try again.');
      errorSnackbar.displayErrorSnackbar();
    }

    return allSouvenirs;
  }

  // Select category & get related souvenirs
  Category selectCategory(Category category) {
    selectedCategory = SelectCategory()(category);
    souvenirsList = GetCategorySouvenirs()(category.id, allSouvenirsList);
    return selectedCategory;
  }

  //! CREATE

  // Future<String> getPlaceFromCoordinates(souvenir) async {
  //   List<Placemark> placemarks = await placemarkFromCoordinates(souvenir.latitude, souvenir.longitude);
  //   String souvenirPlace = placemarks[0].locality;
  //   print(placemarks);
  //   return souvenirPlace;
  // }

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