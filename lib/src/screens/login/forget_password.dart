import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/services/RegistrationService.dart';
import 'package:cetis32_app_registro/src/services/AuthenticationService.dart';
import 'package:cetis32_app_registro/src/utils/auth_methods.dart';
import 'package:cetis32_app_registro/src/utils/enums.dart';
import 'package:cetis32_app_registro/src/utils/notify_ui.dart';
import 'package:flutter/material.dart';
import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'dart:math';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cetis32_app_registro/src/utils/validator.dart';

class ForgetPasswordScreen extends StatefulWidget {
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  bool showSignInButton = false;
  bool loading = false;
  final _authService = AuthenticationService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = "";
  bool enabledSendButton = false;
  bool emailError = false;

  @override
  void dispose() {
    super.dispose();
  }

  _recoveryPassword() async {
    _formKey.currentState.save();
    if (!_formKey.currentState.validate()) return;
    setState(() {
      loading = true;
    });
    var result = await AuthMethods.recoveryPassword(_email);

    switch (result['code']) {
      case AuthResponseStatus.SUCCESS:
        setState(() {
          loading = false;
          enabledSendButton = false;
          showSignInButton = true;
        });
        NotifyUI.flushbar(context,
            "El correo electrónico de restablecimiento de contraseña ha sido enviado");
        break;

      case AuthResponseStatus.EMAIL_NOT_FOUND:
      case AuthResponseStatus.ACCOUNT_NOT_FOUND:
        setState(() {
          loading = false;
        });
        await NotifyUI.showError(
          context,
          "Error de recuperación de contraseña ",
          "No existe una cuenta asociada a este correo electrónico.",
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
              //decoration: BoxDecoration(color: Color(0Xcdcdcdff)),
              child: Center(
                  child: ModalProgressHUD(
                      inAsyncCall: loading,
                      child: SingleChildScrollView(
                        child: Center(
                          child: _content(),
                        ),
                      ))))),
    ));
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
              "RESTABLECER CONTRASEÑA",
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
            showSignInButton == true
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
            "Introduce tu correo electrónico activado",
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
            "Te enviaremos un correo electrónico con un enlace para restablecer tu contraseña.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: _email != ""
                ? () async {
                    _recoveryPassword();
                  }
                : null,
            child: Text("ENVIAR CORREO ELECTRÓNICO"),
            style: ElevatedButton.styleFrom(
                primary: AppColors.morenaLightColor.withOpacity(0.9),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
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
          decoration: InputDecoration(
              //contentPadding: const EdgeInsets.all(8.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 1),
              hintText: "",
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
