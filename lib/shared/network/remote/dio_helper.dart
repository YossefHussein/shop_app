import 'package:dio/dio.dart';

// Defining a helper class for Dio operations
class DioHelper {
  // Declaring a static Dio instance
  static late Dio dio;

  // Initializing the Dio instance with base options
  static init() {
    dio = Dio(
      BaseOptions(
        // Setting the base URL for the API
        baseUrl: 'https://student.valuxapps.com/api/',
        // Option to receive data even when there is a status error
        receiveDataWhenStatusError: true,
      ),
    );
  }

  // Method to get data from the API
  static Future<Response> getData({
    required String url, // Required endpoint URL
    required Map<String, dynamic>? query, // Required query parameters
    String lang = 'ar', // Default language parameter
    String? token, // Optional token for authorization
  }) async {
    // Setting headers for the Dio request
    // Note: Adding headers here will overwrite base options headers
    dio.options.headers = {
      'Content-Type': 'application/json', // Setting content type to JSON
      'lang': lang, // Setting language header
      'Authorization': token ?? '' // Setting authorization token if available
    };
    // Making a GET request with the provided URL and query parameters
    return await dio.get(
      url,
      queryParameters: query ?? null, // Using null if query is not provided
    );
  }

  // Method to post data to the API
  static Future<Response> postData({
    required String url, // Required endpoint URL
    Map<String, dynamic>? query, // Optional query parameters
    required Map<String, dynamic> data, // Required data to be sent
    String lang = 'ar', // Default language parameter
    String? token, // Optional token for authorization
  }) async {
    // Setting headers for the Dio request
    dio.options.headers = {
      'Content-Type': 'application/json', // Setting content type to JSON
      'lang': lang, // Setting language header
      'Authorization': token ?? '' // Setting authorization token if available
    };
    // Making a POST request with the provided URL, query parameters, and data
    return dio.post(url, queryParameters: query, data: data);
  }

  // Method to put (update) data to the API
  static Future<Response> putData({
    required String url, // Required endpoint URL
    Map<String, dynamic>? query, // Optional query parameters
    required Map<String, dynamic> data, // Required data to be updated
    String lang = 'ar', // Default language parameter
    String? token, // Optional token for authorization
  }) async {
    // Setting headers for the Dio request
    dio.options.headers = {
      'Content-Type': 'application/json', // Setting content type to JSON
      'lang': lang, // Setting language header
      'Authorization': token ?? '' // Setting authorization token if available
    };
    // Making a PUT request with the provided URL, query parameters, and data
    return dio.put(url, queryParameters: query, data: data);
  }
}
