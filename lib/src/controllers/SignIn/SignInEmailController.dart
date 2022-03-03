import 'package:cetis32_app_registro/src/controllers/SignIn/SignInController.dart';
import 'package:cetis32_app_registro/src/services/RegistrationService.dart';

class SignInEmailController extends SignInController {
  Future<Map<String, dynamic>> authenticate(
      String email, String password) async {
    r = await RegistrationService().checkEmail(email);
    if (r == null)
      return {"code": "user_not_found", "message": "Usuario no encontrado"};
    var result = await authenticationService.signInEmailAndPassword(
        email: email, password: password);

    var code = result['code'];
    switch (code) {
      case "sign_in_success":
        String res = await registerDevice(r);
        if (res == "max_devices_registered")
          return {
            "code": res,
            "message": "Verifique el número de dispositivos de tu licencia"
          };
        subscribeToTopics(r);
        return {"code": code, "data": r};
      case "user-not-found":
        return {
          "code": code,
          "message":
              "No tienes activado el acceso por este medio. Solicita la activación de tu cuenta."
        };
      case "wrong-password":
        return {"code": code, "message": "Contraseña incorrecta."};
      default:
        return {"code": code, "message": "No se identificó al usuario."};
    }
  }

  Future<Map<String, String>> recoveryPassword(String email) async {
    r = await RegistrationService().checkEmail(email);

    if (r == null) {
      return {"code": "user_not_found", "message": "Usuario no encontrado"};
    }

    var result = await authenticationService.signInEmailAndPassword(
        email: email, password: "xxxxxx");

    if (result['code'] == "wrong-password") //means user exists
    {
      await authenticationService.remindPassword(email, r.password);
      return {'code': "success"};
    } else {
      return {"code": "error", "message": "Cuenta no identificada."};
    }
  }
}
