import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/utils/net_util.dart';

class AccesosService {
  getAll() async {
    String endpoint = AppConstants.backendUrl + '/accesos/getAll';
    var uri = Uri.parse(endpoint);
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };
    var responseJson;
    try {
      final response = await http.get(uri, headers: headers);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    print("\nmi respuesta es $responseJson   \n la url es $endpoint");
    print(responseJson);
    return responseJson;
  }

  getAllById(String idbio) async {
    String endpoint = AppConstants.backendUrl + '/cetis32/accesos/getAllById';
    var uri = Uri.parse(endpoint);
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };
    String json = jsonEncode(<String, String>{
      "idbio": idbio,
    });
    var responseJson;
    try {
      http.Response response =
          await http.post(uri, headers: headers, body: json);
      print(response);
      int statusCode = response.statusCode;
      String data = response.body;
      print(data);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    print("\nmi respuesta es $responseJson   \n la url es $endpoint");
    print(responseJson);
    return responseJson;
  }
}
