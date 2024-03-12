import 'package:shared_preferences/shared_preferences.dart';

class LoginLogic {
  static Future<void> saveLoginDetails(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
  }
}
