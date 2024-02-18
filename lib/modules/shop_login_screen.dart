import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/widget.dart';

class ShopLoginScreen extends StatefulWidget {
  const ShopLoginScreen({super.key});

  @override
  State<ShopLoginScreen> createState() => _ShopLoginScreenState();
}

class _ShopLoginScreenState extends State<ShopLoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Login',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.grey),
            ),
            const Text('Login now to browser our hot offers'),
            SizedBox(
              height: 20,
            ),
            // email field
            formFieldWidget(
              controller: emailController,
              labelText: 'email',
              type: TextInputType.emailAddress,
              suffixIcon: Icon(Icons.email),
              validate: (String? value) {
                if (value!.isEmpty) {
                  return 'Please enter email';
                } else {
                  return '';
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            formFieldWidget(
              controller: emailController,
              labelText: 'email',
              type: TextInputType.emailAddress,
              suffixIcon: Icon(Icons.email),
              validate: (String? value) {
                if (value!.isEmpty) {
                  return 'Please enter email';
                } else {
                  return '';
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
