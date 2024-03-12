import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:med_app/hive/appointment_model.dart';

class AppointmentListScreen extends StatefulWidget {
  const AppointmentListScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AppointmentListScreenState createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {
  Box<AppointmentModel>? _appointmentBox;
  List<AppointmentModel>? _appointments;

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

  void _deleteAppointment(AppointmentModel appointment) {
    _appointmentBox!.delete(appointment.key);
    _appointments!.remove(appointment);
    setState(() {});

    // Show SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Appointment canceled successfully.'),
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, AppointmentModel appointment) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Cancel Appointment"),
          content: Text(
              "Do you want to cancel the appointment with ${appointment.doctorName}?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Cancel Booking"),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteAppointment(appointment);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade100,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Appointments'),
      ),
      body: _appointments == null || _appointments!.isEmpty
          ? _buildEmptyState()
          : _buildAppointmentList(),
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
        return AppointmentItem(
          appointment: appointment,
          onPressed: () {
            _showDeleteConfirmationDialog(context, appointment);
          },
        );
      },
    );
  }
}

class AppointmentItem extends StatelessWidget {
  final AppointmentModel appointment;
  final VoidCallback onPressed;

  const AppointmentItem({
    Key? key,
    required this.appointment,
    required this.onPressed,
  }) : super(key: key);

  DateTime parseDate(String dateString) {
    List<String> parts = dateString.split('/');
    if (parts.length == 3) {
      int day = int.tryParse(parts[0]) ?? 1;
      int month = int.tryParse(parts[1]) ?? 1;
      int year = int.tryParse(parts[2]) ?? DateTime.now().year;
      return DateTime(year, month, day);
    }
    // Return current date if parsing fails
    return DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
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
                appointment.doctorName,
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
            'Booked Date: ${DateFormat('dd MMMM yyyy').format(parseDate(appointment.selectedDate))}\n\nBooked Time: ${appointment.selectedTime}',
            style: const TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 10.0),
          TextButton(
            onPressed: onPressed,
            child: const Text('Cancel Booking'),
          ),
        ],
      ),
    );
  }
}
