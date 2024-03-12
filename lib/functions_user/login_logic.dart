import 'package:flutter/material.dart';
import 'package:med_app/screens/bottom_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginLogic {
  static Future<void> init(BuildContext context) async {
    await initSharedPreferences();
    // ignore: use_build_context_synchronously
    await _checkLoggedIn(context);
  }

  static Future<void> initSharedPreferences() async {}

  static Future<Map<String, String>> getLoginDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username') ?? '';
    final password = prefs.getString('password') ?? '';
    return {'username': username, 'password': password};
  }

  static Future<void> _checkLoggedIn(BuildContext context) async {
    final loginDetails = await getLoginDetails();
    if (loginDetails['username']?.isNotEmpty == true &&
        loginDetails['password']?.isNotEmpty == true) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const BottomNav()),
      );
    }
  }

  static void saveLoginDetails(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
  }
}
