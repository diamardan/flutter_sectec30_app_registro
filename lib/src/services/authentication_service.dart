import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:mime_type/mime_type.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get authStateChanges => _auth.authStateChanges();

  Future<Map<String, String>> signIn({String email, String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return {"code": "SUCCESS_LOGIN"};
    } on FirebaseAuthException catch (e) {
      return {"code": e.code};
    }
  }

  Future<String> signInAnonymously() async {
    try {
      await _auth.signInAnonymously();
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<Map<String, String>> signUp({String email, String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return {"code": "SUCCESS_LOGIN"};
    } on FirebaseAuthException catch (e) {
      return {"code": e.code};
    }
  }

  Future<String> signOut() async {
    try {
      await _auth.signOut();
      return "Signed out";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<Map<String, String>> sendEmailResetPassword({String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return {"code": "SUCCESS_LOGIN"};
    } on FirebaseAuthException catch (e) {
      return {"code": e.code};
    }
  }

  User getUser() {
    try {
      return _auth.currentUser;
    } on FirebaseAuthException {
      return null;
    }
  }

  sendEmailWithPassword(String email, String password) async {
    String endpoint = 'https://api.escuelas.infon.mx/api/v1/signUp/sendPEmail';
    var uri = Uri.parse(endpoint);
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };
    String json =
        jsonEncode(<String, String>{"email": email, "password": password});
    http.Response response = await http.post(uri, headers: headers, body: json);
    int statusCode = response.statusCode;
    String data = response.body;
    print(data);
    return jsonDecode(data);
  }
}
