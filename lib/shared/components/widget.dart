
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/styles/colors.dart';

// default text form in app
Widget formFieldWidget({
  required TextEditingController? controller,
  required final String? labelText,
  final String? hintText,
  final String? helperText,
  final bool isPassword = false,
  required final FormFieldValidator<String>? validate,
  final ValueChanged<String>? onSubmits,
  final ValueChanged<String>? onChanged,
 required final TextInputType? type,
  required final Widget? prefixIcon,
  final Widget? suffixIcon,
  final VoidCallback? suffixPressed,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    onFieldSubmitted: onSubmits,
    onChanged: onChanged,
    obscureText: isPassword,
    // ignore: prefer_const_constructors
    decoration: InputDecoration(
      // prefixIconColor: Colors.white,
      // suffixIconColor: Colors.white,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon != null
          ? IconButton(onPressed: suffixPressed, icon: suffixIcon)
          : null,
      labelText: labelText,
      hintText: hintText,
      helperText: helperText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    validator: validate,
  );
}

Widget defaultButton({
  double width = double.infinity,
  bool isUpperCase = true,
  double radius = 0.0,
  required Function() onTap,
  required String text,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
          color: pColor, borderRadius: BorderRadius.circular(radius)),
      child: MaterialButton(
        onPressed: () {
          onTap();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

Future<bool?> showToast(
        {required String message, required ToastStates state}) =>
    Fluttertoast.showToast(
      msg: '${message}',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { error, success, waring }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.waring:
      color = Colors.amber;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
  }
  return color;
}

Widget myDivider() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        color: Colors.grey[300],
        height: 1,
      ),
    );

void navigateTo(context,Widget){
  Navigator.push(context,
      MaterialPageRoute(builder: (context)=> Widget
      ));
}

void navigateAndFinish(context,widget)=>
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context)=>widget),
          (route) => false);