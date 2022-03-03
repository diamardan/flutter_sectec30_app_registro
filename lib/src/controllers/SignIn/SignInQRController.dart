import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:cetis32_app_registro/src/controllers/SignIn/SignInController.dart';
import 'package:qr_code_tools/qr_code_tools.dart';

class SignInQRController extends SignInController {
  Future<String> scanQR() async {
    var options = ScanOptions(
      restrictFormat: [BarcodeFormat.qr],
    );
    var futureString = await BarcodeScanner.scan(options: options);
    return futureString.rawContent;
  }

  Future<String> decodeImage(String imagePath) async {
    String qrString = await QrCodeToolsPlugin.decodeFrom(imagePath);
    return qrString;
  }

  // * * *  Sing in with code QR from Camera  * * *
  Future<Map<String, dynamic>> authenticate(String qr) async {
    r = await registrationService.checkQr(qr);
    if (r == null)
      return {"code": "user_not_found", "message": "Usuario no encontrado."};

    await authenticationService.signInAnonymously();
    var res = await registerDevice(r);
    if (res == "max_devices_registered")
      return {
        "code": res,
        "message": "Verifique el número de dispositivos de su licencia"
      };
    subscribeToTopics(r);
    return {"code": "success", "data": r};
  }
}
