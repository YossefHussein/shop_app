import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/on_boarding_screen.dart';
import 'package:shop_app/modules/login_screen.dart';
import 'package:shop_app/shared/cubit/login/shop_login_cubit.dart';
import 'package:shop_app/shared/cubit/shop_cubit.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'shared/components/constant.dart';
import 'shared/cubit/logup/shop_register_cubit.dart';
import 'shared/cubit/observer.dart';
import 'shared/cubit/shop_states.dart';
import 'shared/network/local/cash_helper.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async {
  // When you set main function async you should adding this for errors
  WidgetsFlutterBinding.ensureInitialized();
  // Observer is class watch the movement state of bloc
  Bloc.observer = MyBlocObserver();
  // Initializing Dio helper to call api
  await DioHelper.init();
  // Initializing cache helper to call from shared pref
  await CacheHelper.init();
  // Getting onboarding data from cache
  var onBoarding = await CacheHelper.getData(key: 'onBoarding');
  // Getting token data from cache
  token = await CacheHelper.getData(key: 'token');
  // Determining which screen to start with in the app: HomeLayout, LoginScreen, or OnBoardingScreen
  Widget startWidget;

  // Checking if onboarding is not null, then go to login screen
  if (onBoarding != null) {
    // Checking if token is not null, then go to home screen
    if (token != null) {
      startWidget =  HomeLayout();
    } else {
      startWidget =  LoginScreen();
    }
  } else {
    // If user does not have token and onboarding is null, start with onboarding screen
    startWidget =  OnBoardingScreen();
  }

  // Running the app with the determined start widget
  runApp(MyApp(
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  Widget startWidget;

  MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopLoginCubit(),
        ),
        BlocProvider(
          create: (context) => ShopRegisterCubit(),
        ),
        BlocProvider(
          // ..getHomeData this like make object and call with out make variable to saved this object
          // I get this method for call from the api
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavoriteData()
            ..getUserSettingsData(),
        ),
      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Shop Demo',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
