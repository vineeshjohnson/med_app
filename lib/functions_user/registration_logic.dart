import 'package:med_app/boxes.dart';
import 'package:med_app/hive/person.dart';

class RegistrationLogic {
  static void addUserToBox(
      String email, String password, String name, String mobilenumber) {
    boxPerson.put(
        'key_$email',
        Person(
            email: email,
            password: password,
            name: name,
            mobileNumber: mobilenumber));
  }
}
