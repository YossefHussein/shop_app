import 'package:shared_preferences/shared_preferences.dart';

// Defining a CacheHelper class to manage cached data
class CacheHelper {
  static late SharedPreferences sharedPref;

  static init() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  // save all the data type of the application
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    // if the value is a String, save it as a String
    if (value is String) return await sharedPref.setString(key, value);
    // if the value is an int, save it as an int
    if (value is int) return await sharedPref.setInt(key, value);
    // if the value is a bool, save it as a bool
    if (value is bool) return await sharedPref.setBool(key, value);
    // Otherwise, save it as a double
    return await sharedPref.setDouble(key, value);
  }

  // Function to get data from SharedPreferences
  static getData({required String key}) async {
    return await sharedPref.get(key);
  }

  // Function to remove data from SharedPreferences
  static Future<bool> removeData({required String key}) async {
    return await sharedPref.remove(key);
  }
}
