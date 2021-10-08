import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/provider/user_provider.dart';
import 'package:cetis32_app_registro/src/services/RegisterService.dart';
import 'package:cetis32_app_registro/src/services/authentication_service.dart';
import 'package:cetis32_app_registro/src/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_tools/qr_code_tools.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math';

class AuthMethods {
  static RegisterService registerService = RegisterService();

  static AuthenticationService authenticationService = AuthenticationService();

  // * * *  Sing in with code QR from Camera  * * *

  static signInWithQrCamera(BuildContext context) async {
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
      Register register =
          await registerService.checkQr(futureString.rawContent);

      if (register == null) {
        return response["code"] = AuthResponseStatus.QR_NOT_FOUND;
      }

      // auth with firebase

      try {
        await authenticationService.signInAnonymously();

        createState(context, register, AuthnMethodEnum.EMAIL_PASSWORD);
        createPersistence(register, AuthnMethodEnum.EMAIL_PASSWORD);
      } catch (error) {
        return response["code"] = AuthResponseStatus.AUTH_ERROR;
      }

      return response["code"] = AuthResponseStatus.SUCCESS;
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

  static signInfromQrFile(BuildContext context) async {
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
      return response["code"] = AuthResponseStatus.QR_INVALID;

    Register register = await registerService.checkQr(qrData);

    if (register == null) {
      return response["code"] = AuthResponseStatus.QR_NOT_FOUND;
    }
    /*   SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('register_qr', futureString.rawContent);
*/
    await authenticationService.signInAnonymously();

    createState(context, register, AuthnMethodEnum.EMAIL_PASSWORD);
    createPersistence(register, AuthnMethodEnum.EMAIL_PASSWORD);

    //return response["code"] = LoginResponseStatus.AUTH_ERROR;

    return response["code"] = AuthResponseStatus.SUCCESS;
  }

// * * *  Sign in with email and password  * * *
  static signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    Register register = await RegisterService().checkEmail(email);
    if (register == null) return {'code': AuthResponseStatus.EMAIL_NOT_FOUND};

    var result = await authenticationService.signInEmailAndPassword(
        email: email, password: password);

    var response = {};
    print(result['code']);
    switch (result['code']) {
      case "sign_in_success":
        response['code'] = AuthResponseStatus.SUCCESS;
        createState(context, register, AuthnMethodEnum.EMAIL_PASSWORD);
        createPersistence(register, AuthnMethodEnum.EMAIL_PASSWORD);
        break;
      case "user-not-found":
        response['code'] = AuthResponseStatus.ACCOUNT_NOT_FOUND;
        break;
      case "wrong-password":
        response['code'] = AuthResponseStatus.WRONG_PASSWORD;
        break;
      default:
        response['code'] = AuthResponseStatus.AUTH_ERROR;
        break;
    }
    return response;
  }

// * * *  Sign up email and password  * * *
  static signUpWithEmailAndPassword(String email) async {
    Register register = await RegisterService().checkEmail(email);
    if (register == null) return {'code': AuthResponseStatus.EMAIL_NOT_FOUND};

    var password = generatePassword();

    Map<String, String> result = await authenticationService
        .signUpEmailAndPassword(email: email, password: password);
    var response = {};
    switch (result['code']) {
      case "sign_up_success":
        await authenticationService.sendPassword(email, password);
        await authenticationService.savePassword(register.id, password);
        response['code'] = AuthResponseStatus.SUCCESS;
        break;

      case "email-already-in-use":
        response['code'] = AuthResponseStatus.EMAIL_ALREADY_EXISTS;
        break;
      default:
        print(result['code']);
        response['code'] = AuthResponseStatus.AUTH_ERROR;
    }

    return response;
  }

// * * *  Recovery password * * *

  static recoveryPassword(String email) async {
    Register register = await RegisterService().checkEmail(email);
    if (register == null) return {'code': AuthResponseStatus.EMAIL_NOT_FOUND};

    var result = await authenticationService.signInEmailAndPassword(
        email: email, password: "xxxxxx");

    print(result['code']);
    switch (result['code']) {
      case "user-not-found":
        return {"code": AuthResponseStatus.ACCOUNT_NOT_FOUND};
        break;
      case "wrong-password": //means user exists
        break;
      default:
        return {"code": AuthResponseStatus.AUTH_ERROR};
        break;
    }

    await authenticationService.remindPassword(email, register.password);

    return {'code': AuthResponseStatus.SUCCESS};
  }

  // * * *  Utilities  * * *

  static String generatePassword() {
    final length = 12;
    final letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    final letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    final number = '01234567890123456789';
    final special = '@#%+&#%+&';

    String chars = "";
    chars += '$letterLowerCase$letterUpperCase';
    chars += '$number';
    chars += '$special';

    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join('');
  }

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
      BuildContext context, Register reg, String authMethod) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setUser(reg.id, authMethod);
  }

  static createPersistence(Register reg, String authMethod) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("registration_id", reg.id);
    prefs.setString("auth_method", authMethod);
  }
}
