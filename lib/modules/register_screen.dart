import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/shared/components/widget.dart';
import 'package:shop_app/shared/cubit/logup/shop_register_stats.dart';

import '../shared/components/constant.dart';
import '../shared/cubit/logup/shop_register_cubit.dart';
import '../shared/network/local/cash_helper.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailControl = TextEditingController();
  var phoneControl = TextEditingController();
  var nameControl = TextEditingController();
  var passwordControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            // Checking if login was successful based on status
            if (state.loginModel.status == true) {
              // Saving token to local cache
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data.token,
              ).then((value) {
                token = state.loginModel.data.token;
                // Showing success message
                showToast(
                  message: '${state.loginModel.message}',
                  state: ToastStates.success,
                );
                // Navigating to HomeLayout after successful login
                navigateAndFinish(context, HomeLayout());
              });
            } else {
              // Showing error message if login was not successful
              print(state.loginModel.message);
              showToast(
                message: state.loginModel.message,
                state: ToastStates.error,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Register now to Browse to Our Cool App',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        formFieldWidget(
                          controller: nameControl,
                          onChanged: (value) {
                            print(value);
                          },
                          onSubmits: (value) {},
                          type: TextInputType.name,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter name';
                            }
                          },
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.person),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        formFieldWidget(
                          controller: emailControl,
                          onChanged: (value) {
                            print(value);
                          },
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter email';
                            }
                          },
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        formFieldWidget(
                          controller: passwordControl,
                          labelText: 'Password',
                          type: TextInputType.visiblePassword,
                          suffixPressed: () {
                            // Toggling password visibility
                            ShopRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          // Passing current password visibility state
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          suffixIcon:
                              Icon(ShopRegisterCubit.get(context).suffix),
                          prefixIcon: const Icon(Icons.lock_outline),
                          // Validation function for password field
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter password';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        formFieldWidget(
                          controller: phoneControl,
                          onChanged: (value) {
                            print(value);
                          },
                          type: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter phone';
                            }
                          },
                          labelText: 'Phone',
                          prefixIcon: Icon(Icons.phone),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameControl.text,
                                  email: emailControl.text,
                                  password: passwordControl.text,
                                  phone: phoneControl.text,
                                );
                              }
                            },
                            text: 'Register',
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('If You Have,'),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, RegisterScreen());
                              },
                              child: Text('Login'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
