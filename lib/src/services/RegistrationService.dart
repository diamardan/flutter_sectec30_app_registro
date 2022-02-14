import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/services/SharedService.dart';
import 'package:cetis32_app_registro/src/utils/Device.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const school = AppConstants.fsCollectionName;

class RegistrationService {
  final db = FirebaseFirestore.instance.collection("schools").doc(school);

  checkCurp(String curp) async {
    return SharedService().get(curp, "registrations");
  }

  Future<Map<String, dynamic>> checkQr(String qrData) async {
    try {
      var result =
          await db.collection("registros").where("qr", isEqualTo: qrData).get();
      if (result.docs.isNotEmpty) {
        var data = result.docs.first.data();
        var registrationMap = {"id": result.docs.first.id, ...data};
        Registration r = Registration.fromJson(registrationMap);
        return {
          "code": "qr_found",
          "registration": r,
        };
      } else
        return {
          "code": "qr_not_found",
          "registration": null,
        };
    } catch (e) {
      print(e);
      return {
        "code": "failed_operation",
        "registration": null,
      };
    }
  }

  Future<Map<String, dynamic>> checkEmail(String email) async {
    try {
      var result = await FirebaseFirestore.instance
          .collection("schools")
          .doc(school)
          .collection("registros")
          .where("correo", isEqualTo: email)
          .get();

      if (result.docs.isNotEmpty) {
        var data = result.docs.first.data();
        var registrationMap = {"id": result.docs.first.id, ...data};
        print(registrationMap);
        Registration registration = Registration.fromJson(registrationMap);
        return {
          "code": "email_found",
          "registration": registration,
          "message": "email found successful"
        };
      } else
        return {
          "code": "email_not_found",
          "registration": null,
          "message": "email was not found"
        };
    } catch (e) {
      print(e);
      return {
        "code": "failed_operation",
        "registration": null,
        "message": "failed operation"
      };
    }
  }

  registerDevice(String regId, int devMax) async {
    Device device = await Device.create();

    register() {
      return db
          .collection("registros")
          .doc(regId)
          .collection("devices")
          .doc(device.id)
          .set(device.toJson());
    }

    var result =
        await db.collection("registros").doc(regId).collection("devices").get();

    if (result.size > 0) {
      final exists =
          result.docs.any((doc) => doc.id == device.id ? true : false);

      if (exists)
        return "registered_device";
      else if (result.size < devMax) {
        await register();
        return "registered_device";
      }
      if ((result.size == devMax)) return "error_max_devices";
    } else {
      await register();
      return "registered_device";
    }
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
