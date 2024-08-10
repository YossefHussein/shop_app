// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app/modules/login_screen.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/shared/components/widget.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// This model is used to help add the image, title, and body for the onboarding screens
class BoardingModel {
  // This is the title of the onboarding screen
  final String title;
  // This is the image of the onboarding screen
  final String lottieImage;
  // This is the body of the onboarding screen
  final String body;

  // Constructor for BoardingModel with required parameters
  BoardingModel({
    required this.title,
    required this.lottieImage,
    required this.body,
  });
}

// Defining a stateful widget named OnBoardingScreen
class OnBoardingScreen extends StatefulWidget {
  // Defining a constant constructor with a key
  const OnBoardingScreen({super.key});

  // Overriding the createState method to create the state for the widget
  @override
  State<OnBoardingScreen> createState() => OnBoardingScreenState();
}

// State class for the OnBoardingScreen widget
class OnBoardingScreenState extends State<OnBoardingScreen> {
  // PageController to control the page view
  var boardController = PageController();

  // Boolean variable to check if the user is on the last page
  bool isLast = false;

  // List of boarding items for the onboarding screens
  List<BoardingModel> boarding = [
    BoardingModel(
      title: 'Feature 1',
      lottieImage: 'assets/animation/wired-flat-139-basket.json',
      body: 'More goods to buy',
    ),
    BoardingModel(
      title: 'Feature 2',
      lottieImage: 'assets/animation/wired-flat-146-trolley.json',
      body: 'Goods move to you In any time',
    ),
    BoardingModel(
      title: 'Feature 3',
      lottieImage: 'assets/animation/wired-flat-950-help-customers.json',
      body: 'Good customer help to user',
    ),
    BoardingModel(
      title: 'Feature 4',
      lottieImage: 'assets/animation/wired-flat-1339-sale.json',
      body: 'Good deal\'s for customer',
    ),
    BoardingModel(
      title: 'Feature 5',
      lottieImage: 'assets/animation/wired-flat-290-coin.json',
      body: 'Good goods with good sale\s',
    ),
  ];

  // Method to navigate to the login screen if the user completes the onboarding
  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value == true) {
        // If true, navigate to the LoginScreen
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }

  // Overriding the build method to build the widget tree
  @override
  Widget build(BuildContext context) {
    // Returning a Scaffold widget to define the structure of the screen
    return Scaffold(
      // Defining the AppBar of the Scaffold
      appBar: AppBar(
        // Defining the actions of the AppBar
        actions: [
          // Skip button if the user does not want to see the onboarding screens
          TextButton(
            style: ButtonStyle(
              textStyle: WidgetStateProperty.all(
                TextStyle(color: Colors.black),
              ),
            ),
            // Defining the onPressed callback for the TextButton
            onPressed: submit,
            // Setting the text of the TextButton
            child: Text('SKIP'),
          )
        ],
      ),
      // Defining the body of the Scaffold
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            // Expanded widget to see the animation of the onboarding screens
            Expanded(
              child: PageView.builder(
                controller: boardController,
                // ItemBuilder to build each item in the PageView
                itemBuilder: (context, index) => onBoardingItem(
                  model: boarding[index],
                ),
                // Method called when the page changes
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    // If the user is on the last page
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    // If the user is not on the last page
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                // Setting the item count to the length of the boarding list
                itemCount: boarding.length,
              ),
            ),
            Row(
              children: [
                // Adding style to the indicator of the onboarding screen
                SmoothPageIndicator(
                  controller: boardController,
                  // Setting the count to the length of the boarding list
                  count: boarding.length,
                  // Using ExpandingDotsEffect to style the SmoothPageIndicator
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: pColor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 8,
                    spacing: 5,
                  ),
                ),
                Spacer(),
                // FloatingActionButton for navigation
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      // If the user is on the last page, submit the data
                      submit();
                    } else {
                      // If the user is not on the last page, move to the next page
                      boardController.nextPage(
                        // Duration for the page transition
                        duration: Duration(milliseconds: 850),
                        // Curve for the page transition
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  // Setting the icon for the FloatingActionButton
                  child: Icon(Icons.arrow_forward_ios_outlined),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // Widget to build each onboarding item
  Widget onBoardingItem({
    // Required parameter to pass the model
    required BoardingModel model,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Passing the lottie animation
        Lottie.asset(model.lottieImage),
        Spacer(
          flex: 1,
        ),
        Text(
          // Passing the title
          model.title,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          // Passing the body
          model.body,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(
          flex: 2,
        ),
      ],
    );
  }
}
