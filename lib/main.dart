import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/on_boarding_screen.dart';
import 'package:shop_app/modules/login_screen.dart';
import 'package:shop_app/shared/cubit/login/shop_login_cubit.dart';
import 'package:shop_app/shared/cubit/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop_state.dart';
import 'package:shop_app/shared/themes.dart';
import 'shared/cubit/observer.dart';
import 'shared/network/local/cash_helper.dart';
import 'shared/network/remote/dio_helper.dart';

// Main function
void main() async {
  // Ensuring Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Setting Bloc observer to monitor state changes
  Bloc.observer = MyBlocObserver();
  // Initializing Dio helper
  await DioHelper.init();
  // Initializing cache helper
  await CacheHelper.init();
  // Getting onboarding data from cache
  var onBoarding = await CacheHelper.getData(key: 'onBoarding');
  // Getting token data from cache
  var token = await CacheHelper.getData(key: 'token');
  // Determining which screen to start with in the app: HomeLayout, LoginScreen, or OnBoardingScreen
  Widget startWidget;

  // Checking if onboarding is not null, then go to login screen
  if (onBoarding != null) {
    // Checking if token is not null, then go to home screen
    if (token != null) {
      startWidget = const HomeLayout();
    } else {
      startWidget = const LoginScreen();
    }
  } else {
    // If user does not have token and onboarding is null, start with onboarding screen
    startWidget = const OnBoardingScreen();
  }

  // Running the app with the determined start widget
  runApp(MyApp(
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  Widget startWidget;

  MyApp({super.key, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopLoginCubit(),
        ),
        BlocProvider(
          // ..getHomeData this like make object and call with out make variable to saved this object
          create: (context) => ShopCubit()..getHomeData()..getCategoriesData(),
        ),
      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Shop Demo',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
