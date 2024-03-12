import 'package:flutter/material.dart';
import 'package:med_app/boxes.dart';
import 'package:med_app/hive/person.dart';
import 'package:med_app/screens/bottom_nav.dart';

class EditProfileScreen extends StatefulWidget {
  final String username;

  const EditProfileScreen({Key? key, required this.username}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _mobileNumberController;

  @override
  void initState() {
    super.initState();
    Person? currentUser = boxPerson.get('key_${widget.username}');
    _nameController = TextEditingController(text: currentUser?.name);
    _emailController = TextEditingController(text: currentUser?.email);
    _mobileNumberController =
        TextEditingController(text: currentUser?.mobileNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Name", _nameController, true),
            _buildTextField("Email", _emailController, false),
            _buildTextField("Mobile Number", _mobileNumberController, true),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _showConfirmationDialog,
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String labelText, TextEditingController controller, bool enabled) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
      
        enabled: enabled,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: const Text("Do you want to continue with these changes?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _updateProfile();
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  void _updateProfile() {
    // Get the current user
    Person? currentUser = boxPerson.get('key_${widget.username}');

    // Update the profile details
    if (currentUser != null) {
      currentUser.name = _nameController.text;
      currentUser.email = _emailController.text;
      currentUser.mobileNumber = _mobileNumberController.text;

      // Save the updated profile
      boxPerson.put('key_${widget.username}', currentUser);

      // Show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data updated successfully'),
        ),
      );

      // Navigate back to the profile page
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return const BottomNav();
      }));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }
}
