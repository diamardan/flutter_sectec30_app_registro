import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/provider/user_provider.dart';
import 'package:cetis32_app_registro/src/screens/initial_screen.dart';
import 'package:cetis32_app_registro/src/services/AuthenticationService.dart';
import 'package:cetis32_app_registro/src/services/RegistrationService.dart';
import 'package:cetis32_app_registro/src/utils/enums.dart';
import 'package:cetis32_app_registro/src/utils/notify_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:provider/provider.dart';

class AuthSignPassword {
  static AuthenticationService authenticationService = AuthenticationService();
// * * *  Recovery password * * *

  static recoveryPassword(String email) async {
    Registration registration = await RegistrationService().checkEmail(email);
    if (registration == null)
      return {'code': AuthResponseStatus.EMAIL_NOT_FOUND};

    var result = await authenticationService.signInEmailAndPassword(
        email: email, password: "xxxxxx");

    print(result['code']);
    switch (result['code']) {
      case "user-not-found":
        return {"code": AuthResponseStatus.ACCOUNT_NOT_FOUND};
        break;
      case "wrong-password": //means user exists
        break;
      default:
        return {"code": AuthResponseStatus.AUTH_ERROR};
        break;
    }

    await authenticationService.remindPassword(email, registration.password);

    return {'code': AuthResponseStatus.SUCCESS};
  }

  static changePassword(
    BuildContext context,
  ) async {
    return showDialog(
        context: context,
        builder: (context) {
          return ChangePasswordDialog();
        });
  }
}

class ChangePasswordDialog extends StatefulWidget {
  ChangePasswordDialog({Key key}) : super(key: key);

  @override
  _ChangePasswordDialogState createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  TextEditingController _newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  static AuthenticationService authenticationService = AuthenticationService();

  changePassword(String password) async {
    var result = await authenticationService.changePassword(password);

    switch (result['code']) {
      case "password_changed_successful":
        success(password);
        break;
      case "requires-recent-login":
        await NotifyUI.showError(context, "Error al cambiar de contraseña",
            "Se requiere que inicie sesión nuevamente");
        break;
      default:
        await NotifyUI.showError(
            context, "Error al cambiar de contraseña", result['code']);
    }

    return {'code': AuthResponseStatus.SUCCESS};
  }

  void success(String password) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    var id = userProvider.getUser.id;
    Map<String, String> result =
        await authenticationService.savePassword(id, password);
    print(result.toString());
    Navigator.pop(context, true);
    NotifyUI.flushbarAutoHide(
        context, "La contraseña ha sido cambiada exitosamente.");
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Cambiar contraseña'),
      content: Form(
          key: _formKey,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(height: 20),
            Text("Escribe tu nueva contraseña:"),
            SizedBox(height: 5),
            Text(
              "(Debe tener 6 caracteres.)",
              style: TextStyle(fontSize: 12),
            ),
            Container(
                child: Stack(children: [
              TextFormField(
                maxLength: 6,
                autofocus: true,
                obscureText: !_passwordVisible,
                style: TextStyle(color: Colors.black),
                controller: _newPasswordController,
                validator: (value) {
                  if (value == "" || value == null)
                    return "Una contraseña es requerida";
                  if (value.length < 6)
                    return "La nueva contraseña no tiene la longitud requerida";
                  return null;
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ])),
            SizedBox(height: 10),
          ])),
      actions: <Widget>[
        ElevatedButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        ElevatedButton(
          child: Text('Aceptar'),
          onPressed: () async {
            _formKey.currentState.save();
            if (!_formKey.currentState.validate()) return;
            var password = _newPasswordController.text;
            changePassword(password);
          },
        ),
      ],
    );
  }
}
