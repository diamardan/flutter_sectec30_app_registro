import 'package:cetis32_app_registro/src/screens/login/login_email_screen.dart';
import 'package:cetis32_app_registro/src/screens/login/login_options_screen.dart';
import 'package:cetis32_app_registro/src/screens/login/recovery_screen.dart';
import 'package:flutter/material.dart';

class LoginNavigator extends StatelessWidget {
  const LoginNavigator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/emal':
                  return LoginEmailScreen();
                case "recovery-password":
                  return RecoveryPasswordScreen();

                default:
                  return LoginOptionsScreen();
              }
            });
      },
    );
  }
}
