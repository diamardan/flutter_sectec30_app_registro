import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/services/RegisterService.dart';
import 'package:cetis32_app_registro/src/utils/alerts.dart';
import 'package:cetis32_app_registro/src/utils/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_tools/qr_code_tools.dart';
import 'package:image_picker/image_picker.dart';

class LoginMethods {
  static RegisterService registerService = RegisterService();

  static withQrCamera(BuildContext context) async {
    var response = {};
    try {
      // scan qr
      var options = ScanOptions(
        restrictFormat: [BarcodeFormat.qr],
      );
      var futureString = await BarcodeScanner.scan(options: options);
      if (futureString.rawContent == "")
        return response["code"] = LoginResponseStatus.QR_INVALID;

      // check if qr is valid
      Register _register =
          await registerService.checkQr(futureString.rawContent);
      print("_register: $_register)");

      if (_register == null) {
        return response["code"] = LoginResponseStatus.QR_NOT_FOUND;
      }
      /*   SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('register_qr', futureString.rawContent);
*/
      // auth with firebase
      final FirebaseAuth _auth = FirebaseAuth.instance;
      try {
        await _auth.signInAnonymously();
      } catch (error) {
        return response["code"] = LoginResponseStatus.AUTH_ERROR;
      }

      return response["code"] = LoginResponseStatus.SUCCESS;
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Sin acceso a Cámara'),
                content:
                    Text('Permitir el acceso de la Cámara para poder escanear'),
                actions: <Widget>[
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () async {
                      await openAppSettings();
                    },
                  )
                ],
              );
            });
      } else {
        print('Unknown error: $e');
      }
    } catch (e) {
      //futureString = e.toString();
    }
  }

  static fromFile() async {
    ImagePicker picker = ImagePicker();
    String qrData;
    var response = {};

    try {
      PickedFile _file = await picker.getImage(source: ImageSource.gallery);

      if (_file == null) return;

      qrData = await QrCodeToolsPlugin.decodeFrom(_file.path);
    } catch (error) {
      print(error);
    }

    if (qrData == null || qrData == "")
      return response["code"] = LoginResponseStatus.QR_INVALID;

    Register _register = await registerService.checkQr(qrData);
    print("_register: $_register)");

    if (_register == null) {
      return response["code"] = LoginResponseStatus.QR_NOT_FOUND;
    }
    /*   SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('register_qr', futureString.rawContent);
*/
    // auth with firebase
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.signInAnonymously();
    } catch (error) {
      return response["code"] = LoginResponseStatus.AUTH_ERROR;
    }

    return response["code"] = LoginResponseStatus.SUCCESS;
  }
}
