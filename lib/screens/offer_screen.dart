import 'package:flutter/material.dart';

class HorizontalContainerListScreen extends StatelessWidget {
  const HorizontalContainerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offer zone'),
      ),
      body: ListView(
        children: [
          _buildHorizontalContainer('Container 1', 'assets/images/11.jpg'),
          _buildHorizontalContainer('Container 2', 'assets/image22.jpg'),
          _buildHorizontalContainer('Container 3', 'assets/image33.jpg'),
          // Add more containers as needed
        ],
      ),
    );
  }

  Widget _buildHorizontalContainer(String heading, String imagePath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            heading,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildImageContainer(imagePath),
              // Add more image containers or widgets as needed
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildImageContainer(String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
