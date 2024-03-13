import 'dart:io';
import 'package:flutter/material.dart';
import 'package:med_app/hive/doctor_model.dart';

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
