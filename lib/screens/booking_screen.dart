import 'package:flutter/material.dart';
import 'package:med_app/hive/appointment_model.dart';
import 'package:med_app/boxes.dart';
import 'package:med_app/hive/person.dart';
import 'package:med_app/screens/bottom_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentSelectionScreen extends StatefulWidget {
  final String doctorName;
  final String doctorCategory;

  const AppointmentSelectionScreen({
    Key? key,
    required this.doctorName,
    required this.doctorCategory,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AppointmentSelectionScreenState createState() =>
      _AppointmentSelectionScreenState();
}

class _AppointmentSelectionScreenState
    extends State<AppointmentSelectionScreen> {
  @override
  void initState() {
    _fetchUsername();
    super.initState();
  }

  Person? _userDetails;
  DateTime? _selectedDate;
  String? _selectedTime;
  late String user;
  final List<String> timeSlots = [
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM',
    '06:00 PM',
  ];

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

  Future<String?> _loadUsernameFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('username');
    return userid!;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.blue,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _selectTime(String time) {
    setState(() {
      _selectedTime = time;
    });
  }

  Future<void> _confirmAppointment(BuildContext context) async {
    user = (await _loadUsernameFromSharedPreferences())!;
    if (_selectedDate != null && _selectedTime != null) {
      AppointmentModel appointmentModel = AppointmentModel(
        username: user,
        doctorName: widget.doctorName,
        doctorCategory: widget.doctorCategory,
        selectedDate:
            '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
        selectedTime: _selectedTime!,
        name: _userDetails!.name,
        mobilenumber: _userDetails!.mobileNumber,
      );

      appointment.add(appointmentModel);

      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Appointment Confirmation',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Doctor: ${widget.doctorName}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Category: ${widget.doctorCategory}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Time: $_selectedTime',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showBookingSuccessMessage(context);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 10,
            backgroundColor: Colors.white,
          );
        },
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Please select both date and time for the appointment.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _showBookingSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Booking successful!'),
        duration: Duration(seconds: 2),
      ),
    );

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
      return const BottomNav();
    }));
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    int currentTime = currentDate.hour;
    DateTime currentDateWithoutTime =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
    List<String> slotes = [];
    if (
        //_selectedDate != null &&
        _selectedDate == currentDateWithoutTime) {
      if (currentTime < 8) {
        slotes = [
          '10:00 AM',
          '11:00 AM',
          '12:00 PM',
          '02:00 PM',
          '03:00 PM',
          '04:00 PM',
          '05:00 PM',
          '06:00 PM',
        ];
      } else if (currentTime < 9) {
        slotes = [
          '11:00 AM',
          '12:00 PM',
          '02:00 PM',
          '03:00 PM',
          '04:00 PM',
          '05:00 PM',
          '06:00 PM',
        ];
      } else if (currentTime < 10) {
        slotes = [
          '02:00 PM',
          '03:00 PM',
          '04:00 PM',
          '05:00 PM',
          '06:00 PM',
        ];
      } else if (currentTime < 11) {
        slotes = [
          '03:00 PM',
          '04:00 PM',
          '05:00 PM',
          '06:00 PM',
        ];
      } else if (currentTime < 12) {
        slotes = [
          '04:00 PM',
          '05:00 PM',
          '06:00 PM',
        ];
      } else if (currentTime < 13) {
        slotes = [
          '05:00 PM',
          '06:00 PM',
        ];
      } else if (currentTime < 14) {
        slotes = [
          '06:00 PM',
        ];
      } else if (currentTime < 24) {
        slotes;
      }
    } else {
      slotes = timeSlots;
    }
    List<String> availableTimeSlots = List.from(slotes);

    List appointmentsForDoctor = appointment.values
        .where((appointment) =>
            appointment.doctorName == widget.doctorName &&
            _selectedDate != null &&
            appointment.selectedDate ==
                '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}')
        .toList();

    List bookedTimes = appointmentsForDoctor
        .map((appointment) => appointment.selectedTime)
        .toList();

    availableTimeSlots.removeWhere((time) => bookedTimes.contains(time));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Appointment Details'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Select Date:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: TextButton.icon(
                    onPressed: () => _selectDate(context),
                    icon: const Icon(Icons.calendar_today, color: Colors.blue),
                    label: Text(
                      _selectedDate != null
                          ? 'Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                          : 'Select Date',
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                const Text(
                  'Select Time:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                if (availableTimeSlots.isEmpty)
                  const Text(
                    'No time slots available',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  children: availableTimeSlots.map((time) {
                    return SizedBox(
                      width: 120,
                      child: ChoiceChip(
                        label: Text(time),
                        selected: _selectedTime == time,
                        onSelected: (selected) {
                          if (selected) {
                            _selectTime(time);
                          }
                        },
                        elevation: 4,
                        selectedColor: Colors.blue,
                        labelStyle: const TextStyle(fontSize: 16),
                        backgroundColor: Colors.grey[300],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                    );
                  }).toList(),
                ),
                if (availableTimeSlots.isNotEmpty) const SizedBox(height: 60),
                if (availableTimeSlots.isNotEmpty)
                  ElevatedButton(
                    onPressed: () {
                      _confirmAppointment(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text(
                      'Confirm Appointment',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
