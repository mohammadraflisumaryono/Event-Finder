
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String userIdKey = 'userId';
  static const String tokenKey = 'token';
  static const String roleKey = 'role';

  // Save user data to SharedPreferences
  static Future<void> saveUserData(
      String userId, String token, String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(userIdKey, userId);
    await prefs.setString(tokenKey, token);
    await prefs.setString(roleKey, role);
  }

  static Future<Map<String, String?>> getAllUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'userId': prefs.getString(userIdKey),
      'token': prefs.getString(tokenKey),
      'role': prefs.getString(roleKey),
    };
  }

  // Get user ID from SharedPreferences
  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  // Get token from SharedPreferences
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  // Get role from SharedPreferences
  static Future<String?> getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(roleKey);
  }

  // Check if the user is logged in by checking userId, token, and role
  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString(userIdKey);
    String? token = prefs.getString(tokenKey);
    String? role = prefs.getString(roleKey);

    // Return true if all three values are present
    return userId != null && token != null && role != null;
  }

  // Clear the stored data (e.g., when logging out)
  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(userIdKey);
    await prefs.remove(tokenKey);
    await prefs.remove(roleKey);
  }
}
