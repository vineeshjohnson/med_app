import 'package:flutter/material.dart';

class OnBoardings1 extends StatelessWidget {
  const OnBoardings1({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            'assets/images/Hospital building-bro.png',
            height: 600,
          ),
        ],
      ),
    );
  }
}

class OnBoardings2 extends StatefulWidget {
  const OnBoardings2({super.key});

  @override
  State<OnBoardings2> createState() => _OnBoardings2State();
}

class _OnBoardings2State extends State<OnBoardings2> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/Hospital wheelchair-bro.png',
    );
  }
}

class OnBoardings3 extends StatefulWidget {
  const OnBoardings3({super.key});

  @override
  State<OnBoardings3> createState() => _OnBoardings3State();
}

class _OnBoardings3State extends State<OnBoardings3> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/Doctors-bro.png',
      // fit: BoxFit.cover,
    );
  }
}
