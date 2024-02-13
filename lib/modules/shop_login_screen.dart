import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/widget.dart';

class ShopLoginScreen extends StatefulWidget {
  const ShopLoginScreen({super.key});

  @override
  State<ShopLoginScreen> createState() => _ShopLoginScreenState();
}

class _ShopLoginScreenState extends State<ShopLoginScreen> {
  TextEditingController controller = TextEditingController();

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            'Login',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Text('Login now to browser our hot offers'),
          formFieldWidget(
            controller: controller,
            labelText: 'email',
            type: TextInputType.emailAddress,
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
    );
  }
}
