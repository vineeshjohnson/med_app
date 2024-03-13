import 'package:flutter/material.dart';
import 'package:med_app/screens/doctorlist_hive.dart';
import 'package:med_app/widgets/doctor_list_item.dart';
import '../hive/doctor_model.dart';
import 'doctor_details.dart';

class DoctorList extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const DoctorList({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  final DoctorDatabase _doctorDatabase = DoctorDatabase();
  final TextEditingController _searchController = TextEditingController();
  List<DoctorModel>? _filteredDoctors;
  List<String> _categories = [];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _initDoctorBox();
  }

  Future<void> _initDoctorBox() async {
    await _doctorDatabase.openBox();
    _filteredDoctors = _doctorDatabase.getAllDoctors();

    List<DoctorModel> allDoctors = _doctorDatabase.getAllDoctors();
    Set<String> categorySet = {};
    for (var doctor in allDoctors) {
      categorySet.add(doctor.category);
    }
    _categories = categorySet.toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.indigo.shade300,
        centerTitle: true,
        title: const Text('Doctors'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search Doctor',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _filteredDoctors = _doctorDatabase.searchDoctors(value);
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                      if (_selectedCategory == 'All Doctors') {
                        _filteredDoctors = _doctorDatabase.getAllDoctors();
                      } else {
                        _filteredDoctors = _doctorDatabase
                            .getDoctorsByCategory(_selectedCategory!);
                      }
                    });
                  },
                  items: [
                    const DropdownMenuItem<String>(
                      value: 'All Doctors',
                      child: Text('All Doctors'),
                    ),
                    ..._categories
                        .map<DropdownMenuItem<String>>((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                  ],
                  hint: const Text('All Doctors'),
                ),
              ],
            ),
          ),
          _filteredDoctors == null
              ? const Center(child: CircularProgressIndicator())
              : _buildDoctorList(),
        ],
      ),
    );
  }

  Widget _buildDoctorList() {
    return Expanded(
      child: _filteredDoctors!.isEmpty
          ? Center(
              child: Image.asset(
                'assets/images/No data-amico.png',
                width: 200,
                height: 200,
              ),
            )
          : ListView.builder(
              itemCount: _filteredDoctors!.length,
              itemBuilder: (context, index) {
                final doctor = _filteredDoctors![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorDetailsScreen(
                          doctor: doctor,
                        ),
                      ),
                    );
                  },
                  child: DoctorListItem(
                    doctor: doctor,
                    updateFavoriteStatus: (isFavorite) {
                      _updateFavoriteStatus(index, isFavorite);
                    },
                  ),
                );
              },
            ),
    );
  }

  void _updateFavoriteStatus(int index, bool isFavorite) async {
    await _doctorDatabase.updateDoctorFavoriteStatus(index, isFavorite);
    setState(() {
      _filteredDoctors![index].isFav = isFavorite;
    });
  }
}
