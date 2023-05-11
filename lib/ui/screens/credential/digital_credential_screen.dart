import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:sectec30_app_registro/src/models/user_model.dart';
import 'package:sectec30_app_registro/src/provider/user_provider.dart';
import 'package:sectec30_app_registro/ui/res/colors.dart';
import 'package:sectec30_app_registro/ui/screens/credential/render_crendetial_screen.dart';
import 'package:sectec30_app_registro/src/utils/imageUtil.dart';
import 'package:sectec30_app_registro/src/utils/widget_to_image.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

class DigitalCredentialScreen extends StatefulWidget {
  @override
  _DigitalCredentialScreenState createState() =>
      _DigitalCredentialScreenState();
}

const timeout = const Duration(seconds: 5);

class _DigitalCredentialScreenState extends State<DigitalCredentialScreen> {
  GlobalKey key1;
  GlobalKey key2;
  Uint8List bytes1;
  Uint8List bytes2;
  bool visibleButton;
  Registration register;
  PermissionStatus _permissionStatus;
  PermissionStatus _manageMediaStatus;
  @override
  void initState() {
    super.initState();
    _checkPermissionStatus();
  }

  Future<void> _checkPermissionStatus() async {
    final status = await Permission.storage.status;
    setState(() {
      _permissionStatus = status;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getStudentData();
  }

  _getStudentData() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);
    register = userProvider.getRegistration;
  }

  startTimeout() {
    return new Timer(timeout, handleTimeout);
  }

  void handleTimeout() {
    if (mounted)
      setState(() {
        visibleButton = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Credencial inteligente"),
        centerTitle: true,
      ),
      floatingActionButton: Visibility(
        visible: visibleButton == true ? true : false,
        child: FloatingActionButton.extended(
            backgroundColor: AppColors.primary,
            //backgroundColor: canDownload == true ? Colors.blue : Colors.grey,
            label: Text("Descargar"),
            icon: Icon(Icons.download),
            /* child: 
                Icon(Icons.download),
            ), */
            onPressed: () async {
              await _requestPermission();
              _showSnackbar("Su descarga comenzará en breve");
              final bytes1 = await ImageUtils.capture(key1);
              final bytes2 = await ImageUtils.capture(key2);

              setState(() {
                this.bytes1 = bytes1;
                this.bytes2 = bytes2;
              });
              makePdf();
            }),
      ),
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            SizedBox(
              height: 15,
            ),
            _anversoCredencial(),
            WidgetToImage(builder: (key) {
              this.key2 = key;
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 10,
                child: Container(
                  height: 220,
                  width: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(1.0)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        image: AssetImage('assets/img/credencial/reverso.png')),
                  ),
                  child: Column(
                    children: <Widget>[
                      _reverso(),
                    ],
                  ),
                ),
              );
            }),
            /* buildImage(bytes1),
            buildImage(bytes2), */
          ]),
        ),
      )),
    );
  }

  Widget _reverso() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Row(
          children: [
            SizedBox(
              width: 80,
            ),
            Container(
                color: Colors.transparent,
                width: 240,
                child: Text(
                  "25 OCTUBRE 2022",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                )),
          ],
        ),
        SizedBox(
          height: 80,
        ),
        Container(
          decoration: BoxDecoration(color: Colors.transparent),
          height: 95,
          width: 330,
          margin: EdgeInsets.fromLTRB(15, 5, 0, 0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Colors.transparent,
                  width: 90,
                  height: 90,
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          register.turn,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10),
                        )),
                    SizedBox(
                      height: 2,
                    ),
                    FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          register.grade,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                    FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          register.group,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ))
                  ]),
                ),
                SizedBox(
                  width: 60,
                ),
                Container(
                  color: Colors.transparent,
                  width: 100,
                  height: 100,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4,
                      ),
                      _networkImageWidget(90, 90, register.qrDrive),
                    ],
                  ),
                )
              ]),
        ),
      ],
    );
  }

  Widget _anversoCredencial() {
    return WidgetToImage(builder: (key) {
      this.key1 = key;
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        elevation: 10,
        child: Container(
          height: 220,
          width: 360,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(1.0)),
            image: DecorationImage(
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                image: AssetImage('assets/img/credencial/anverso.png')),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.transparent,
                height: 220,
                width: 100,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 45,
                      ),
                      _networkImageWidget(90, 70, register.fotoUsuarioDrive),
                      Container(
                        width: 60,
                        child: Text(
                          register.idbio.toString(),
                          textAlign: TextAlign.right,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      _networkImageWidget(30, 30, register.qrDrive),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        width: 100,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            register.curp,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                color: Colors.transparent,
                height: 220,
                width: 220,
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 135,
                  ),
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${register.name} ${register.surnames}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  _networkImageWidget(30, 50, register.firmaDrive)
                ]),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _networkImageWidget(double height, double width, String image,
      [bool transparency, bool margin, double marginTop]) {
    if (register.fotoUsuarioDrive == null || image == "") {
      image = "1TvA4s1r-c2NpsPCRdHozdk8dk0xQ_riY";
    }
    return Container(
        height: height,
        width: width,
        margin: margin == true ? EdgeInsets.fromLTRB(0, marginTop, 0, 0) : null,
        child: Image.network(
          'https://drive.google.com/uc?export=view&id=${image}',
          alignment: Alignment.center,
          fit: BoxFit.fill,
          color: transparency == true
              ? const Color.fromRGBO(255, 255, 255, 0.5)
              : null,
          colorBlendMode: transparency == true ? BlendMode.modulate : null,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) {
              startTimeout();
              return child;
            } /* else {
              if (loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes ==
                      1.0 &&
                  image == this.register.fotoUsuarioDrive) {
                startTimeout();
              }
            } */

            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                  ),
                  Text("Descargando imagen ")
                ],
              ),
            );
          },
        ));
  }

  Widget buildImage(Uint8List bytes) =>
      bytes != null ? Image.memory(bytes) : Container();

  void _showSnackbar(String content) {
    final snackBar = SnackBar(content: (Text(content)));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> makePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: <pw.Widget>[
              pw.Image(
                pw.MemoryImage(
                  bytes1,
                ),
                height: 300,
                //fit: pw.BoxFit.fitHeight
              ),
              pw.SizedBox(width: 10),
              pw.Image(
                pw.MemoryImage(
                  bytes2,
                ),
                height: 300,
                //fit: pw.BoxFit.fitHeight
              ),
              // ImageImage(bytes1),
              //pw.Image(pw.MemoryImage(bytes1)),
            ]),
      ),
    );

// the downloads folder path
    //Directory output = await getDownloadsDirectory();
    // String tempPath = '/storage/emulated/0/Download';
    /* String tempPath = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS); */
    String apellidos =
        register.surnames != null ? register.surnames : "SIN APELLIDOS";
    String nombre = register.name != null ? register.name : "SIN NOMBRE";
    String tempPath = await getPublicExternalStorageDirectoryPath();

    /* if (downloadsDir != null) { */

    //print(downloadfolder); //output: /storage/emulated/0/Download

    //output.path;
    var pdfName = apellidos + " " + nombre + ".pdf";
    var filePath = tempPath + '/${pdfName.replaceAll(" ", "_")}';
    final file = File(filePath);
    //
    /* final output = await getExternalStorageDirectory();
    final path = "${output.path}/credencial.pdf";
    final file = File(path); */
    print(filePath);
    /* final file = File('example.pdf');*/
    if (_permissionStatus.isGranted) {
      await file.writeAsBytes(await pdf.save());
    } else {
      print('no tengo permiso');
      await _requestPermission();
      await file.writeAsBytes(await pdf.save());
    }
    print("hola");
    _showSnackbar("El PDF está en su carpeta de Descargas");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RenderCredentialScreen(
                  pdfPath: filePath,
                  pdfName: pdfName,
                )));
    //launch(filePath);
  } /* else {
      print("No download folder found.");
    } */

  Future<PermissionStatus> _requestPermission() async {
    Permission _permission = Permission.storage;
    PermissionStatus _status = await _permission.request();
    if (_status.isPermanentlyDenied) {
      print('denied');
      //await openAppSettings();
    }
    return _status;
  }

  Future<String> getPublicExternalStorageDirectoryPath() async {
    print('el estado del permiso es : $_permissionStatus');
    Directory directory;
    if (Platform.isIOS) {
      // Platform is imported from 'dart:io' package
      directory = await getApplicationDocumentsDirectory();
    } else if (Platform.isAndroid) {
      directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) {
        directory = await getExternalStorageDirectory();
      }
      print('mi directorio de descargas es $directory');
    }
    return directory.path;
  }
}
