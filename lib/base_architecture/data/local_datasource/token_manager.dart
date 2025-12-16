import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  Future<void> saveToken(String key, String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(key, token);
  }

  Future<String?> getToken(String key) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString(key);

    return token;
  }

  Future<void> deleteToken(String key) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(key);
  }
}
