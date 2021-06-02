import 'dart:io' show Platform;
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lumen_app_registro/src/constants/constants.dart';
import 'package:lumen_app_registro/src/customWidgets/Alert.dart';
import 'package:lumen_app_registro/src/screens/preregistro/create_form.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

var dio = Dio();

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(fit: StackFit.expand, children: <Widget>[
        Column(
          children: <Widget>[
            upWidget(context),
            botonera(context),
          ],
        ),
        _btnWhatsapp(context),
      ])),
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
