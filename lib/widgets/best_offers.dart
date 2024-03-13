import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BestOffers extends StatefulWidget {
  const BestOffers({super.key});

  @override
  State<BestOffers> createState() => _BestOffersState();
}

class _BestOffersState extends State<BestOffers> {
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_pageController.page == 5) {
        _pageController.jumpToPage(0);
      } else {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
    super.initState();
  }

  final PageController _pageController = PageController();
  final String url = 'https://www.rajagirihospital.com/';

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch $url'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 90,
            width: double.infinity,
            color: const Color.fromARGB(255, 8, 67, 116),
            child: const Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: Icon(
                    Icons.percent,
                    size: 15,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Best Offers',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Visit our website for new offers',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 8, 67, 116),
            child: GestureDetector(
              onTap: () => _launchURL(url),
              child: SizedBox(
                height: 200.0,
                child: PageView(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  children: const [
                    CurvedCard(
                      image: 'assets/images/11.jpg',
                    ),
                    CurvedCard(
                      image: 'assets/images/22.jpg',
                    ),
                    CurvedCard(
                      image: 'assets/images/33.jpg',
                    ),
                    CurvedCard(
                      image: 'assets/images/44.jpg',
                    ),
                    CurvedCard(
                      image: 'assets/images/55.jpg',
                    ),
                    CurvedCard(
                      image: 'assets/images/55.jpg',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 60,
            width: double.infinity,
            color: const Color.fromARGB(255, 8, 67, 116),
          ),
        ],
      ),
    );
  }
}

class CurvedCard extends StatelessWidget {
  final String image;
  // final String text;

  const CurvedCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      width: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              image,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
