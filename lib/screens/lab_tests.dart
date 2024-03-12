import 'package:flutter/material.dart';

class LabTests {
  final String name;
  final String description;
  final String imageUrl;

  LabTests({
    required this.name,
    required this.description,
    required this.imageUrl,
  });
}

final List<LabTests> tests = [
  LabTests(
    name: 'Blood Tests',
    description:
        'Measures the number of red blood cells, white blood cells, and platelets in the blood. Its used to assess overall health and diagnose conditions such as anemia, infections, and blood disorders.',
    imageUrl: 'assets/images/Laboratary service.jpeg',
  ),
  LabTests(
    name: 'Urinalysis',
    description:
        'Analyzes a urine sample for abnormalities such as protein, glucose, blood cells, and bacteria. It helps diagnose urinary tract infections, kidney disorders, and other conditions.',
    imageUrl: 'assets/images/urineanalysis.jpg',
  ),
  LabTests(
    name: 'Basic Metabolic Panel (BMP)',
    description:
        'Checks electrolyte levels (sodium, potassium, chloride, bicarbonate), kidney function (creatinine, blood urea nitrogen), and glucose levels in the blood. It helps diagnose electrolyte imbalances, kidney disorders, and diabetes.',
    imageUrl: 'assets/images/BMP.jpg',
  ),
  LabTests(
    name: 'Comprehensive Metabolic Panel (CMP)',
    description:
        'Similar to BMP but includes additional tests such as liver function tests (bilirubin, alkaline phosphatase, alanine aminotransferase, aspartate aminotransferase). It assesses liver function, kidney function, and electrolyte balance.',
    imageUrl: 'assets/images/CMP.webp',
  ),
  LabTests(
    name: 'Lipid Profile',
    description:
        ' Measures levels of cholesterol, triglycerides, high-density lipoprotein (HDL), and low-density lipoprotein (LDL) in the blood. It helps assess the risk of heart disease and stroke.',
    imageUrl: 'assets/images/LPT.jpg',
  ),
  LabTests(
    name: 'Thyroid Function Tests',
    description:
        'Measures levels of thyroid hormones (T3, T4) and thyroid-stimulating hormone (TSH) to assess thyroid function. It helps diagnose thyroid disorders such as hypothyroidism and hyperthyroidism.',
    imageUrl: 'assets/images/TFT-1280x640.jpg',
  ),
  LabTests(
    name: 'Blood Glucose Test',
    description:
        'Measures the level of glucose (sugar) in the blood. Its used to diagnose and monitor diabetes and assess glucose metabolism.',
    imageUrl: 'assets/images/BGT.jpg',
  ),
  LabTests(
    name: 'Liver Function Tests (LFTs)',
    description:
        'Measures levels of enzymes, proteins, and other substances in the blood to assess liver function. It helps diagnose liver diseases such as hepatitis and cirrhosis.',
    imageUrl: 'assets/images/LFT.jpg',
  ),
];

class LabTestScreen extends StatelessWidget {
  const LabTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Laboratory'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: tests.length,
        itemBuilder: (context, index) {
          return _buildServiceItem(context, tests[index]);
        },
      ),
    );
  }

  Widget _buildServiceItem(BuildContext context, LabTests tests) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SurgeriesDetailScreen(
              labfunction: tests,
            ),
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
                  tests.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                tests.name,
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
  final LabTests labfunction;

  const SurgeriesDetailScreen({Key? key, required this.labfunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(labfunction.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(
                labfunction.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              labfunction.description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
