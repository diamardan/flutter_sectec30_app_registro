import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/controllers/SignIn/SignInQRController.dart';
import 'package:cetis32_app_registro/src/screens/login/login_email_screen.dart';
import 'package:cetis32_app_registro/src/screens/preregistro/create_form.dart';
import 'package:cetis32_app_registro/src/utils/notify_ui.dart';
import 'package:cetis32_app_registro/src/widgets/whatsapp_help_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    print("LOGGIN ---------------");
    /*  print(Provider.of<UserProvider>(context, listen: false)
        .getRegistration
        .toString());*/
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
          await signInController.authenticate(qrText);
      print(response);
      if (response["code"].toString() == "sign_in_success") {
      } else
        setLoading(false);
      await NotifyUI.showError(context, messageTitle, response["message"]);
    } catch (error) {
      await NotifyUI.showError(context, messageTitle, error.toString());
    }
  }

  _loginWithCamera(BuildContext context) async {
    try {
      setLoading(true);
      String qr = await signInController.scanQR();
      print("logging");

      Map<String, dynamic> response = await signInController.authenticate(qr);

      if (response["code"].toString() == "sign_in_success") {
      } else {
        setLoading(false);
        await NotifyUI.showError(context, messageTitle, response["message"]);
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        showDialogPermissions(context);
      } else {
        print('error: $e');
      }
    } catch (error) {
      setLoading(false);
      await NotifyUI.showError(
          context, "Error de inicio de sesión", error.toString());
    }
  }

  Widget _botonRegistro(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialButton(
      elevation: 10,
      /* onPressed: () {
      showAlertPago(context, "Aviso",
          "Para comenzar el registro se verificará el pago, si ya lo realizó favor de mandar foto del voucher por whatsapp");
    //goToForm(context);
    }, */
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PreregForm()));
      },
      height: 45,
      color: AppColors.morenaColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Text(
              "Registrarse",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "SISTEMA ESCOLAR INTELIGENTE",
          style: TextStyle(fontSize: 14),
        ),
        elevation: 0,
        foregroundColor: Colors.black87,
      ),*/
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
          Image.asset(
            'assets/img/logo-3.png',
            color: AppColors.morenaColor,
            width: 70,
          ),
          SizedBox(height: 10),
          Text("SISTEMA ESCOLAR INTELIGENTE",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  color: AppColors.morenaColor,
                  fontStyle: FontStyle.italic)),
          Container(
              width: 40,
              child: Divider(
                thickness: 3,
                height: 20,
                color: AppColors.morenaColor,
              )),
          SizedBox(
            height: 20,
          ),
          Container(
              width: 240,
              height: 45,
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Inicia sesión con',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        //fontStyle: FontStyle.italic,
                        color: Colors.black87),
                    textAlign: TextAlign.center,
                  ))),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 280,
            height: 50,
            child: ElevatedButton.icon(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
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
              width: 280,
              height: 50,
              child: ElevatedButton.icon(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
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
              width: 280,
              height: 50,
              child: ElevatedButton.icon(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
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
                          builder: (context) => LoginEmailScreen()));
                },
              )),
          SizedBox(
            height: 70,
          ),
          _botonRegistro(context)
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
