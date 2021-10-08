import 'dart:io';

import 'package:cetis32_app_registro/src/services/RegisterService.dart';
import 'package:cetis32_app_registro/src/services/authentication_service.dart';
import 'package:cetis32_app_registro/src/utils/auth_methods.dart';
import 'package:cetis32_app_registro/src/utils/enums.dart';
import 'package:cetis32_app_registro/src/utils/notify_ui.dart';
import 'package:flutter/material.dart';
import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'dart:math';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cetis32_app_registro/src/utils/validator.dart';

class RequestPasswordScreen extends StatefulWidget {
  _RequestPasswordScreenState createState() => _RequestPasswordScreenState();
}

class _RequestPasswordScreenState extends State<RequestPasswordScreen> {
  bool showeSigInButton = false;
  bool enabledSendButton = true;
  bool loading = false;
  final _authService = AuthenticationService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = "";
  bool emailError = false;

  @override
  void dispose() {
    super.dispose();
  }

  String generatePassword() {
    final length = 12;
    final letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    final letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    final number = '01234567890123456789';
    final special = '@#%+&@#%+&';

    String chars = "";
    chars += '$letterLowerCase$letterUpperCase';
    chars += '$number';
    chars += '$special';

    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join('');
  }

  _createAccount() async {
    setState(() {
      loading = true;
    });

    _formKey.currentState.save();
    if (!_formKey.currentState.validate()) return;

    var result = await AuthMethods.signUpWithEmailAndPassword(_email);
    switch (result['code']) {
      case AuthResponseStatus.SUCCESS:
        NotifyUI.flushbar(context, "El correo electrónico ha sido enviado.");
        setState(() {
          enabledSendButton = false;
          showeSigInButton = true;
        });
        break;
      case AuthResponseStatus.EMAIL_ALREADY_EXISTS:
        await NotifyUI.showError(context, "Error de activación de cuenta",
            "Ya existe una cuenta activa para este correo. ");
        break;
      case AuthResponseStatus.EMAIL_NOT_FOUND:
        await NotifyUI.showError(context, "Error de activación de cuenta",
            "El correo proporcionado no fue encontrado. ");
        break;
      case AuthResponseStatus.AUTH_ERROR:
        await NotifyUI.showError(
            context, "Error de activación de cuenta ", result['code']);
        break;
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            //resizeToAvoidBottomInset: false,
            body: ModalProgressHUD(
      inAsyncCall: loading,
      child: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
              //decoration: BoxDecoration(color: Color(0Xcdcdcdff)),
              child: Center(
                child: _content(),
              ))),
    )));
  }

  _content() {
    return (Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.secondary.withOpacity(0.05),
          border: Border.all(color: Colors.grey.withOpacity(0.7), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        width: 280,
        height: 560,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "ACTIVAR CUENTA",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.morenaLightColor),
            ),
            SizedBox(
              height: 10,
            ),
            Icon(
              Icons.alternate_email_sharp,
              size: 50,
              color: AppColors.secondary.withOpacity(0.4),
            ),
            SizedBox(
              height: 20,
            ),
            _form(),
            SizedBox(
              height: 20,
            ),
            showeSigInButton == true
                ? OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("INICIAR SESIÓN"),
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.morenaLightColor)),
                  )
                : Container(),
            SizedBox(
              height: 20,
            ),
          ],
        )));
  }

  _form() {
    return Form(
        key: _formKey,
        child: Column(children: [
          Text(
            "Introduce el correo electrónico que registraste ",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w600, color: AppColors.secondary),
          ),
          SizedBox(
            height: 10,
          ),
          _emailTextField(),
          SizedBox(
            height: 20,
          ),
          Text(
            "Activaremos tu cuenta y te enviaremos un correo electrónico con tu contraseña",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: _email != "" && enabledSendButton == true
                ? _createAccount
                : null,
            child: Text("ENVIAR CORREO"),
            style: ElevatedButton.styleFrom(
                primary: AppColors.morenaLightColor.withOpacity(0.9),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                textStyle:
                    TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ]));
  }

  _emailTextField() {
    return Container(
        height: !emailError ? 50 : 60,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          maxLength: 50,
          decoration: InputDecoration(
              //contentPadding: const EdgeInsets.all(8.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 1),
              hintText: "",
              isCollapsed: false,
              counter: Offstage()),
          validator: (value) {
            var error = ValidatorsLumen().validateEmail(value);
            if (error != null) {
              setState(() {
                emailError = true;
              });
              return error;
            }
            return null;
          },
          onChanged: (value) {
            setState(() {
              _email = value.trim();
            });
          },
        ));
  }
}
