import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/register_screen.dart';
import 'package:shop_app/shared/components/widget.dart';
import 'package:shop_app/shared/cubit/login/shop_login_cubit.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';

import '../shared/components/constant.dart';
import '../shared/cubit/login/shop_login_states.dart';
import '../shared/cubit/logup/shop_register_cubit.dart';

// Defining the StatefulWidget for the LoginScreen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// State class for the LoginScreen
class _LoginScreenState extends State<LoginScreen> {
  // GlobalKey for the login form
  var formKey = GlobalKey<FormState>();

  // Controllers for handling email and password input
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Providing the ShopLoginCubit to the widget tree
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        // Listening to state changes in ShopLoginCubit
        listener: (context, state) {
          // Handling login success state
          if (state is ShopLoginSuccessState) {
            // Checking if login was successful based on status
            if (state.loginModel.status == true) {
              // Saving token to local cache
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token;
                // Showing success message
                showToast(
                  message: '${state.loginModel.message}',
                  state: ToastStates.success,
                );
                navigateAndFinish(context, const HomeLayout());
              });
            } else {
              // Showing error message if login was not successful
              print(state.loginModel.message);
              showToast(
                message: '${state.loginModel.message}',
                state: ToastStates.error,
              );
            }
          }
        },
        // Building the UI based on current state
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Title and description
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Login',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.copyWith(
                                      color: Colors.black,
                                    ),
                              ),
                              Text(
                                'Login now to browse our hot offers',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.grey,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Email form field
                        formFieldWidget(
                          controller: emailController,
                          labelText: 'Email',
                          type: TextInputType.emailAddress,
                          // Validation function for email field
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter email';
                            }
                          },
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Password form field
                        formFieldWidget(
                          controller: passwordController,
                          labelText: 'Password',
                          type: TextInputType.visiblePassword,
                          suffixPressed: () {
                            // Toggling password visibility
                            ShopLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          // Passing current password visibility state
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          suffixIcon: Icon(ShopLoginCubit.get(context).suffix),
                          prefixIcon: const Icon(Icons.lock_outline),
                          // Validation function for password field
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter password';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // Conditional rendering based on loading state
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          // Button for submitting login credentials
                          builder: (context) => defaultButton(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                // Calling userLogin method from ShopLoginCubit
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'LogIn',
                          ),
                          // Showing loading indicator while logging in
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // Row for navigation to registration screen
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('don\'t have an account?'),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                child: const Text('Register'))
                          ],
                        ),
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
