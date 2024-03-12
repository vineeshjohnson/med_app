import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import '../hive/doctor_model.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DoctorListScreenState createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  Box<DoctorModel>? doctorBox;

  @override
  void initState() {
    super.initState();
    openBox();
  }

  Future<void> openBox() async {
    doctorBox = await Hive.openBox<DoctorModel>('doctormodels');
    setState(() {});
  }

  Future<void> deleteDoctor(int index) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Doctor'),
          content: Text(
              'Are you sure you want to delete ${doctorBox?.getAt(index)?.name}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                await doctorBox?.deleteAt(index);
                setState(() {});
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop(); // Close the alert dialog
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the alert dialog
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  void editDoctor(int index) {
    DoctorModel doctor = doctorBox!.getAt(index)!;
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Set to true to show the bottom sheet at the top
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: DoctorEditBottomSheet(
            doctor: doctor,
            onUpdate: () {
              setState(() {});
              Navigator.pop(context); // Close the bottom sheet after updating
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.shade200,
        centerTitle: true,
        title: const Text('Doctors'),
      ),
      body: doctorBox == null
          ? const Center(child: CircularProgressIndicator())
          : doctorBox!.isEmpty
              ? Center(
                  child: Image.asset(
                    'assets/images/No data-amico.png',
                    width: 200,
                    height: 200,
                  ),
                )
              : ListView.builder(
                  itemCount: doctorBox!.length,
                  itemBuilder: (context, index) {
                    final doctor = doctorBox!.getAt(index);
                    return DoctorListItem(
                      doctor: doctor!,
                      onDelete: () => deleteDoctor(index),
                      onEdit: () => editDoctor(index),
                    );
                  },
                ),
    );
  }
}

class DoctorListItem extends StatelessWidget {
  final DoctorModel doctor;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const DoctorListItem({
    super.key,
    required this.doctor,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.cyan[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          if (doctor.imagePath.isNotEmpty)
            CircleAvatar(
              backgroundImage: FileImage(File(doctor.imagePath)),
            ),
          const SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctor.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(doctor.category),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: onEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

class DoctorEditBottomSheet extends StatefulWidget {
  final DoctorModel doctor;
  final VoidCallback onUpdate;

  const DoctorEditBottomSheet({
    super.key,
    required this.doctor,
    required this.onUpdate,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DoctorEditBottomSheetState createState() => _DoctorEditBottomSheetState();
}

class _DoctorEditBottomSheetState extends State<DoctorEditBottomSheet> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _experienceController;

  File? _image;
  final picker = ImagePicker();
  String? _selectedCategory;
  List<String> _categories = [];
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.doctor.name);
    // _categoryController = TextEditingController(text: widget.doctor.category);
    _descriptionController =
        TextEditingController(text: widget.doctor.description);
    _experienceController =
        TextEditingController(text: widget.doctor.experience);
    loadCategories();
  }

  Future<void> loadCategories() async {
    final box = await Hive.openBox<String>('categories');
    setState(() {
      _categories = box.values.toList();
      // Set the initial value of the selected category
      _selectedCategory = widget.doctor.category;
    });
  }

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Edit Doctor',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: getImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? const Icon(Icons.add_a_photo, size: 50)
                    : null,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
              items: _categories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _experienceController,
              decoration: const InputDecoration(labelText: 'Experience'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Update the doctor data and close the bottom sheet
                widget.doctor.name = _nameController.text;
                widget.doctor.category =
                    _selectedCategory!; // Update with selected category
                widget.doctor.description = _descriptionController.text;
                widget.doctor.experience = _experienceController.text;
                if (_image != null) {
                  widget.doctor.imagePath = _image!.path;
                }
                widget.onUpdate();
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
