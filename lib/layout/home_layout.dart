import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search_screen.dart';
import 'package:shop_app/shared/components/widget.dart';
import 'package:shop_app/shared/cubit/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop_state.dart';

// Defining a stateless widget named HomeLayout
class HomeLayout extends StatelessWidget {
  // Defining a constant constructor with a key
  const HomeLayout({super.key});
  @override
  Widget build(BuildContext context) {
    // Returning a BlocConsumer widget to listen to and build the UI based on ShopCubit state
    return BlocConsumer<ShopCubit, ShopStates>(
      // Defining an empty listener function
      listener: (context, state) {},
      // Defining the builder function to build the UI
      builder: (context, state) {
        // Getting the ShopCubit instance from the context
        var cubit = ShopCubit.get(context);
        // Returning a Scaffold widget to define the structure of the screen
        return Scaffold(
          // Defining the AppBar of the Scaffold
          appBar: AppBar(
            // Setting the title of the AppBar
            title: Text(
              'Salla',
              // Applying a text style from the current theme with a custom color
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.black,
                  ),
            ),
            // Defining the actions of the AppBar
            actions: [
              // Adding an IconButton to the AppBar
              IconButton(
                  // Defining the onPressed callback for the IconButton
                  onPressed: () {
                    // Navigating to the SearchScreen when the button is pressed
                    navigateTo(context, SearchScreen());
                  },
                  // Setting the icon of the IconButton
                  icon: Icon(Icons.search_outlined))
            ],
          ),
          // Setting the body of the Scaffold to the current bottom screen of the cubit
          body: cubit.bottomScreen[cubit.currentIndex],
          // Defining the BottomNavigationBar of the Scaffold
          bottomNavigationBar: BottomNavigationBar(
            // Defining the onTap callback for the BottomNavigationBar
            onTap: (index) {
              // Changing the current bottom index in the cubit
              cubit.changeBottom(index);
            },
            // Setting the current index of the BottomNavigationBar
            currentIndex: cubit.currentIndex,
            // Defining the items of the BottomNavigationBar
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_filled,
                ),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.apps_outlined,
                ),
                label: 'category',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_outline,
                ),
                label: 'favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_outlined,
                ),
                label: 'settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
