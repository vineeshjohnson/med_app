import 'package:flutter/material.dart';
import 'dart:io';

import 'package:med_app/screens/doctorlist_hive.dart';
import '../hive/doctor_model.dart';
import 'doctor_details.dart'; // Import the DoctorDetailsScreen

class FavList extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const FavList({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _FavListState createState() => _FavListState();
}

class _FavListState extends State<FavList> {
  final DoctorDatabase _doctorDatabase = DoctorDatabase();
  final TextEditingController _searchController = TextEditingController();
  List<DoctorModel>? _filteredDoctors;

  @override
  void initState() {
    super.initState();
    _initDoctorBox();
  }

  Future<void> _initDoctorBox() async {
    await _doctorDatabase.openBox();
    _filteredDoctors = _doctorDatabase.getAllDoctors();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.cyan.shade100,
        centerTitle: true,
        title: const Text('Favorite Doctors'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
          _filteredDoctors == null
              ? const Center(child: CircularProgressIndicator())
              : _buildDoctorList(),
        ],
      ),
    );
  }

  Widget _buildDoctorList() {
    List<DoctorModel> favoriteDoctors =
        _filteredDoctors!.where((doctor) => doctor.isFav).toList();

    return Expanded(
      child: favoriteDoctors.isEmpty
          ? Center(
              child: Image.asset(
                'assets/images/No data-amico.png',
                width: 200,
                height: 200,
              ),
            )
          : ListView.builder(
              itemCount: favoriteDoctors.length,
              itemBuilder: (context, index) {
                final doctor = favoriteDoctors[index];
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

  // @override
  // void dispose() {
  //   _doctorDatabase.closeBox();
  //   super.dispose();
  // }
}

class DoctorListItem extends StatelessWidget {
  final DoctorModel doctor;
  final Function(bool) updateFavoriteStatus;

  const DoctorListItem({
    Key? key,
    required this.doctor,
    required this.updateFavoriteStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (doctor.imagePath.isNotEmpty)
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(File(doctor.imagePath)),
                    ),
                  ),
                ),
              const SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor.category,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              List<PopupMenuEntry> menuItems = [];
              if (doctor.isFav) {
                menuItems.add(
                  const PopupMenuItem(
                    value: 'removeFavorite',
                    child: Text('Remove from Favorites'),
                  ),
                );
              } else {
                menuItems.add(
                  const PopupMenuItem(
                    value: 'favorite',
                    child: Text('Add to Favorite'),
                  ),
                );
              }
              return menuItems;
            },
            onSelected: (value) {
              if (value == 'favorite') {
                _showAddToFavoriteDialog(context);
              } else if (value == 'removeFavorite') {
                _showRemoveFromFavoriteDialog(context);
              }
            },
          ),
        ],
      ),
    );
  }

  void _showAddToFavoriteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add to Favorite'),
          content:
              const Text('Do you want to make this doctor as your favorite?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                updateFavoriteStatus(true);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showRemoveFromFavoriteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove from Favorites'),
          content: const Text(
              'Do you want to remove this doctor from your favorites?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                updateFavoriteStatus(false);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
