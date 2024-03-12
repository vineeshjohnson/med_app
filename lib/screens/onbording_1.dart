import 'package:flutter/material.dart';
import 'package:med_app/screens/components.dart';
import 'package:med_app/screens/screen_login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _controller = PageController();
  bool onLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      PageView(
        onPageChanged: (index) {
          setState(() {
            onLast = (index == 2);
          });
        },
        controller: _controller,
        children: const [
          OnBoardings1(),
          OnBoardings2(),
          OnBoardings3(),
        ],
      ),
      Container(
        alignment: const Alignment(0, 0.75),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  _controller.jumpToPage(2);
                },
                child: const Text(
                  'Skip',
                )),
            SmoothPageIndicator(
              controller: _controller,
              count: 3,
            ),
            onLast
                ? ElevatedButton(
                    onPressed: () {
                      // print('pressed');
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return const LoginScreen();
                      })); // Navigator.of(context)
                      //     .push(MaterialPageRoute(builder: (context) {
                      // return const LoginScreen();
                      // }));
                    },
                    child: const Text('Done'))
                : ElevatedButton(
                    onPressed: () {
                      _controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                    child: const Text('Next'))
          ],
        ),
      ),
    ]));
  }
}
