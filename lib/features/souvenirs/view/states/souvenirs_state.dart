import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memolidays/core/components/error_snackbar.dart';
import 'package:memolidays/core/home/home.dart';
import 'package:memolidays/features/login/data/sources/local_source.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/file.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_all_categories.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_all_souvenirs.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_category_souvenirs.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_distance.dart';
import 'package:geolocator/geolocator.dart';
import 'package:memolidays/features/login/view/states/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_souvenir_categories.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/remove_file.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/remove_souvenir.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/select_category.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/update_souvenir.dart';
import 'package:memolidays/features/souvenirs/view/pages/souvenir_page.dart';

class SouvenirsState {

  List<Category> allCategoriesList;
  Category selectedCategory;
  List<int> temporaryCategoriesId;
  List<Souvenir> allSouvenirsList;
  List<Souvenir> souvenirsList;
  Souvenir selectedSouvenir;
  bool isLocalizationEnabled;
  Position position;
  final LocalSource localSource = LocalSource();

  // If first user's display, get all categories & souvenirs
  Future<void> init(BuildContext context) async {
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


  Future<void> removeFile(BuildContext context, Souvenir souvenir, int fileId) async {
    try {
      await RemoveFile()(fileId);
      
      List<File> souvenirFiles = souvenir.thumbnails;
      souvenirFiles.removeWhere((file) => file.id == fileId);

      Get.off(SouvenirPage());
    }

    on Exception {
      final ErrorSnackbar errorSnackbar = ErrorSnackbar(context, 'Error : File couldn\'t be deleted, please try again.');
      errorSnackbar.displayErrorSnackbar();
    }
  }


  Future<void> removeSouvenir(BuildContext context, int souvenirId) async {
    try {
      await RemoveSouvenir()(souvenirId);

      allSouvenirsList.removeWhere((souvenir) => souvenir.id == souvenirId);
      souvenirsList.removeWhere((souvenir) => souvenir.id == souvenirId);

      return Get.to(MyHomePage());
    }

    on Exception {
      final ErrorSnackbar errorSnackbar = ErrorSnackbar(context, 'Error : Souvenir couldn\'t be deleted, please try again.');
      errorSnackbar.displayErrorSnackbar();
    }
  }


  void updateSouvenirCategory(Souvenir souvenir, Category category) {
    List<int> souvenirCategoriesId = souvenir.categoriesId;
    // temporaryCategoriesId = souvenirCategoriesId;

    if (souvenirCategoriesId.contains(category.id)) {
      temporaryCategoriesId.removeWhere((categoryId) => categoryId == category.id);
    } else {
      temporaryCategoriesId.add(category.id);
    }
  }


  Future<void> updateSouvenir(Map<String, dynamic> data) async {
    List<String> categoriesIRI = [];
    List<int> categoriesId = data['categories'];

    categoriesId.removeWhere((categoryId) => categoryId == 0);

    categoriesId.forEach((categoryId) { 
      categoriesIRI.add('/api/categories/$categoryId');
    });

    data['categories'] = categoriesIRI;
    int souvenirId = selectedSouvenir.id;

    Souvenir newSouvenirData = Souvenir.fromForm(data);

    Souvenir updatedSouvenir = await UpdateSouvenir()(souvenirId, newSouvenirData);

    updatedSouvenir.thumbnails = selectedSouvenir.thumbnails;

    allSouvenirsList[allSouvenirsList.indexWhere((souvenir) => souvenir.id == updatedSouvenir.id)] = updatedSouvenir;

    GetSouvenirCategories()(updatedSouvenir, allSouvenirsList);
    selectedSouvenir = updatedSouvenir;

    Get.toNamed('/souvenir');
  }


  //! CREATE PART - ON PROGRESS

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