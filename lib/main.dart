import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:med_app/hive/appointment_model.dart';
import 'package:med_app/hive/doctor_model.dart';
import 'package:med_app/boxes.dart';
import 'package:med_app/hive/person.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:med_app/screens/screen_splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(PersonAdapter());
  boxPerson = await Hive.openBox<Person>('personBox');

  Hive.registerAdapter(AppointmentModelAdapter());
  appointment = await Hive.openBox<AppointmentModel>('appointmentBox');

  Hive.registerAdapter(DoctorModelAdapter());
  doctor = await Hive.openBox<DoctorModel>('doctorModels');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'EBgaramond'),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}