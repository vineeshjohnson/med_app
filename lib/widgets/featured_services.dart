import 'package:flutter/material.dart';
import 'package:med_app/screens/lab_tests.dart';
import 'package:med_app/screens/services_screen.dart';
import 'package:med_app/screens/surgeries_screen.dart';

class FeaturedServices extends StatelessWidget {
  const FeaturedServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () =>
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
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
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () =>
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
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
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () =>
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
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
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
