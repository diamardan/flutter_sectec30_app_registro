import 'dart:typed_data';
import 'dart:io';
import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/utils/imageUtil.dart';
import 'package:cetis32_app_registro/src/utils/widget_to_image.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class DigitalCredentialScreen extends StatefulWidget {
  final Register register;
  DigitalCredentialScreen(this.register, {Key key}) : super(key: key);

  @override
  _DigitalCredentialScreenState createState() =>
      _DigitalCredentialScreenState();
}

class _DigitalCredentialScreenState extends State<DigitalCredentialScreen> {
  GlobalKey key1;
  GlobalKey key2;
  Uint8List bytes1;
  Uint8List bytes2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MI CREDENCIAL"),
        centerTitle: true,
        backgroundColor: AppColors.morenaLightColor,
      ),
      floatingActionButton: FloatingActionButton.small(
          backgroundColor: AppColors.morenaColor,
          child: Icon(Icons.download),
          onPressed: () async {
            _showSnackbar("Su descarga comenzará en breve");
            final bytes1 = await ImageUtils.capture(key1);
            final bytes2 = await ImageUtils.capture(key2);

            setState(() {
              this.bytes1 = bytes1;
              this.bytes2 = bytes2;
            });
            makePdf();
          }),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(children: <Widget>[
            _anversoCredencial(),
            WidgetToImage(builder: (key) {
              this.key2 = key;
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 10,
                child: Container(
                  height: 490,
                  width: 310,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        image: AssetImage('assets/img/credencial/reverso.png')),
                  ),
                  child: Column(
                    children: <Widget>[
                      _cintillaTurno(),
                      _espacioQR(),
                      _firmaAlumno(),
                      _fotoReverso()
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

  Widget _anversoCredencial() {
    return WidgetToImage(builder: (key) {
      this.key1 = key;
      return Card(
        /* semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer, */
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 10,
        child: Container(
          height: 490,
          width: 310,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            image: DecorationImage(
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                image: AssetImage('assets/img/credencial/anverso.png')),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 128),
              _cintillaFoto(),
              _cintillaBlanca(),
              _cintillaNombre(),
              _cintillaEspecialidad(),
              _cintillaNumeroControl(),
              /* Container(
                        width: double.infinity,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              //color: AppColors.morenaColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          width: double.infinity,
                          child: Text("hola 1"),
                        ), 
                      )*/
            ],
          ),
        ),
      );
    });
  }

  Widget _cintillaFoto() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 174,
          width: 81,
          /* child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("IDBIO"),
                              Text("IDBIO"),
                            ],
                          ), */
        ),
        Container(
          height: 174,
          width: 148,
          child: Image.network(
            'https://drive.google.com/uc?export=view&id=${widget.register.fotoUsuarioDrive}',
            alignment: Alignment.center,
            fit: BoxFit.fill,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              width: 80,
              child: Text(
                widget.register.grupo != null ? widget.register.grupo : "",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              "GRUPO",
              style: TextStyle(color: Colors.white),
            )
          ],
        )
      ],
    );
  }

  Widget _cintillaBlanca() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 70,
          //color: Colors.red,
          child: Column(
            children: [
              Text(
                widget.register.idbio.toString() != null
                    ? widget.register.idbio.toString()
                    : "-",
                style: TextStyle(color: AppColors.textoRojoCredencial),
              ),
              Text(
                "IDBIO",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textoRojoCredencial),
              ),
            ],
          ),
        ),
        Container(
          width: 170,
          //color: Colors.blue,
          child: Column(
            children: [
              Text(
                widget.register.id != null ? widget.register.id : '-',
                style: TextStyle(color: AppColors.textoRojoCredencial),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "ALUMNO",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textoRojoCredencial),
              ),
            ],
          ),
        ),
        Container(
          width: 70,
          //color: Colors.green,
          child: Column(
            children: [
              Text(
                widget.register.grado != null ? widget.register.grado : "-",
                style: TextStyle(color: AppColors.textoRojoCredencial),
              ),
              Text(
                "SEMESTRE",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textoRojoCredencial),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _cintillaNombre() {
    return Container(
      height: 60,
      width: double.infinity,
      //color: Colors.blueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 30,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                  widget.register.nombre != null ? widget.register.nombre : "-",
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ),
          Container(
            height: 30,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                  widget.register.apellidos != null
                      ? widget.register.apellidos
                      : "-",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cintillaEspecialidad() {
    return Container(
      height: 40,
      width: double.infinity,
      //color: Colors.amber,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 20,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text("ESPECIALIDAD",
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textoRojoCredencial)),
            ),
          ),
          Container(
            height: 20,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                  widget.register.carrera != null
                      ? widget.register.carrera
                      : "-",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textoRojoCredencial)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cintillaNumeroControl() {
    return Container(
      height: 35,
      child: Column(
        children: <Widget>[
          Text(
            'No. CONTROL   ${widget.register.matricula != "" ? widget.register.matricula : "NO CAPTURADO"}',
            style: TextStyle(color: AppColors.textoRojoCredencial),
          ),
          Image.asset(
            'assets/img/credencial/barcode.PNG',
            fit: BoxFit.fitWidth,
            width: double.infinity,
          )
        ],
      ),
    );
  }

  Widget _cintillaTurno() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
      //color: Colors.red,
      height: 30,
      width: double.infinity,
      child: Text(
        widget.register.turno != null ? widget.register.turno : "-",
        textAlign: TextAlign.right,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _espacioQR() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          //color: Colors.amber,
        ),
        Container(
          width: 150,
          height: 150,
          //color: Colors.redAccent,
          child: Column(
            children: [
              SizedBox(
                height: 35,
              ),
              Image.network(
                'https://drive.google.com/uc?export=view&id=${widget.register.qrDrive}',
                height: 110,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _firmaAlumno() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 100,
          height: 90,
          //color: Colors.amber,
        ),
        Container(
          width: 200,
          height: 60,
          margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
          //color: Colors.redAccent,
          child: Image.network(
            'https://drive.google.com/uc?export=view&id=${widget.register.firmaDrive}',
            height: 50,
            //fit: BoxFit.fitHeight,
          ),
        ),
      ],
    );
  }

  Widget _fotoReverso() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(0),
          //color: Colors.green,
          height: 90,
          width: 80,
          child: Image.network(
            'https://drive.google.com/uc?export=view&id=${widget.register.fotoUsuarioDrive}',
            color: const Color.fromRGBO(255, 255, 255, 0.5),
            colorBlendMode: BlendMode.modulate,
            alignment: Alignment.center,
            fit: BoxFit.fill,
          ),
        )
      ],
    );
  }

  Widget buildImage(Uint8List bytes) =>
      bytes != null ? Image.memory(bytes) : Container();

  void _showSnackbar(String content) {
    final snackBar = SnackBar(content: (Text(content)));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> makePdf() async {
    final pdf = pw.Document();

    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Row(
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
    String tempPath = '/storage/emulated/0/Download';
    //output.path;
    var filePath = tempPath + '/${widget.register.curp}.pdf';
    final file = File(filePath);
    //
    /* final output = await getExternalStorageDirectory();
    final path = "${output.path}/credencial.pdf";
    final file = File(path); */
    print(filePath);
    /* final file = File('example.pdf');*/
    await file.writeAsBytes(await pdf.save());
    print("hola");
    _showSnackbar("El PDF está en su carpeta de Descargas");
  }
}

/* class DigitalCredentialScreen extends StatelessWidget {
  final widget.register widget.register;
  
  const DigitalCredentialScreen(this.widget.register, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey key1;
    GlobalKey key2;
    return Scaffold(
      appBar: AppBar(
        title: Text("MI CREDENCIAL"),
        centerTitle: true,
        backgroundColor: AppColors.morenaLightColor,
      ),
      floatingActionButton: FloatingActionButton.small(
          backgroundColor: AppColors.morenaColor,
          child: Icon(Icons.download),
          onPressed: () {}),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(children: <Widget>[
            WidgetToImage(
              builder: (key) => Card(
                /* semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer, */
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 10,
                child: Container(
                  height: 490,
                  width: 310,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        image: AssetImage('assets/img/credencial/anverso.png')),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 128),
                      _cintillaFoto(),
                      _cintillaBlanca(),
                      _cintillaNombre(),
                      _cintillaEspecialidad(),
                      _cintillaNumeroControl(),
                      /* Container(
                        width: double.infinity,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              //color: AppColors.morenaColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          width: double.infinity,
                          child: Text("hola 1"),
                        ), 
                      )*/
                    ],
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 10,
              child: Container(
                height: 490,
                width: 310,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      image: AssetImage('assets/img/credencial/reverso.png')),
                ),
                child: Column(
                  children: <Widget>[
                    _cintillaTurno(),
                    _espacioQR(),
                    _firmaAlumno(),
                    _fotoReverso()
                  ],
                ),
              ),
            ),
          ]),
        ),
      )),
    );
  }

  Widget _cintillaFoto() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 174,
          width: 81,
          /* child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("IDBIO"),
                              Text("IDBIO"),
                            ],
                          ), */
        ),
        Container(
          height: 174,
          width: 148,
          child: Image.network(
            'https://drive.google.com/uc?export=view&id=${widget.register.fotoUsuarioDrive}',
            alignment: Alignment.center,
            fit: BoxFit.fill,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              width: 80,
              child: Text(
                widget.register.grupo != null ? widget.register.grupo : "",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              "GRUPO",
              style: TextStyle(color: Colors.white),
            )
          ],
        )
      ],
    );
  }

  Widget _cintillaBlanca() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 70,
          //color: Colors.red,
          child: Column(
            children: [
              Text(
                widget.register.idbio.toString() != null
                    ? widget.register.idbio.toString()
                    : "-",
                style: TextStyle(color: AppColors.textoRojoCredencial),
              ),
              Text(
                "IDBIO",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textoRojoCredencial),
              ),
            ],
          ),
        ),
        Container(
          width: 170,
          //color: Colors.blue,
          child: Column(
            children: [
              Text(
                widget.register.id != null ? widget.register.id : '-',
                style: TextStyle(color: AppColors.textoRojoCredencial),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "ALUMNO",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textoRojoCredencial),
              ),
            ],
          ),
        ),
        Container(
          width: 70,
          //color: Colors.green,
          child: Column(
            children: [
              Text(
                widget.register.grado != null ? widget.register.grado : "-",
                style: TextStyle(color: AppColors.textoRojoCredencial),
              ),
              Text(
                "SEMESTRE",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textoRojoCredencial),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _cintillaNombre() {
    return Container(
      height: 60,
      width: double.infinity,
      //color: Colors.blueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 30,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(widget.register.nombre != null ? widget.register.nombre : "-",
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ),
          Container(
            height: 30,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(widget.register.apellidos != null ? widget.register.apellidos : "-",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cintillaEspecialidad() {
    return Container(
      height: 40,
      width: double.infinity,
      //color: Colors.amber,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 20,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text("ESPECIALIDAD",
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textoRojoCredencial)),
            ),
          ),
          Container(
            height: 20,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(widget.register.carrera != null ? widget.register.carrera : "-",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textoRojoCredencial)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cintillaNumeroControl() {
    return Container(
      height: 35,
      child: Column(
        children: <Widget>[
          Text(
            'No. CONTROL   ${widget.register.matricula != "" ? widget.register.matricula : "NO CAPTURADO"}',
            style: TextStyle(color: AppColors.textoRojoCredencial),
          ),
          Image.asset(
            'assets/img/credencial/barcode.PNG',
            fit: BoxFit.fitWidth,
            width: double.infinity,
          )
        ],
      ),
    );
  }

  Widget _cintillaTurno() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
      //color: Colors.red,
      height: 30,
      width: double.infinity,
      child: Text(
        widget.register.turno != null ? widget.register.turno : "-",
        textAlign: TextAlign.right,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _espacioQR() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          //color: Colors.amber,
        ),
        Container(
          width: 150,
          height: 150,
          //color: Colors.redAccent,
          child: Column(
            children: [
              SizedBox(
                height: 35,
              ),
              Image.network(
                'https://drive.google.com/uc?export=view&id=${widget.register.qrDrive}',
                height: 110,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _firmaAlumno() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 100,
          height: 90,
          //color: Colors.amber,
        ),
        Container(
          width: 200,
          height: 60,
          margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
          //color: Colors.redAccent,
          child: Image.network(
            'https://drive.google.com/uc?export=view&id=${widget.register.firmaDrive}',
            height: 50,
            //fit: BoxFit.fitHeight,
          ),
        ),
      ],
    );
  }

  Widget _fotoReverso() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(0),
          //color: Colors.green,
          height: 90,
          width: 80,
          child: Image.network(
            'https://drive.google.com/uc?export=view&id=${widget.register.fotoUsuarioDrive}',
            color: const Color.fromRGBO(255, 255, 255, 0.5),
            colorBlendMode: BlendMode.modulate,
            alignment: Alignment.center,
            fit: BoxFit.fill,
          ),
        )
      ],
    );
  }
}
 */
