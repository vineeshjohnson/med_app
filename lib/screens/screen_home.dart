import 'package:flutter/material.dart';
import 'package:med_app/boxes.dart';
import 'package:med_app/hive/person.dart';
import 'package:med_app/screens/about_us.dart';
import 'package:med_app/screens/doctor_list.dart';
import 'package:med_app/screens/lab_tests.dart';
import 'package:med_app/screens/screen_bookings.dart';
import 'package:med_app/screens/screen_login.dart';
import 'package:med_app/screens/services_screen.dart';
import 'package:med_app/screens/show_profile.dart';
import 'package:med_app/screens/surgeries_screen.dart';
import 'package:med_app/screens/terms_conditions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:async';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  late Timer _timer;
  Person? _userDetails;
  final String url = 'https://www.rajagirihospital.com/';

  @override
  void initState() {
    _fetchUsername();
    super.initState();
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
  }

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

  Future<void> _fetchUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    if (username != null) {
      _fetchUserDetails(username);
    }
  }

  Future<void> _fetchUserDetails(String username) async {
    Person? person = boxPerson.get('key_$username');
    if (person != null) {
      setState(() {
        _userDetails = person;
      });
    }
  }

  Future<void> _logout() async {
    final confirmLogout = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Return false if cancel
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Return true if confirm
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );

    if (confirmLogout == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
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
    return Scaffold(
      appBar: AppBar(
        //leading: Text('hey ${_userDetails!.name} '),
        // leading: const Icon(Icons.person),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'about':
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const AboutUsPage();
                  }));
                  break;
                case 'terms':
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const TermsAndConditionsPage();
                  }));
                  break;
                case 'profile':
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const ProfilePage();
                  }));
                  break;
                case 'logout':
                  _logout();

                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'about',
                child: Text('About'),
              ),
              const PopupMenuItem<String>(
                value: 'terms',
                child: Text('Terms and Conditions'),
              ),
              const PopupMenuItem<String>(
                value: 'profile',
                child: Text('User Profile'),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Colors.indigo.shade300,
        // centerTitle: true,
        title: Text(
          '  Welcome\n${_userDetails?.name ?? 'User'} ',
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '        Your health our priority',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const DoctorList();
                    })),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: .4),
                        color: Colors.white,
                      ),
                      height: 250,
                      width: 170,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Image.asset(
                              'assets/images/home1.jpg',
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Row(
                            children: [
                              SizedBox(width: 10),
                              Text(
                                'Book\nAppointment',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const AppointmentListScreen();
                    })),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: .4),
                        color: Colors.white,
                      ),
                      height: 250,
                      width: 170,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Image.asset(
                              'assets/images/choose health.webp',
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Row(
                            children: [
                              SizedBox(width: 10),
                              Text(
                                'Check Your\nAppointments',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
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
                          'Visit our website for new offers,health updates',
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
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) {
                  //   return HorizontalContainerListScreen();
                  // })),
                  child: SizedBox(
                    height: 200.0,
                    child: PageView(
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      children: const [
                        CurvedCard(
                          image: 'assets/images/11.jpg',
                          // text:
                          //     'Unlock exclusive medical benefits with our premium membership',
                        ),
                        CurvedCard(
                          image: 'assets/images/22.jpg',
                          // text:
                          //     'Unlock exclusive medical benefits with our premium membership',
                        ),
                        CurvedCard(
                          image: 'assets/images/33.jpg',
                          // text:
                          //     'Unlock exclusive medical benefits with our premium membership',
                        ),
                        CurvedCard(
                          image: 'assets/images/44.jpg',
                          // text:
                          //     'Unlock exclusive medical benefits with our premium membership',
                        ),
                        CurvedCard(
                          image: 'assets/images/55.jpg',
                          // text:
                          //     'Unlock exclusive medical benefits with our premium membership',
                        ),
                        CurvedCard(
                          image: 'assets/images/55.jpg',
                          // text:
                          //     'Unlock exclusive medical benefits with our premium membership',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //const SizedBox(height: 10.0),
              Container(
                height: 60,
                width: double.infinity,
                color: const Color.fromARGB(255, 8, 67, 116),
              ),
              const SizedBox(
                height: 35,
              ),
              //
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: const Icon(
                      Icons.star_border_rounded,
                      size: 32,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Featured servies',
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const ServicesScreen();
                    })),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: .4),
                        color: Colors.white,
                      ),
                      height: 120,
                      width: 100,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Image.asset(
                              'assets/images/medicines.webp',
                              height: 90,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SizedBox(width: 10),
                              Text(
                                'Services',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const LabTestScreen();
                    })),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: .4),
                        color: Colors.white,
                      ),
                      height: 120,
                      width: 100,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Image.asset(
                              'assets/images/labtests.webp',
                              height: 90,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SizedBox(width: 10),
                              Text(
                                'Lab Tests',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const SurgeriesScreen();
                    })),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: .4),
                        color: Colors.white,
                      ),
                      height: 120,
                      width: 100,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Image.asset(
                              'assets/images/surgeries.webp',
                              height: 90,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SizedBox(width: 10),
                              Text(
                                'Surgeries',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: const Icon(
                      Icons.local_hospital_outlined,
                      size: 32,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Explore our Community',
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const YoutubePlayerWidget(),
            ],
          ),
        ),
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

class SimpleCard extends StatelessWidget {
  final Color color;

  const SimpleCard({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Center(
        child: Text(
          'List Item',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class ScrollableContainer extends StatelessWidget {
  final Color color;
  // final Icon icons;
  final String icon;

  const ScrollableContainer(
      {super.key, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(child: Image.asset(icon)),
    );
  }
}

class YoutubePlayerWidget extends StatefulWidget {
  const YoutubePlayerWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _YoutubePlayerWidgetState createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'M9Kh4azMJ08', // Replace with your YouTube video ID
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        progressColors: const ProgressBarColors(
          playedColor: Colors.blue,
          handleColor: Colors.blueAccent,
        ),
        onReady: () {
          // Add your logic here when the video is ready
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
