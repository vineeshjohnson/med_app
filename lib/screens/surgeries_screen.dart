import 'package:flutter/material.dart';

// Define a model for a hospital service
class Surgeries {
  final String name;
  final String description;
  final String imageUrl;

  Surgeries({
    required this.name,
    required this.description,
    required this.imageUrl,
  });
}

// Sample service data
final List<Surgeries> services = [
  Surgeries(
    name: 'Orthopedic Surgery',
    description:
        'This branch of surgery deals with conditions affecting the musculoskeletal system. Surgeons in this field may perform procedures such as joint replacements, fracture repairs, and spine surgeries.',
    imageUrl: 'assets/images/orthopediacsurgery.jpeg',
  ),
  Surgeries(
    name: 'Cardiac Surgery',
    description:
        'Cardiac surgeons specialize in procedures related to the heart and blood vessels. This can include bypass surgery, heart valve repair or replacement, and heart transplant surgeries.',
    imageUrl: 'assets/images/cardiacsurgery.jpg',
  ),
  Surgeries(
    name: 'Neurosurgery',
    description:
        'Neurosurgeons focus on treating conditions of the nervous system, including the brain, spinal cord, and peripheral nerves. Common procedures include brain tumor removal, spinal fusion, and treatment of neurological trauma.',
    imageUrl: 'assets/images/Nuerosurgery.jpg',
  ),
  Surgeries(
    name: 'Plastic Surgery',
    description:
        'Plastic surgeons perform procedures to reconstruct or alter the appearance of body parts. This can include cosmetic procedures such as facelifts and breast augmentation, as well as reconstructive surgeries for trauma or birth defects.',
    imageUrl: 'assets/images/plastic surgery.jpg',
  ),
  Surgeries(
    name: 'General Surgery',
    description:
        'General surgeons are trained to perform a wide range of surgical procedures across various areas of the body. Common surgeries include appendectomies, gallbladder removal, and hernia repairs.',
    imageUrl: 'assets/images/general surgery.jpg',
  ),
  Surgeries(
    name: 'Gynecological Surgery',
    description:
        'Gynecological surgeons specialize in procedures related to the female reproductive system. This can include hysterectomies, ovarian cyst removal, and procedures to treat conditions such as endometriosis or fibroids.',
    imageUrl: 'assets/images/gynosurgeries.jpg',
  ),
];

class SurgeriesScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const SurgeriesScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Surgery facilities'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return _buildServiceItem(context, services[index]);
        },
      ),
    );
  }

  Widget _buildServiceItem(BuildContext context, Surgeries service) {
    return InkWell(
      onTap: () {
        // Navigate to the detailed screen passing the selected service
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SurgeriesDetailScreen(service: service),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.asset(
                  service.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                service.name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SurgeriesDetailScreen extends StatelessWidget {
  final Surgeries service;

  const SurgeriesDetailScreen({Key? key, required this.service})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(service.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(
                service.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              service.description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
