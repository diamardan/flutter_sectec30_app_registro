import 'dart:io' show Platform;
import 'dart:io';
import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/screens/home_SCreen.dart';
import 'package:cetis32_app_registro/src/screens/login/login_email_screen.dart';
import 'package:cetis32_app_registro/src/utils/alerts.dart';
import 'package:cetis32_app_registro/src/utils/enums.dart';
import 'package:cetis32_app_registro/src/utils/login_methods.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'package:cetis32_app_registro/src/widgets/whatsapp_help_btn.dart';

class LoginOptionsScreen extends StatefulWidget {
  LoginOptionsScreen({Key key}) : super(key: key);

  @override
  _LoginOptionsScreenState createState() => _LoginOptionsScreenState();
}

class _LoginOptionsScreenState extends State<LoginOptionsScreen> {
  bool loading = false;

  void _loginQrImage() async {
    setState(() => loading = true);
    var response = await LoginMethods.fromFile();
    setState(() => loading = false);
    print("reponse");
    print(response);
    switch (response) {
      case LoginResponseStatus.SUCCESS:
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
        break;
      case LoginResponseStatus.QR_INVALID:
        await AppAlert.showBasic(
            context, 'Aviso', 'No se encontró código qr o es inválido');
        break;
      case LoginResponseStatus.QR_NOT_FOUND:
        await AppAlert.showBasic(context, 'Aviso', 'El usuario no existe');
        break;
      case LoginResponseStatus.AUTH_ERROR:
        await AppAlert.showBasic(context, 'Aviso', 'Error Fb-Auth');
        break;
    }
  }

  _loginWithCamera(BuildContext context) async {
    setState(() => loading = true);
    var response = await LoginMethods.withQrCamera(context);
    setState(() => loading = false);
    print("reponse");
    print(response);
    switch (response) {
      case LoginResponseStatus.SUCCESS:
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
        break;
      case LoginResponseStatus.QR_NOT_FOUND:
        await AppAlert.showBasic(context, 'Aviso', 'El usuario no existe');
        break;
      case LoginResponseStatus.AUTH_ERROR:
        await AppAlert.showBasic(context, 'Aviso', 'Error Fb-Auth');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.morenaLightColor,
        title: Text("INICIAR SESIÓN"),
      ),
      body: ModalProgressHUD(
          inAsyncCall: loading,
          child: Stack(children: <Widget>[
            Center(child: _login_options(context)),
            WhatsappHelpBtn(context: context)
          ])),
    ));
  }

  // ignore: non_constant_identifier_names
  Widget _login_options(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 5),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.morenaLightColor, width: 1.2),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 290,
            decoration: BoxDecoration(
                //color: AppColors.morenaLightColor.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            padding: EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            child: Text(
              '¿COMO DESEAS INICIAR SESIÓN?',
              style: TextStyle(
                  fontSize: 16,
                  //fontStyle: FontStyle.italic,
                  color: AppColors.morenaLightColor),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 240,
            height: 70,
            child: OutlinedButton.icon(
              icon: Icon(Icons.qr_code, color: AppColors.morenaLightColor),
              label: Text(
                "QR desde camara",
                style: TextStyle(color: AppColors.morenaLightColor),
              ),
              onPressed: () {
                _loginWithCamera(context);
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              width: 240,
              height: 70,
              child: OutlinedButton.icon(
                icon:
                    Icon(Icons.upload_file, color: AppColors.morenaLightColor),
                label: Text(
                  "QR desde archivo",
                  style: TextStyle(color: AppColors.morenaLightColor),
                ),
                onPressed: () {
                  _loginQrImage();
                },
              )),
          SizedBox(
            height: 10,
          ),
          Container(
              width: 240,
              height: 70,
              child: OutlinedButton.icon(
                icon: Icon(Icons.email, color: AppColors.morenaLightColor),
                label: Text(
                  "Correo Electrónico",
                  style: TextStyle(color: AppColors.morenaLightColor),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginMailScreen()));
                },
              )),
          SizedBox(
            height: 30,
          ),
          Image.asset('assets/img/cetis32logo.png',
              height: 80, fit: BoxFit.contain)
        ]));
  }
}
