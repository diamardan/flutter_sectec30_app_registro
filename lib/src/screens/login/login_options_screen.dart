import 'dart:io' show Platform;
import 'dart:io';
import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/screens/home/home_sCreen.dart';
import 'package:cetis32_app_registro/src/screens/login/login_email_screen.dart';
import 'package:cetis32_app_registro/src/utils/notify_ui.dart';
import 'package:cetis32_app_registro/src/utils/enums.dart';
import 'package:cetis32_app_registro/src/utils/auth_sign_in.dart';
import 'package:image_picker/image_picker.dart';
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
  String imagePath;
  final picker = ImagePicker();

  void _loginQrFromFile() async {
    setState(() => loading = true);
    XFile _file;
    try {
      _file = await picker.pickImage(source: ImageSource.gallery);
    } catch (error) {
      print(error);
    }
    setState(() {
      if (_file == null) {
        loading = false;
        return;
      }
      imagePath = _file.path;
    });

    var response = await AuthSignIn.fromQrFile(context, imagePath);
    setState(() => loading = false);
    switch (response) {
      case AuthResponseStatus.SUCCESS:
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
        break;
      case AuthResponseStatus.QR_INVALID:
        await NotifyUI.showError(
            context, 'Aviso', 'No se encontró código qr o es inválido');
        break;
      case AuthResponseStatus.QR_NOT_FOUND:
        await NotifyUI.showError(context, 'Aviso', 'El usuario no existe');
        break;
      case AuthResponseStatus.AUTH_ERROR:
        await NotifyUI.showError(context, 'Aviso', 'Error Fb-Auth');
        break;
    }
  }

  _loginWithCamera(BuildContext context) async {
    setState(() => loading = true);
    var response = await AuthSignIn.withQrCamera(context);
    setState(() => loading = false);
    print("reponse");
    print(response);
    switch (response) {
      case AuthResponseStatus.SUCCESS:
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
        break;
      case AuthResponseStatus.QR_NOT_FOUND:
        await NotifyUI.showError(context, 'Aviso', 'El usuario no existe.');
        break;
      case AuthResponseStatus.AUTH_ERROR:
        await NotifyUI.showError(context, 'Aviso', 'Error Fb-Auth');
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
            Column(
              children: [_login_options(context), Container()],
            ),
            WhatsappHelpBtn(context: context)
          ])),
    ));
  }

  // ignore: non_constant_identifier_names
  Widget _login_options(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 5),
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey.withOpacity(0.7), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          /*    Image.asset('assets/img/cetis32logo.png',
              height: 100, fit: BoxFit.contain),*/
          SizedBox(height: 0),
          Container(
            width: 290,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            padding: EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            child: Text(
              '¿COMO DESEAS INICIAR SESIÓN?',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  //fontStyle: FontStyle.italic,
                  color: Colors.black54),
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
                style:
                    TextStyle(color: AppColors.morenaLightColor, fontSize: 16),
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
                  style: TextStyle(
                      color: AppColors.morenaLightColor, fontSize: 16),
                ),
                onPressed: () {
                  _loginQrFromFile();
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
                  style: TextStyle(
                      color: AppColors.morenaLightColor, fontSize: 16),
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
        ]));
  }
}
