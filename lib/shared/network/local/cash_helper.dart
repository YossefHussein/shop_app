import 'package:shared_preferences/shared_preferences.dart';

// Defining a CacheHelper class to manage cached data
class CacheHelper {
  // Declaring a static late variable for SharedPreferences instance
  static late SharedPreferences sharedPref;

  // Initializing the SharedPreferences instance asynchronously
  static init() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  // Function to save data of any type in SharedPreferences
  // This function saves all data types
  static Future<bool> saveData({
    // Declaring a required key of type String
    required String key,
    // Declaring a required dynamic value
    required dynamic value,
  }) async {
    // If the value is a String, save it as a String
    if (value is String) return await sharedPref.setString(key, value);
    // If the value is an int, save it as an int
    if (value is int) return await sharedPref.setInt(key, value);
    // If the value is a bool, save it as a bool
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
