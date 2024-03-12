import 'package:flutter/material.dart';
import 'package:med_app/screens/onbording_1.dart';

import '../functions_user/login_logic.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      LoginLogic.init(context);
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          return const OnBoarding();
        }));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/IMG_8192.PNG',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
