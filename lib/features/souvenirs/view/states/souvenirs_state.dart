import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';
import 'package:memolidays/core/components/error_snackbar.dart';
import 'package:memolidays/core/constantes.dart';
import 'package:memolidays/features/login/data/sources/local_source.dart';
import 'package:memolidays/features/souvenirs/domain/models/category.dart';
import 'package:memolidays/features/souvenirs/domain/models/pin.dart';
import 'package:memolidays/features/souvenirs/domain/models/souvenir.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/create_souvenir.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_all_categories.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_all_souvenirs.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_category_souvenirs.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/get_distance.dart';
import 'package:geolocator/geolocator.dart';
import 'package:memolidays/features/login/view/states/dependencies.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/delete_file.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/delete_souvenir.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/select_category.dart';
import 'package:memolidays/features/souvenirs/domain/usecases/update_souvenir.dart';
import 'package:memolidays/features/souvenirs/view/pages/souvenir_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SouvenirsState {

  List<Category> allCategoriesList;
  Category selectedCategory;
  List<int> temporaryCategoriesId;
  List<Souvenir> allSouvenirsList;
  List<Souvenir> souvenirsList;
  Souvenir selectedSouvenir;
  bool isLocalizationEnabled;
  Position position;
  Icon currentSouvenirIcon;
  bool isSetInputLocation = false;
  Map<String, dynamic> inputLocation = {};
  final LocalSource localSource = LocalSource();
  final Constantes constantes = Constantes();

  // -------------------- INITIALIZATION --------------------

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

  // Get souvenir categories from all categories list by their id (excepted "all")
  List<Category> getSouvenirCategories(List<int> souvenirCategoriesId, List<Category> allCategoriesList) {
    List<Category> souvenirCategories = [];

    souvenirCategoriesId.forEach((souvenirCategoryId) {
      if(souvenirCategoryId != 0) {
        Category souvenirCategory = allCategoriesList.firstWhere((category) => category.id == souvenirCategoryId);
        souvenirCategories.add(souvenirCategory);
      }
    });

    return souvenirCategories;
  }

  // -------------------- GET --------------------

  // Get all categories, if error thrown display an error message
  Future<List<Category>> getAllCategories(BuildContext context) async {
    try {
      allCategoriesList = await GetAllCategories()();
    }

    on Exception {
      print('PPL exception getAllCategories souvenirs_state');
      final ErrorSnackbar errorSnackbar = ErrorSnackbar(context, 'Data retrieval failed : Please try again.');
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
        // If localization possible, get souvenir's distance
        if (isLocalizationEnabled) {
          String distance = GetDistance()(souvenir, position);
          souvenir.distance = distance;
        }
      });
    }

    on Exception {
      print('PPL exception getSouvenirsList souvenirs_state');
      final ErrorSnackbar errorSnackbar = ErrorSnackbar(context, 'Data retrieval failed : Please try again.');
      errorSnackbar.displayErrorSnackbar();
    }

    return allSouvenirs;
  }

  void getSouvenirIcon(Souvenir souvenir) {
    Category firstSouvenirCategory = souvenir.categories[0];
    Pin pin = firstSouvenirCategory.pin;

    Icon souvenirIcon = Icon(constantes.icons[pin.icon], color: constantes.colors[pin.color], size: 22);
    currentSouvenirIcon = souvenirIcon;
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
      souvenir.categories.removeWhere((souvenirCategory) => souvenirCategory.id == category.id);
    } else {
      temporaryCategoriesId.add(category.id);
      souvenir.categories.add(category);
    }

    
  }

  // Update souvenir in database and state
  Future<void> updateSouvenir(Map<String, dynamic> data) async {
    // List<String> categoriesIRI = [];
    // List<int> categoriesId = data['categories'];

    // Remove category 'All' from categories list
    data['categories'].removeWhere((category) => category.id == 0);

    // categoriesId.forEach((categoryId) { 
    //   categoriesIRI.add('/api/categories/$categoryId');
    // });

    // data['categories'] = categoriesIRI;

    //!
    if (isSetInputLocation) {
      print('PPL isSetInputLocation');
      data['location'] = inputLocation;
    }

    data['userId'] = localSource.getUserId();

    print('STATE UPDATE DATA = ');
    print(data);

    // Instanciate a new souvenir with form data and send it for database update
    int souvenirId = selectedSouvenir.id;
    Souvenir newSouvenir = Souvenir.fromForm(data);

    Souvenir updatedSouvenir = await UpdateSouvenir()(souvenirId, newSouvenir);

    // Retrieve files list from old souvenir
    updatedSouvenir.thumbnails = selectedSouvenir.thumbnails;

    // Replace old souvenir with new souvenir in souvenirs list
    allSouvenirsList[allSouvenirsList.indexWhere((souvenir) => souvenir.id == updatedSouvenir.id)] = updatedSouvenir;

    // Set selected souvenir to new souvenir
    selectedSouvenir = updatedSouvenir;

    // Redirect to souvenir page
    Get.toNamed('/souvenir');
  }

  // -------------------- CREATE --------------------
  //! ON PROGRESS

  void updateLocationInput(MapBoxPlace place) {
    print('PPL UPDATE LOCATION INPUT');

    if (place.properties.address != null) {
      inputLocation['address'] = place.properties.address;
    } else {
      inputLocation['address'] = ' ';
    }

    inputLocation['place'] = place.text;
    inputLocation['coordinates'] = place.geometry.coordinates;

    isSetInputLocation = true;
  }

  Future<void> addSouvenir(BuildContext context, Map<String, dynamic> data) async {
    data['createdAt'] = DateTime.now();

    data['location'] = inputLocation;

    data['userId'] = localSource.getUserId();

    Souvenir souvenir = Souvenir.fromForm(data);

    // registerCategories(data);

    try {
      Souvenir newSouvenir = await CreateSouvenir()(souvenir);

      allCategoriesList = await getAllCategories(context);
      allSouvenirsList = await getSouvenirsList(context);

      Get.toNamed('/home');
    }

    on Exception {
      final ErrorSnackbar errorSnackbar = ErrorSnackbar(context, 'Error : Souvenir couldn\'t be created, please try again.');
      errorSnackbar.displayErrorSnackbar();
    }
  }

  // void registerCategories(Map<String, dynamic> data) {
  //   List<Category> existingCategories = [];
  //   List<Category> newCategories = [];
  //   List<Category> existingResults = [];
  //   List<dynamic> categoriesList = data['categories'];

  //   categoriesList.forEach((tag) {
  //     tag.name = "${tag.name[0].toUpperCase()}${tag.name.substring(1)}";

  //     existingResults = allCategoriesList.where((category) => (category.name.contains(tag.name))).toList();
  //     if (existingResults.length >= 1) {
  //       existingCategories.insert(0, existingResults[0]);
  //     } else {
  //       newCategories.insert(0, tag);
  //     }
  //   });

    // print('EXISTING CATEGORIES = ');
    // existingCategories.forEach((category) {
    //   print(category.name);
    // });

    // print('NEW CATEGORIES = ');
    // newCategories.forEach((category) {
    //   print(category.name);
    // });

  // }

}