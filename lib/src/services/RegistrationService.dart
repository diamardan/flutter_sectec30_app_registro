import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cetis32_app_registro/src/services/SharedService.dart';

const school = "cetis32";

class RegistrationService {
  checkCurp(String curp) async {
    return SharedService().get(curp, "registrations");
  }

  checkQr(String qrData) {
    return FirebaseFirestore.instance
        .collection("schools")
        .doc(school)
        .collection("registros")
        .where("qr", isEqualTo: qrData)
        .get()
        .then((result) {
      print(result);

      if (result.docs.isNotEmpty) {
        var data = result.docs.first.data();
        var registrationMap = {"id": result.docs.first.id, ...data};
        Registration registration = Registration.fromJson(registrationMap);
        return registration;
      } else
        return null;
    });
  }

  Future<Registration> checkEmail(String email) {
    return FirebaseFirestore.instance
        .collection("schools")
        .doc(school)
        .collection("registros")
        .where("correo", isEqualTo: email)
        .get()
        .then((result) {
      if (result.docs.isNotEmpty) {
        var data = result.docs.first.data();
        var registrationMap = {"id": result.docs.first.id, ...data};
        Registration registration = Registration.fromJson(registrationMap);
        return registration;
      } else
        return null;
    });
  }

  Future<Registration> get(String registrationId) {
    return FirebaseFirestore.instance
        .collection("schools")
        .doc(school)
        .collection("registros")
        .doc(registrationId)
        .get()
        .then((result) {
      if (result.exists) {
        var data = result.data();
        var registrationMap = {"id": result.id, ...data};
        Registration registration = Registration.fromJson(registrationMap);
        return registration;
      } else
        return null;
    });
  }
}
