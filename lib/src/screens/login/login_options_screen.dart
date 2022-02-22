import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/controllers/SignIn/SignInQRController.dart';
import 'package:cetis32_app_registro/src/screens/home/home_sCreen.dart';
import 'package:cetis32_app_registro/src/screens/login/login_email_screen.dart';
import 'package:cetis32_app_registro/src/utils/notify_ui.dart';
import 'package:cetis32_app_registro/src/widgets/whatsapp_help_btn.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginOptionsScreen extends StatefulWidget {
  LoginOptionsScreen({Key key}) : super(key: key);

  @override
  _LoginOptionsScreenState createState() => _LoginOptionsScreenState();
}

class _LoginOptionsScreenState extends State<LoginOptionsScreen> {
  bool loading = false;
  final SignInQRController signInController = SignInQRController();
  String messageTitle = 'Estatus de inicio de sesión';
  setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  void _loginQrFromFile() async {
    setLoading(true);
    final picker = ImagePicker();
    try {
      XFile _file = await picker.pickImage(source: ImageSource.gallery);
      if (_file == null) {
        setLoading(false);
        return;
      }

      String qrText = await signInController.decodeImage(_file.path);
      if (qrText == null || qrText == "") {
        setLoading(false);
        NotifyUI.showError(
            context, messageTitle, 'No se encontró código qr o es inválido');
      }

      Map<String, dynamic> response =
          await signInController.authenticate(_file.path);
      setLoading(false);
      if (response["code"] == "success") {
        signInController.setStateAndPersistence(
            context, response["data"], "qr");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
      } else
        await NotifyUI.showError(context, messageTitle, response["message"]);
    } catch (error) {
      await NotifyUI.showError(context, messageTitle, error.toString());
    }
  }

  _loginWithCamera(BuildContext context) async {
    try {
      setLoading(true);
      String qr = await signInController.scanQR();
      Map<String, dynamic> response = await signInController.authenticate(qr);
      setLoading(false);

      if (response["code"] == "success") {
        signInController.setStateAndPersistence(
            context, response["data"], "qr");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
      } else
        await NotifyUI.showError(context, messageTitle, response["message"]);
    } catch (error) {
      await NotifyUI.showError(context, messageTitle, error.toString());
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
            _login_options(context),
            Container(),
            WhatsappHelpBtn(context: context)
          ])),
    ));
  }

  // ignore: non_constant_identifier_names
  Widget _login_options(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
          Container(
            width: 290,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            padding: EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            child: Text(
              '¿Cómo deseas iniciar sesión?',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
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

  showDialogPermissions(BuildContext context) {
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
}
