import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import '../../../models/model.dart';
import '../../network/end_point.dart';
import 'shop_login_state.dart';

// Defining the ShopLoginCubit class that extends Cubit with ShopLoginStates
class ShopLoginCubit extends Cubit<ShopLoginStates> {
  // Constructor to initialize the ShopLoginCubit with an initial state
  ShopLoginCubit() : super(ShopLoginInitial());

  // Static method to get the instance of ShopLoginCubit from the context
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  // This model class for storing login response data
  ShopLoginModel? loginModel;

  // Method to handle user login
  void userLogin({
    // Required email parameter
    required String email,
    // Required password parameter
    required String password,
  }) {
    // Emitting state to notify listeners that login is in progress
    emit(ShopLoginLoadingState());

    // Making a POST request to the login endpoint
    DioHelper.postData(
      lang: 'ar',
      token: '',
      url: login,
      data: {
        // Sending email and password in the request body
        'email': email,
        'password': password,
      },
    ).then((value) {
      // Parsing the response and storing it in loginModel
      loginModel = ShopLoginModel.formJson(value.data);
      // Emitting state to notify listeners that login was successful
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error) {
      // Printing the error message
      print(error.toString());
      // Emitting state to notify listeners that an error occurred during login
      emit(ShopLoginErrorState(error.toString()));
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
