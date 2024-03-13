import 'package:flutter/material.dart';
import 'package:med_app/screens/doctor_list.dart';

class DoctorListWidget extends StatelessWidget {
  const DoctorListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const DoctorList()));
      },
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
                topRight: Radius.circular(10),
              ),
              child: Image.asset(
                'assets/images/home1.jpg',
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                SizedBox(width: 10),
                Text(
                  'Book\nAppointment',
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
