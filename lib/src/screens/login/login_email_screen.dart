import 'dart:ffi';

import 'package:cetis32_app_registro/src/screens/home/home_sCreen.dart';
import 'package:cetis32_app_registro/src/screens/login/forget_password.dart';
import 'package:cetis32_app_registro/src/screens/login/request_password.dart';
import 'package:cetis32_app_registro/src/services/authentication_service.dart';
import 'package:cetis32_app_registro/src/utils/notify_ui.dart';
import 'package:cetis32_app_registro/src/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:cetis32_app_registro/src/constants/constants.dart';

class LoginMailScreen extends StatefulWidget {
  _LoginMailScreenState createState() => _LoginMailScreenState();
}

class _LoginMailScreenState extends State<LoginMailScreen> {
  bool loading = false;
  final _authService = AuthenticationService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _emailError = false;
  bool _passwordError = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  _signIn() async {
    _formKey.currentState.save();

    print(_formKey.currentState.validate());
    if (!_formKey.currentState.validate()) return;
    var _email = emailController.text.trim();
    var _password = passwordController.text.trim();
    var result = await _authService.signIn(email: _email, password: _password);
    if (result['code'] == "SUCCESS_LOGIN") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
    } else
      await NotifyUI.showError(
          context, "Error de inicio de sesión ", result['code']);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top,
      //decoration: BoxDecoration(color: Color(0Xcdcdcdff)),
      child: Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _form(),
              SizedBox(
                height: 20,
              ),
              _notHavePassword()
            ]),
      ),
    ))));
  }

  _form() {
    return (Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.05),
        border: Border.all(color: Colors.grey.withOpacity(0.7), width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: 280,
      height: 500,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Icon(
              Icons.account_circle_outlined,
              size: 50,
              color: AppColors.secondary.withOpacity(0.4),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "INICIAR SESIÓN EN CETIS 32",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.morenaLightColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Correo electrónico",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )),
            SizedBox(height: 10),
            _emailTextField(),
            SizedBox(
              height: 20,
            ),
            Row(children: [
              Expanded(child: Text("Contraseña")),
            ]),
            SizedBox(
              height: 10,
            ),
            _passwordTextField(),
            SizedBox(
              height: 14,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RequestPasswordScreen()));
                },
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPasswordScreen()));
                    },
                    child: Text(
                      "¿Olvidaste tu contraseña?",
                      style: TextStyle(color: Colors.blue),
                    ))),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signIn,
              child: Text("ENTRAR"),
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(260, 40),
                  primary: AppColors.morenaLightColor,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  textStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ));
  }

  _emailTextField() {
    return Container(
        height: !_emailError ? 40 : 60,
        child: TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            hintText: "",
          ),
          validator: (value) {
            var error = "";
            if (value.trim() == "") {
              setState(() {
                _emailError = true;
              });
              return "Campo requerido.";
            }
            error = ValidatorsLumen().validateEmail(value);
            if (error != "" && error != null) {
              setState(() {
                _emailError = true;
              });
              return error;
            }

            return null;
          },
        ));
  }

  _passwordTextField() {
    return Container(
        height: !_passwordError ? 40 : 60,
        child: TextFormField(
          controller: passwordController,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 1)),
          validator: (value) {
            if (value.trim() == "") {
              setState(() {
                _passwordError = true;
              });
              return "Campo requerido";
            }

            return null;
          },
        ));
  }

  _notHavePassword() {
    return Column(children: [
      Text(
        "Si no cuentas con contraseña",
        style: TextStyle(fontSize: 16),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("puedes ", style: TextStyle(fontSize: 16)),
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RequestPasswordScreen()));
            },
            child: Text(
              "solicitarla aquí",
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ))
      ])
    ]);
  }
}
