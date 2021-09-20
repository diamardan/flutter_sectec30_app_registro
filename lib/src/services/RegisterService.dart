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
        var register = result.docs.first;
        return {...register.data()};
      } else
        return null;
    });
  }
}
