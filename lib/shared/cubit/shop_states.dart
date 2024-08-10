import 'package:shop_app/models/login_model.dart';

import '../../models/change_favorite_model.dart';

class ShopStates {}

class ShopInitial extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLodgingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopLodgingCategoriesState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopChangeFavoriteState extends ShopStates {}

class ShopSuccessChangeFavoriteState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoriteState(this.model);
}

class ShopErrorChangeFavoriteState extends ShopStates {}

class ShopSuccessGetFavoriteState extends ShopStates {}

class ShopErrorGetFavoriteState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopLoadingGetUserDataState extends ShopStates {}

class ShopSuccessGetUserDataState extends ShopStates {
  final ShopLoginModel loginModel;
  ShopSuccessGetUserDataState(this.loginModel);
}

class ShopErrorGetUserDataState extends ShopStates {}

class ShopErrorUpdateUserDataState extends ShopStates {}

class ShopSuccessUpdateUserDataState extends ShopStates {
  final ShopLoginModel loginModel;
  ShopSuccessUpdateUserDataState(this.loginModel);
}

class ShopLoadingUpdateUserDataState extends ShopStates {}
