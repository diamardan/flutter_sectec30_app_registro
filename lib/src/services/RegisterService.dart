import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cetis32_app_registro/src/services/SharedService.dart';

const school = "cetis32";

class RegisterService {
  checkCurp(String curp) async {
    return SharedService().get(curp, "registers");
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
        var registerMap = {"id": result.docs.first.id, ...data};
        Register register = Register.fromJson(registerMap);
        return register;
      } else
        return null;
    });
  }

  Future<Register> checkEmail(String email) {
    return FirebaseFirestore.instance
        .collection("schools")
        .doc(school)
        .collection("registros")
        .where("correo", isEqualTo: email)
        .get()
        .then((result) {
      if (result.docs.isNotEmpty) {
        var data = result.docs.first.data();
        var registerMap = {"id": result.docs.first.id, ...data};
        Register register = Register.fromJson(registerMap);
        return register;
      } else
        return null;
    });
  }

  Future<Register> get(String registrationId) {
    return FirebaseFirestore.instance
        .collection("schools")
        .doc(school)
        .collection("registros")
        .doc(registrationId)
        .get()
        .then((result) {
      print("hey ++++++++");
      print(result);
      if (result.exists) {
        var data = result.data();
        var registerMap = {"id": result.id, ...data};
        Register register = Register.fromJson(registerMap);
        return register;
      } else
        return null;
    });
  }
}
