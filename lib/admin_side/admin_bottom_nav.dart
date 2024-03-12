import 'package:flutter/material.dart';
import 'package:med_app/admin_side/add_doctor.dart';
import 'package:med_app/admin_side/admin_categories.dart';
import 'package:med_app/admin_side/bookings_admin.dart';
import 'package:med_app/admin_side/doctor_list_admi.dart';

class AdminBottomNav extends StatefulWidget {
  const AdminBottomNav({Key? key}) : super(key: key);

  @override
  State<AdminBottomNav> createState() => _AdminBottomNavState();
}

class _AdminBottomNavState extends State<AdminBottomNav> {
  int _selectedIndex = 0;
  List<Widget> widgetList = [
    const Departments(),
    const AddDoctorScreen(),
    const DoctorListScreen(),
    const AdminAppointmentListScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: widgetList[_selectedIndex],
        bottomNavigationBar: NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.medical_information), label: 'Department'),
            NavigationDestination(
                icon: Icon(Icons.medical_services_rounded),
                label: 'Add Doctor'),
            NavigationDestination(icon: Icon(Icons.person_2), label: 'Doctors'),
            NavigationDestination(
                icon: Icon(Icons.settings), label: 'User Bookings')
          ],
        ),
      ),
    );
  }
}
