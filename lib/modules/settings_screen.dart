import 'package:flutter/material.dart';
import 'package:shop_app/shared/constant.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        logOut(context),
        Text(
          'Settings Screen',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
