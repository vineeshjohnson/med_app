import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Terms and Conditions',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'By using the Mediflow application, you agree to abide by the following terms and conditions:',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 16.0),
            _buildSection(
              title: '1. Usage Agreement',
              content:
                  'You agree to use the Mediflow application in accordance with its intended purpose.',
            ),
            _buildSection(
              title: '2. Account Security',
              content:
                  'You are responsible for maintaining the security of your account credentials and ensuring unauthorized access is prevented.',
            ),
            _buildSection(
              title: '3. Appointment Booking',
              content:
                  'Appointment bookings made through the Mediflow application are subject to availability and confirmation by the healthcare provider.',
            ),
            _buildSection(
              title: '4. Cancellation Policy',
              content:
                  'Appointments can be canceled as per the cancellation policy of the healthcare provider.',
            ),
            _buildSection(
              title: '5. Privacy Policy',
              content:
                  'Your privacy is important to us. Please refer to our Privacy Policy for information on how we collect, use, and protect your personal data.',
            ),
            _buildSection(
              title: '6. Modifications',
              content:
                  'Mediflow reserves the right to modify or update these terms and conditions at any time without prior notice.',
            ),
            _buildSection(
              title: '7. Contact Information',
              content:
                  'If you have any questions or concerns regarding these terms and conditions, please contact us at contact@mediflow.com.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          content,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
