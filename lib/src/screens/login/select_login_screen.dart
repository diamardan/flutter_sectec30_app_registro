import 'dart:io' show Platform;
import 'dart:io';
import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/screens/home_SCreen.dart';
import 'package:cetis32_app_registro/src/screens/login/login_email_screen.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cetis32_app_registro/src/widgets/whatsapp_help_btn.dart';

class SelectLoginScreen extends StatelessWidget {
  const SelectLoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("INICIAR SESIÓN"),
      ),
      body: Stack(children: <Widget>[
        Container(
            width: double.infinity,
            height: 200,
            child: Center(child: Container())),
        Center(child: _SelectButtons(context)),
        WhatsappHelpBtn(context: context)
      ]),
    ));
  }

  Widget _SelectButtons(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        width: 290,
        decoration: BoxDecoration(
            color: AppColors.morenaLightColor.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        padding: EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        child: Text(
          'Escoge una de estas opciones para iniciar sesión:',
          style: TextStyle(
              fontSize: 15, fontStyle: FontStyle.italic, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(
        height: 35,
      ),
      Container(
        width: 250,
        height: 80,
        child: OutlinedButton.icon(
          icon: Icon(Icons.qr_code, color: AppColors.morenaLightColor),
          label: Text(
            "QR desde camara",
            style: TextStyle(color: AppColors.morenaLightColor),
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false);
          },
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
          width: 250,
          height: 80,
          child: OutlinedButton.icon(
            icon: Icon(Icons.upload_file, color: AppColors.morenaLightColor),
            label: Text(
              "QR desde archivo",
              style: TextStyle(color: AppColors.morenaLightColor),
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false);
            },
          )),
      SizedBox(
        height: 10,
      ),
      Container(
          width: 250,
          height: 80,
          child: OutlinedButton.icon(
            icon: Icon(Icons.email, color: AppColors.morenaLightColor),
            label: Text(
              "Correo Electrónico",
              style: TextStyle(color: AppColors.morenaLightColor),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginMailScreen()));
            },
          )),
      SizedBox(
        height: 30,
      ),
      Image.asset('assets/img/cetis32logo.png', height: 80, fit: BoxFit.contain)
    ]);
  }
}
