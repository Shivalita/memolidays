import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
import 'package:memolidays/features/souvenirs/domain/usecases/delete_file.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/delete_souvenir.dart';
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

  // On first user's display, get all categories & souvenirs
  Future<void> init(BuildContext context) async {
    if (allCategoriesList == null) {
      allCategoriesList = await getAllCategories(context);
      allSouvenirsList = await getSouvenirsList(context);
      souvenirsList = allSouvenirsList;
    }

    // Select "All" category by default
    selectedCategory = selectCategory(allCategoriesList[0]);
  }

  // -------------------- GET --------------------

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


  // -------------------- DELETE --------------------

  // Delete file in database and souvenir's files list, redirect to souvenir page
  Future<void> deleteFile(BuildContext context, Souvenir souvenir, int fileId) async {
    try {
      await DeleteFile()(fileId);
      souvenir.thumbnails.removeWhere((file) => file.id == fileId);
      Get.off(SouvenirPage());
    }

    on Exception {
      final ErrorSnackbar errorSnackbar = ErrorSnackbar(context, 'Error : File couldn\'t be deleted, please try again.');
      errorSnackbar.displayErrorSnackbar();
    }
  }

  // Delete souvenir in database and souvenirs list, redirect to home page
  Future<void> deleteSouvenir(BuildContext context, int souvenirId) async {
    try {
      await DeleteSouvenir()(souvenirId);

      allSouvenirsList.removeWhere((souvenir) => souvenir.id == souvenirId);
      souvenirsList.removeWhere((souvenir) => souvenir.id == souvenirId);

      return Get.toNamed('/home');
    }

    on Exception {
      final ErrorSnackbar errorSnackbar = ErrorSnackbar(context, 'Error : Souvenir couldn\'t be deleted, please try again.');
      errorSnackbar.displayErrorSnackbar();
    }
  }


  // -------------------- UPDATE --------------------
  
  // Select category & get related souvenirs
  Category selectCategory(Category category) {
    selectedCategory = SelectCategory()(category);
    souvenirsList = GetCategorySouvenirs()(category.id, allSouvenirsList);
    return selectedCategory;
  }


  // If category isn't selected yet select it, else unselect it
  void updateSouvenirCategory(Souvenir souvenir, Category category) {
    List<int> souvenirCategoriesId = souvenir.categoriesId;

    if (souvenirCategoriesId.contains(category.id)) {
      temporaryCategoriesId.removeWhere((categoryId) => categoryId == category.id);
    } else {
      temporaryCategoriesId.add(category.id);
    }
  }

  // Update souvenir in database and state
  Future<void> updateSouvenir(Map<String, dynamic> data) async {
    List<String> categoriesIRI = [];
    List<int> categoriesId = data['categories'];

    // For each category (except 'All') replace id by an IRI in data to send
    categoriesId.removeWhere((categoryId) => categoryId == 0);

    categoriesId.forEach((categoryId) { 
      categoriesIRI.add('/api/categories/$categoryId');
    });

    data['categories'] = categoriesIRI;

    // Instanciate a new souvenir with form data and send it for database update
    int souvenirId = selectedSouvenir.id;
    Souvenir newSouvenir = Souvenir.fromForm(data);

    Souvenir updatedSouvenir = await UpdateSouvenir()(souvenirId, newSouvenir);

    // Retrieve files list from old souvenir, and replace it with new souvenir in state souvenirs list
    updatedSouvenir.thumbnails = selectedSouvenir.thumbnails;

    allSouvenirsList[allSouvenirsList.indexWhere((souvenir) => souvenir.id == updatedSouvenir.id)] = updatedSouvenir;

    // Get new souvenir categories list, set selected souvenir to new souvenir and redirect to souvenir page
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

  void addSouvenir(Map<String, dynamic> data) {
    print('DATA = $data');

    Souvenir newSouvenir = Souvenir.fromForm(data);

    registerCategories(data, newSouvenir);
  }

  registerCategories(Map data, Souvenir newSouvenir) {
    List<Category> existingCategories = [];
    List<Category> newCategories = [];
    List<Category> existingResult = [];
    List<Category> newResult = [];
    List<dynamic> categoriesList = data['categories'];

    categoriesList.forEach((tag) {
      existingResult = allCategoriesList.where((category) => (category.name.contains(tag.name))).toList();
      if (existingResult.length >= 1) {
        existingCategories.insert(0, existingResult[0]);
      }
    });

    categoriesList.forEach((tag) {
      newResult = allCategoriesList.where((category) => !(category.name.contains(tag.name))).toList();
      if (newResult.length >= 1) {
        newCategories.insert(0, newResult[0]);
      }
    });

  }

}