import 'package:flutter/material.dart';
import 'package:med_app/boxes.dart';
import 'package:med_app/hive/person.dart';
import 'package:med_app/screens/about_us.dart';
import 'package:med_app/screens/screen_login.dart';
import 'package:med_app/screens/show_profile.dart';
import 'package:med_app/screens/terms_conditions.dart';
import 'package:med_app/widgets/best_offers.dart';
import 'package:med_app/widgets/book_appointment.dart';
import 'package:med_app/widgets/check_appointment.dart';
import 'package:med_app/widgets/featured_services.dart';
import 'package:med_app/widgets/youtube_video.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Person? _userDetails;

  @override
  void initState() {
    _fetchUsername();
    super.initState();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DoctorListWidget(),
                  CheckAppo(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              BestOffers(),
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
              const FeaturedServices(),
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
