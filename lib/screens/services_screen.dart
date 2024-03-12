import 'package:flutter/material.dart';

class HospitalService {
  final String name;
  final String description;
  final String imageUrl;

  HospitalService({
    required this.name,
    required this.description,
    required this.imageUrl,
  });
}

// Sample service data
final List<HospitalService> services = [
  HospitalService(
    name: 'Emergency Care',
    description:
        'These include emergency medical care for patients with acute illnesses or injuries, such as trauma, heart attacks, strokes, or severe infections. Emergency departments are staffed 24/7 to provide immediate care.',
    imageUrl: 'assets/images/Emergency.webp',
  ),
  HospitalService(
    name: 'Radiology Services',
    description:
        'X-rays, MRIs, CT scans, ultrasounds, and other imaging procedures',
    imageUrl: 'assets/images/radiology services.jpeg',
  ),
  HospitalService(
    name: 'Inpatient Care',
    description:
        'Hospitals provide inpatient services for patients who require overnight stays or extended care for conditions that cannot be managed at home. This includes medical, surgical, psychiatric, and pediatric units.',
    imageUrl: 'assets/images/interpatientcare.jpeg',
  ),
  HospitalService(
    name: 'Outpatient Care',
    description:
        'Hospitals offer outpatient services for patients who do not require overnight stays. This includes diagnostic services (such as imaging and laboratory tests), consultations with specialists, and minor procedures performed in outpatient clinics.',
    imageUrl: 'assets/images/outerpatientcare.webp',
  ),
  HospitalService(
    name: 'Surgical Services',
    description:
        'Hospitals have operating rooms and surgical teams to perform a wide range of surgical procedures, including elective surgeries (such as joint replacements and hernia repairs) and emergency surgeries (such as appendectomies and trauma surgeries).',
    imageUrl: 'assets/images/surgicalservices.webp',
  ),
  HospitalService(
    name: 'Maternity Services',
    description:
        ' Hospitals provide maternity care for expectant mothers, including prenatal care, labor and delivery services, and postpartum care. Some hospitals also offer neonatal intensive care units (NICUs) for premature or critically ill newborns.',
    imageUrl: 'assets/images/maternityservices.jpeg',
  ),
  HospitalService(
    name: 'Intensive Care Units (ICUs)',
    description:
        'Hospitals have specialized units for patients who require intensive monitoring and treatment due to severe illnesses or injuries. This includes medical ICUs, surgical ICUs, and neonatal ICUs.',
    imageUrl: 'assets/images/icu.webp',
  ),
  HospitalService(
    name: 'Rehabilitation Services',
    description:
        'Hospitals provide rehabilitation services for patients recovering from injuries, surgeries, or medical conditions. This includes physical therapy, occupational therapy, speech therapy, and cardiac rehabilitation.',
    imageUrl: 'assets/images/rehabilation.jpg',
  ),
];

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Our Services'),
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

  Widget _buildServiceItem(BuildContext context, HospitalService service) {
    return InkWell(
      onTap: () {
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
  final HospitalService service;

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
