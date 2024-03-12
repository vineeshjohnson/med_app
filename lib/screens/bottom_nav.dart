import 'package:flutter/material.dart';
import 'package:med_app/screens/doctor_list.dart';
import 'package:med_app/screens/screen_bookings.dart';
import 'package:med_app/screens/screen_fav.dart';
import 'package:med_app/screens/screen_home.dart';
// import 'package:med_app/screens/show_profile.dart';
//import 'package:med_app/screens/show_profile.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  List<Widget> widgetList = [
    const HomeScreen(),
    const DoctorList(),
    const AppointmentListScreen(),
    const FavList(),
    // const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: widgetList[_selectedIndex],
        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.cyan.shade100,
          height: 80,
          elevation: 0,
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.medical_services_outlined), label: 'Doctors'),
            NavigationDestination(
                icon: Icon(Icons.local_hospital), label: 'Bookings'),
            NavigationDestination(
                icon: Icon(Icons.favorite), label: 'Favourite'),
            // NavigationDestination(icon: Icon(Icons.person), label: 'Profile')
          ],
        ),
      ),
    );
  }
}
