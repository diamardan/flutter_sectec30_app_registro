import 'dart:io' show Platform;
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/customWidgets/Alert.dart';
import 'package:cetis32_app_registro/src/screens/preregistro/create_form.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';
import 'package:cetis32_app_registro/src/widgets/whatsapp_help_btn.dart';

var dio = Dio();

class SelectLoginScreen extends StatelessWidget {
  const SelectLoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Inicio de sesión",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
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

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondo = Container(
      height: size.height * .4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        /*  Color.fromRGBO(33, 147, 176, 1),
        Color.fromRGBO(109, 213, 237, 1) */
        Color.fromRGBO(255, 255, 255, 1),
        Color.fromRGBO(244, 244, 244, 1)
      ])),
    );

    final logo = Positioned(
        top: 100,
        left: 50,
        child: Image.asset('assets/img/cetis32logo.png',
            height: 80, fit: BoxFit.contain));

    return Stack(
      children: <Widget>[
        fondo,
        logo,
      ],
    );
  }

  Widget _SelectButtons(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 280,
            decoration: BoxDecoration(
                color: AppColors.morenaLightColor.withOpacity(0.3),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            padding: EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            child: Text(
              'Escoge una de estas opciones para iniciar sesión:',
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PreregForm()));
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
                icon:
                    Icon(Icons.upload_file, color: AppColors.morenaLightColor),
                label: Text(
                  "QR desde archivo",
                  style: TextStyle(color: AppColors.morenaLightColor),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PreregForm()));
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
                      MaterialPageRoute(builder: (context) => PreregForm()));
                },
              )),
          SizedBox(
            height: 30,
          ),
          Image.asset('assets/img/cetis32logo.png',
              height: 80, fit: BoxFit.contain)
        ]),

        //_btnWhatsapp(context)
      ],
    );
  }

  Widget _crearFondoLottie(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondo = Container(
      height: size.height * .4,
      width: double.infinity,
    );

    final logo = Positioned(
        top: size.height * .42,
        left: 60,
        right: 60,
        child: Lottie.asset('assets/lotties/pow.json'));

    return Stack(
      children: <Widget>[
        logo,
      ],
    );
  }
}

Widget _btnWhatsapp(context) {
  Size size = MediaQuery.of(context).size;
  return Positioned(
    bottom: size.height * .15,
    left: size.width * .32,
    right: size.width * .32,
    child: Container(
        height: 38,
        width: size.width * .3,
        decoration: BoxDecoration(
            color: AppColors.whatsappColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: Colors.grey[200], style: BorderStyle.solid, width: 1)),
        child: MaterialButton(
          elevation: 20,
          onPressed: () {
            enviarWhatsapp();
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          height: 15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.whatsapp,
                color: Colors.white,
              ),
              Text(
                'Ayuda',
                style: TextStyle(color: AppColors.white),
              )
            ],
          ),
        )),
  );
}

Widget upWidget(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Container(
      padding: EdgeInsets.all(29),
      decoration: BoxDecoration(color: AppColors.white),
      height: size.height * .35,
      width: double.infinity,
      child: Center(
        child: Container(
          child: Image(
            image: AssetImage('assets/img/logo.png'),
          ),
        ),
      ));
}

Widget botonera(BuildContext context) {
  return Expanded(
    flex: 1,
    child: Container(
        decoration: BoxDecoration(color: Colors.white),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 23, 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _botonRegistro(context),
              SizedBox(
                height: 15,
              ),
              //ButonDescargaFormatoPdf()
              /* _botonDescargaFormato(context), */
            ],
          ),
        )),
  );
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
    color: Colors.blue,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    child: Container(
      width: size.width * .75,
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

Widget _botonDescargaFormato(BuildContext context) {
  // listenForPermissionStatus();
  Size size = MediaQuery.of(context).size;
  return MaterialButton(
    elevation: 10,
    onPressed: () async {
      var tempDir;
      var appDir;
      await Permission.storage.request();

      if (Platform.isAndroid) {
        tempDir = await ExtStorage.getExternalStoragePublicDirectory(
            ExtStorage.DIRECTORY_DOWNLOADS);
      } else if (Platform.isIOS) {
        appDir = await getApplicationDocumentsDirectory();
        tempDir = appDir.path;
      }

      String fullPath = tempDir + "/formato_pago.pdf";
      print('full path : $fullPath');
      downloadPDF(dio, AppConstants.pdfPagoUrl, fullPath, context);
    },
    height: 45,
    color: Color.fromRGBO(221, 44, 0, 1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    child: Container(
      padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
      width: size.width * .75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "Formato de pago",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    ),
  );
}

goToForm(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => PreregForm()));
}

enviarWhatsapp() async {
  await launch(
      "${AppConstants.whatsappNumber}?text=${AppConstants.whatsappText}");
}

class ButonDescargaFormatoPdf extends StatefulWidget {
  ButonDescargaFormatoPdf({Key key}) : super(key: key);

  @override
  _ButonDescargaFormatoPdfState createState() =>
      _ButonDescargaFormatoPdfState();
}

class _ButonDescargaFormatoPdfState extends State<ButonDescargaFormatoPdf> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _botonDescargaFormato(context),
    );
  }
}

Future downloadPDF(
    Dio dio, String url, String savePath, BuildContext context) async {
  try {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    Response response = await dio.get(
      url,
      onReceiveProgress: showDownloadProgress,
      //Received data with List<int>
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          }),
    );
    print(response.headers);
    File file = File(savePath);

    var raf = file.openSync(mode: FileMode.write);
    // response.data is List<int> type
    raf.writeFromSync(response.data);
    await raf.close();
    showCompletedDownload(context, "Completado",
        "El Formato de pago se ha descargado completamente, revise su carpeta de descargas");
  } catch (e) {
    print(e);
  }
}

void showDownloadProgress(received, total) {
  if (total != -1) {
    print((received / total * 100).toStringAsFixed(0) + "%");
  }
}
