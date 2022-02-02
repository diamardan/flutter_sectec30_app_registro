import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cetis32_app_registro/src/services/SharedService.dart';

const school = AppConstants.fsCollectionName;


class RegistrationService {
  checkCurp(String curp) async {
    return SharedService().get(curp, "registrations");
  }

  Future<Map> checkQr(String qrData) async {
    try {
      var result = await FirebaseFirestore.instance
          .collection("schools")
          .doc(school)
          .collection("registros")
          .where("qr", isEqualTo: qrData)
          .get();

      if (result.docs.isNotEmpty) {
        var data = result.docs.first.data();
        var registrationMap = {"id": result.docs.first.id, ...data};
        Registration registration = Registration.fromJson(registrationMap);
        return 
        
           {"code": "qr_found","registration":registration, "message": "qr found successful"  } ;
      } else
        return {"code": "qr_not_found","registration": null, "message": "qr was not found"  };
    } catch (e) {
      
      print(e);
      return {"code": "failed_operation","registration": null, "message": "failed operation"  };
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
        return
       {"code": "email_found","registration":registration, "message": "email found successful"  } ;
      } else
        return {"code": "email_not_found","registration": null, "message": "email was not found"  };
    } catch (e) {
      
      print(e);
      return {"code": "failed_operation","registration": null, "message": "failed operation"  };
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
