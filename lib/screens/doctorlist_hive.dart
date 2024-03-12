import 'package:hive/hive.dart';
import '../hive/doctor_model.dart';

class DoctorDatabase {
  late Box<DoctorModel>? _doctorBox;
  List<DoctorModel> getDoctorsByCategory(String category) {
    return _doctorBox!.values
        .where((doctor) => doctor.category == category)
        .toList();
  }

  Future<void> openBox() async {
    _doctorBox = await Hive.openBox<DoctorModel>('doctormodels');
  }

  List<DoctorModel> getAllDoctors() {
    return _doctorBox!.values.toList();
  }

  List<DoctorModel> searchDoctors(String query) {
    if (query.isEmpty) {
      return getAllDoctors();
    } else {
      return _doctorBox!.values
          .where((doctor) =>
              doctor.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void closeBox() {
    _doctorBox!.close();
  }

  Future<void> updateDoctorFavoriteStatus(int index, bool isFavorite) async {
    final doctor = _doctorBox!.getAt(index);
    if (doctor != null) {
      doctor.isFav = isFavorite;
      await _doctorBox!.putAt(index, doctor);
    }
  }
}
