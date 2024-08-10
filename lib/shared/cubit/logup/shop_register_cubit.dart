import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import '../../../models/login_model.dart';
import '../../network/end_point.dart';
import '../login/shop_login_cubit.dart';
import 'shop_register_stats.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitial());
   static ShopRegisterCubit get(context) => BlocProvider.of(context);

  // This model class for storing login response data
  ShopLoginModel? loginModel;

  // Method to handle user login
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    // Emitting state to notify listeners that login is in progress
    emit(ShopRegisterLoadingState());

    // Making a POST request to the login endpoint
    DioHelper.postData(
      token: token,
      
      url: register,
      data: {
        // Sending email and password in the request body
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      // Parsing the response and storing it in loginModel
      loginModel = ShopLoginModel.formJson(value.data);
      // Emitting state to notify listeners that login was successful
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error) {
      // Printing the error message
      print(error.toString());
      // Emitting state to notify listeners that an error occurred during login
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  // Icon for toggling password visibility
  IconData suffix = Icons.visibility_off_outlined;

  // Boolean to keep track of whether the password is visible or not
  bool isPassword = true;

  // Method to change the password visibility
  void changePasswordVisibility() {
    // Toggling the isPassword boolean
    isPassword = !isPassword;
    // Updating the suffix icon based on the new value of isPassword
    suffix = isPassword == true
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    // Emitting state to notify listeners that the password visibility has changed
    emit(ShopChangePasswordVisibility());
  }
}

