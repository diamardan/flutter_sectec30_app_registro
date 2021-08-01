/*import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:mime_type/mime_type.dart';
import 'package:cetis32_app_registro/src/utils/net_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cetis32_app_registro/src/services/SharedService.dart';

class RegisterService {

  checkCurp(String curp) async {
     return SharedService().get(curp, "registers");
  }

  /*finish(Map<String, dynamic> alumno, File foto,  firma) async {
    String url =  AppConstants.backendUrl + '/preregistros/finish';
    final dir = await getTemporaryDirectory();
    await dir.create(recursive:true);
    final imgFirma = File( path.join(dir.path, "firma.jpg"));//  '${(await getTemporaryDirectory()).path}/lumen_app/firma.jpg');
    await imgFirma.writeAsBytes(firma.buffer.asUint8List(firma.offsetInBytes, firma.lengthInBytes));
    final endpoint = Uri.parse(url);
    final fotoMime = mime(foto.path).split('/');
    final firmaMime = mime(imgFirma.path).split('/');

    var request = http.MultipartRequest('POST', endpoint)
    ..fields['ID_REGISTRO'] = alumno['ID_REGISTRO']
    ..fields["NOMBRE"] = alumno['NOMBRE']
    ..fields["APELLIDOS"] = alumno['APELLIDOS']
    ..fields["CURP"] = alumno['CURP']
    ..fields["CORREO"] = alumno['CORREO']
    ..fields["CELULAR"] = alumno['CELULAR']
    ..fields["IDESPECIALIDAD"] = alumno['IDESPECIALIDAD']
    ..fields["IDSEMESTRE"] = alumno['IDSEMESTRE']
    ..fields["IDGRUPO"] = alumno['IDGRUPO']
    ..fields["IDTURNO"] = alumno['IDTURNO']
    ..fields["MATRICULA"] = alumno['MATRICULA'];

    if(foto != null){
      request.files.add(await http.MultipartFile.fromPath('foto', foto.path,
      contentType: MediaType(fotoMime[0], fotoMime[1]),
      filename: "FOTO"));
    }
    if(firma != null){
      request.files.add(await http.MultipartFile.fromPath('firma', imgFirma.path,
      contentType: MediaType('image', 'jpg'), /* MediaType(firmaMime[0], firmaMime[1] )*/
      filename: "FIRMA"));
    }
    
    var responseJson;

    try{
      final streamResponse = await request.send();
      final response = await http.Response.fromStream(streamResponse);
      responseJson = returnResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException("No internet Connection");
    }
    //return responseJson;
    
  }*/
}