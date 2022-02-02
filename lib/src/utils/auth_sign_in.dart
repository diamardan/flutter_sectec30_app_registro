import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:cetis32_app_registro/src/models/subscription_model.dart';
import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/provider/user_provider.dart';
import 'package:cetis32_app_registro/src/services/RegistrationService.dart';
import 'package:cetis32_app_registro/src/services/AuthenticationService.dart';
import 'package:cetis32_app_registro/src/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_tools/qr_code_tools.dart';

class AuthSignIn {
  static RegistrationService registrationService = RegistrationService();

  static AuthenticationService authenticationService = AuthenticationService();

  // * * *  Sing in with code QR from Camera  * * *

  static withQrCamera(BuildContext context) async {
    
       

    var response = {};
    try {
      // scan qr
      var options = ScanOptions(
        restrictFormat: [BarcodeFormat.qr],
      );
      var futureString = await BarcodeScanner.scan(options: options);
      if (futureString.rawContent == "")
        return response["code"] = AuthResponseStatus.QR_INVALID;

      // check if qr is valid
      response = await registrationService.checkQr(futureString.rawContent);
      if (response["code"] == "failed_operation")
        return AuthResponseStatus.UNKNOW_ERROR;

      if (response["code"] == "qr_not_found")
        return AuthResponseStatus.QR_NOT_FOUND;

      Registration registration = response["registration"];

      if (registration == null) {
        return AuthResponseStatus.QR_NOT_FOUND;
      }

      await authenticationService.signInAnonymously();

      createState(context, registration, AuthnMethodEnum.QR_CAMERA);
      createPersistence(registration, AuthnMethodEnum.QR_CAMERA);

      return AuthResponseStatus.SUCCESS;
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        showDialogPermissions(context);
      } else {
        print('Unknown error: $e');
      }
    } catch (e) {
      //futureString = e.toString();
    }
  }

  // * * *  Sign in with code QR from file  * * *

  static fromQrFile(BuildContext context, String imagePath) async {
    String qrData;

    qrData = await QrCodeToolsPlugin.decodeFrom(imagePath);

    if (qrData == null || qrData == "") return AuthResponseStatus.QR_INVALID;

    Map<String, dynamic> response = await registrationService.checkQr(qrData);
    if (response["code"] == "failed_operation")
      return AuthResponseStatus.UNKNOW_ERROR;

    if (response["code"] == "qr_not_found")
      return AuthResponseStatus.QR_NOT_FOUND;

    Registration registration = response["registration"];

    if (registration == null) {
      return AuthResponseStatus.QR_NOT_FOUND;
    }

    await authenticationService.signInAnonymously();

    createState(context, registration, AuthnMethodEnum.QR_FILE);
    createPersistence(registration, AuthnMethodEnum.QR_FILE);

    return AuthResponseStatus.SUCCESS;
  }

// * * *  Sign in with email and password  * * *
  static withEmailAndPassword(
      BuildContext context, String email, String password) async {
    Map<String, dynamic> response =
        await RegistrationService().checkEmail(email);
    if (response["code"] == "failed_operation")
      return AuthResponseStatus.UNKNOW_ERROR;

    if (response["code"] == "email_not_found")
      return AuthResponseStatus.EMAIL_NOT_FOUND;

    Registration registration = response["registration"];
    if (registration == null) {
      return AuthResponseStatus.EMAIL_NOT_FOUND;
    }

    var result = await authenticationService.signInEmailAndPassword(
        email: email, password: password);

    switch (result['code']) {
      case "sign_in_success":
        createState(context, registration, AuthnMethodEnum.EMAIL_PASSWORD);
        createPersistence(registration, AuthnMethodEnum.EMAIL_PASSWORD);
        return AuthResponseStatus.SUCCESS;
        break;
      case "user-not-found":
        return AuthResponseStatus.ACCOUNT_NOT_FOUND;
      case "wrong-password":
        return AuthResponseStatus.WRONG_PASSWORD;
        break;
      case "network-request-failed":
        return AuthResponseStatus.CONNECTION_FAILED;
        break;
      default:
        return AuthResponseStatus.UNKNOW_ERROR;
    }
  }

  // * * *  Utilities  * * *

  static showDialogPermissions(BuildContext context) {
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
  }

  static createState(
      BuildContext context, Registration reg, String authMethod) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setUser(reg.id, authMethod);

    reg.resetMessagingInfo();
    userProvider.setRegistration(reg);
  }

  static createPersistence(Registration reg, String authMethod) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("registration_id", reg.id);
    prefs.setString("auth_method", authMethod);
  }

  static resetMessaging(String fcmToken, Subscription subscription) {
    if (fcmToken != null) {}
  }
}
