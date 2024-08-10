import '../../../models/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitial extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final ShopLoginModel loginModel;
  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterStates {
  final String? error;
  ShopRegisterErrorState(this.error){
    print(error);
  }
}

class ShopChangePasswordVisibility extends ShopRegisterStates {}