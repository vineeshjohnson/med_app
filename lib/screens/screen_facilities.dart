import 'package:flutter/material.dart';

class Facilities extends StatefulWidget {
  const Facilities({super.key});

  @override
  State<Facilities> createState() => _FacilitiesState();
}

class _FacilitiesState extends State<Facilities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text('Hospital Facilities'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FacilityCard(
              icon: Icons.local_hospital,
              title: 'Emergency Room',
            ),
            FacilityCard(
              icon: Icons.local_pharmacy,
              title: 'Pharmacy',
            ),
            FacilityCard(
              icon: Icons.local_hotel,
              title: 'Inpatient Services',
            ),
            FacilityCard(
              icon: Icons.people,
              title: 'Outpatient Services',
            ),
            FacilityCard(
              icon: Icons.directions_run,
              title: 'Rehabilitation Center',
            ),
          ],
        ),
      ),
    );
  }
}

class FacilityCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const FacilityCard({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.blue,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
