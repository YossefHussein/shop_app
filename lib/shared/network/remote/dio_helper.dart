import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  // static object from dio
  static Dio? dio;

  // add value (base option) 
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        // get data if there error 
        receiveDataWhenStatusError: true,
      ),
    );
  }

  // call the API and adding url of api and query of api
  static Future<Response?> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    return await dio?.get(
      url,
      queryParameters: query,
    );
  }
}
