// Importing Flutter material package
import 'package:flutter/material.dart';

// Importing Flutter Bloc package for state management
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc/bloc.dart';
import 'package:shop_app/models/categories_model.dart';

import 'package:shop_app/models/home_model.dart';

import 'package:shop_app/modules/categories_screen.dart';
import 'package:shop_app/modules/favorite_screen.dart';
import 'package:shop_app/modules/products_screen.dart';
import 'package:shop_app/modules/settings_screen.dart';

import 'package:shop_app/shared/cubit/shop_state.dart';

import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../constant.dart';
import '../network/end_point.dart';

class ShopCubit extends Cubit<ShopStates> {
  // Constructor to initialize the ShopCubit with an initial state
  ShopCubit() : super(ShopInitial());

  // Static method to get the instance of ShopCubit from the context
  static ShopCubit get(context) => BlocProvider.of(context);

  // Index to keep track of the currently selected bottom navigation item
  int currentIndex = 0;

  // List of widgets for the bottom navigation bar screens
  List<Widget> bottomScreen = [
    // Product screen widget
    const ProductsScreen(),
    // Categories screen widget
    const CategoriesScreen(),
    // Favorite screen widget
    const FavoriteScreen(),
    // Settings screen widget
    const SettingsScreen(),
  ];

  // Method to change the currently selected bottom navigation item
  void changeBottom(int index) {
    // Updating the current index
    currentIndex = index;
    // Emitting state to notify listeners about the change
    emit(ShopChangeBottomNavState());
  }

  // HomeModel instance to store the home data
  HomeModel? homeModel;

  // Method to fetch home data from the server
  void getHomeData() {
    // Emitting state to notify listeners that data loading has started
    emit(ShopLodgingHomeDataState());
    // Making a GET request to fetch home data
    DioHelper.getData(
      url: home,
      query: null,
      token: token,
    ).then((value) {
      // Parsing the response and storing it in homeModel
      homeModel = HomeModel.fromJson(value.data);
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      // Printing the error message
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  // Method to fetch home data from the server
  void getCategoriesData() {
    emit(ShopLodgingCategoriesState());
    DioHelper.getData(
      url: getCategories,
      query: null,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      // Printing the error message
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }
}
