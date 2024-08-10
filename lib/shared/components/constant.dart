import 'package:flutter/material.dart';

import '../../modules/login_screen.dart';
import 'widget.dart';
import '../network/local/cash_helper.dart';

logOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      value = true;
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  });
}

// this when call this variable save the token in inside
// to send when call the api for auth of api
String? token;

// function to print a long text in chunks of up to 800 characters each
void printFullText(String? text) {
  // define a regular expression pattern to match chunks of text with length from 1 to 800 characters
  final pattern = RegExp('.{1,800}');
  // use the pattern to find all matches in the input text
  // for each match, print the matched substring
  pattern.allMatches(text!).forEach((match) => print(match.group(0)));
}
