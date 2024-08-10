// Importing Flutter material package
import 'package:flutter/material.dart';

// Importing Flutter Bloc package for state management
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:shop_app/models/home_model.dart';
import '../../models/categories_model.dart';
import '../../models/change_favorite_model.dart';
import '../../models/favorites_model.dart';
import '../../models/login_model.dart';
import '../../modules/categories_screen.dart';
import '../../modules/favorite_screen.dart';
import '../../modules/products_screen.dart';
import '../../modules/settings_screen.dart';
import '../components/constant.dart';
import '../network/end_point.dart';
import '../network/remote/dio_helper.dart';
import 'shop_states.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitial());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoriteScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  // this to access model of [home_model]
  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopLodgingHomeDataState());
    DioHelper.getData(
      url: home,
      query: null,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // this to adding the produce to our favorite [favoritesProduct]
      homeModel?.data.products.forEach((element) {
        favoritesProduct.addAll({element.id: element.inFavorites});
      });
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
      // adding data to categoriesModel by fromJson function
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  // This map of favorites product
  // int this is ID and bool is the product
  Map<int, bool> favoritesProduct = {};

  // this model for change color of favorite button
  ChangeFavoritesModel? changeFavoriteModel;

  void changeFavorites(int productId) {
    // this to change the color of button favorites when pressed
    // it's work when pressed remove value of id
    favoritesProduct[productId] = !favoritesProduct[productId]!;
    emit(ShopChangeFavoriteState());
    DioHelper.postData(
      url: favorites,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoriteModel = ChangeFavoritesModel.fromJson(value.data);
      // this line for if status is false change the color of favorites to gray
      // why do that because if there error in connection
      // the set the original color of button mean set color gray
      if (!changeFavoriteModel!.status) {
        favoritesProduct[productId] = !favoritesProduct[productId]!;
      } else {
        // when click the favorite button in favorite screen
        // get data again to reload the screen to delete the product from screen
        getFavoriteData();
      }
      // print(value.toString());
      emit(ShopSuccessChangeFavoriteState(changeFavoriteModel!));
    }).catchError((error) {
      print(error.toString());
      favoritesProduct[productId] = !favoritesProduct[productId]!;
      emit(ShopErrorChangeFavoriteState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavoriteData() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: favorites,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoriteState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoriteState());
    });
  }

  ShopLoginModel? userModel;

// this to get the info of user in setting screen
  void getUserSettingsData() {
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(
      // this is endpoint to get the settings [info of user]
      url: profile,
      token: token,
    ).then((value) {
      // adding data to the model
      userModel = ShopLoginModel.formJson(value.data);
      print(userModel!.data.toString());
      emit(ShopSuccessGetUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetUserDataState());
    });
  }

  void updateUserData({
    required String email,
    required String phone,
    required String name,
  }) {
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(url: updateProfile, token: token, data: {
      'email': email,
      'phone': phone,
      'name': name,
    }).then((value) {
      userModel = ShopLoginModel.formJson(value.data);
      print(userModel!.data.toString());
      emit(ShopSuccessUpdateUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserDataState());
    });
  }
}
