import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/components/widget.dart';
import 'package:shop_app/shared/cubit/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop_states.dart';

class SettingsScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessGetUserDataState) {
          nameController.text = state.loginModel.data.name;
          emailController.text = state.loginModel.data.email;
          phoneController.text = state.loginModel.data.phone;
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) {
            var model = ShopCubit.get(context).userModel;
            nameController.text = model!.data.name;
            emailController.text = model.data.email;
            phoneController.text = model.data.phone;
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (state is ShopLoadingUpdateUserDataState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 15,
                    ),
                    formFieldWidget(
                      controller: nameController,
                      labelText: 'Name User',
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      type: TextInputType.name,
                      prefixIcon: const Icon(Icons.person),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    formFieldWidget(
                      controller: emailController,
                      labelText: 'Email user',
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'email must not be empty';
                        }
                        return null;
                      },
                      type: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    formFieldWidget(
                      controller: phoneController,
                      labelText: 'Phon user',
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'phon must not be empty';
                        }
                        return null;
                      },
                      type: TextInputType.phone,
                      prefixIcon: const Icon(Icons.phone),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.get(context).updateUserData(
                            email: emailController.text,
                            phone: phoneController.text,
                            name: nameController.text,
                          );
                        }
                      },
                      text: 'update',
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultButton(
                      onTap: () {
                        logOut(context);
                      },
                      text: 'logout',
                    ),
                  ],
                ),
              ),
            );
          },
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
