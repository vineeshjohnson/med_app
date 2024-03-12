import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:med_app/hive/appointment_model.dart';

class AdminAppointmentListScreen extends StatefulWidget {
  const AdminAppointmentListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminAppointmentListScreenState createState() =>
      _AdminAppointmentListScreenState();
}

class _AdminAppointmentListScreenState
    extends State<AdminAppointmentListScreen> {
  Box<AppointmentModel>? _appointmentBox;
  late List<AppointmentModel>? _appointments;

  @override
  void initState() {
    super.initState();
    _openBoxAndLoadAppointments();
  }

  Future<void> _openBoxAndLoadAppointments() async {
    await Hive.openBox<AppointmentModel>('appointmentBox');
    _appointmentBox = Hive.box<AppointmentModel>('appointmentBox');
    _appointments = _appointmentBox!.values.toList().cast<AppointmentModel>();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Appointments'),
      ),
      body:
          _appointments!.isEmpty ? _buildEmptyState() : _buildAppointmentList(),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text('No appointments found.'),
    );
  }

  Widget _buildAppointmentList() {
    return ListView.builder(
      itemCount: _appointments!.length,
      itemBuilder: (context, index) {
        final appointment = _appointments![index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appointment.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    appointment.doctorCategory,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Text(
                'Mobile number : ${appointment.mobilenumber}\n\nDoctor name : ${appointment.doctorName}\n\nDate:${appointment.selectedDate}\n\nTime:${appointment.selectedTime}',
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        );
      },
    );
  }
}
