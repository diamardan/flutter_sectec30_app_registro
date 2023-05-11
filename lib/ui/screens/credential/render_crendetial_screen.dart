import 'package:sectec30_app_registro/ui/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:cross_file/cross_file.dart';
/* 
class RenderCredentialScreen extends StatelessWidget {
  final String pdfPath;
  const RenderCredentialScreen({this.pdfPath, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PdfView(path: pdfPath);
  }
} */

class RenderCredentialScreen extends StatefulWidget {
  final String pdfPath;
  final String pdfName;

  RenderCredentialScreen({this.pdfPath, this.pdfName, Key key})
      : super(key: key);

  @override
  _RenderCredentialScreenState createState() => _RenderCredentialScreenState();
}

Future<void> sharePDFFile(String pdfPath) async {
  print('mi y pdfpath es $pdfPath');

  /* final ByteData bytes = await rootBundle.load(pdfPath);
  final String path = (await getTemporaryDirectory()).path;
  final String fileName = 'my_file.pdf'; */
  final File file = File('$pdfPath');
  //await file.writeAsBytes(bytes.buffer.asUint8List(), flush: true);
  await Share.shareFiles(['$pdfPath'], mimeTypes: ['application/pdf']);
}

class _RenderCredentialScreenState extends State<RenderCredentialScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(this.widget.pdfName),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.white,
            ),
            onPressed: () {
              sharePDFFile(this.widget.pdfPath);
            },
          ),
        ],
      ),
      body: SfPdfViewer.file(
        File(this.widget.pdfPath),
        key: _pdfViewerKey,
      ),
    );
  }
}
