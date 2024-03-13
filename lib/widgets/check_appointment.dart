import 'package:flutter/material.dart';
import 'package:med_app/screens/screen_bookings.dart';

class CheckAppo extends StatelessWidget {
  const CheckAppo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
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
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
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
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
