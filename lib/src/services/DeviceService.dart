import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const school = AppConstants.fsCollectionName;

class DeviceService {
  final db = FirebaseFirestore.instance.collection("schools").doc(school);

  Future<int> getActivedDevices(String regId) async {
    var res =
        await db.collection("registros").doc(regId).collection("devices").get();
    return res.size;
  }

  Future<void> add(String regId, Map<String, String> device) async {
    db
        .collection("registros")
        .doc(regId)
        .collection("devices")
        .doc(device["id"])
        .set(device);
  }

  Future<void> remove(String regId, String deviceId) async {
    db
        .collection("registros")
        .doc(regId)
        .collection("devices")
        .doc(deviceId)
        .delete();
  }
}
