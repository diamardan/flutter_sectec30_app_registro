import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/provider/user_provider.dart';
import 'package:cetis32_app_registro/src/screens/home/digital_credential_screen.dart';
import 'package:cetis32_app_registro/src/services/RegisterService.dart';
import 'package:cetis32_app_registro/src/utils/auth_actions.dart';
import 'package:cetis32_app_registro/src/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDataView extends StatefulWidget {
  MyDataView({Key key}) : super(key: key);

  @override
  _MyDataViewState createState() => _MyDataViewState();
}

class _MyDataViewState extends State<MyDataView> {
  UserProvider userProvider;
  User user;
  Register register = Register();
  final RegisterService registerService = RegisterService();
  bool showCnangePassword = false;

  @override
  void initState() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    user = userProvider.getUser;

    _getStudentData();

    super.initState();
  }

  _getStudentData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (user == null) {
      var id = prefs.getString("registration_id");
      var authMethod = prefs.getString("auth_method");
      user = User(id, authMethod);
    }
    if (user.authMethod == AuthnMethodEnum.EMAIL_PASSWORD)
      setState(() {
        showCnangePassword = true;
      });
    Register _register = await registerService.get(user.id);

    if (register != null) {
      setState(() {
        register = _register;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("MIS DATOS"),
        centerTitle: true,
        backgroundColor: AppColors.morenaLightColor,
      ),
      body: SingleChildScrollView(
          child: Stack(children: [
        Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/img/fondo.jpg')))),
        Center(
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  border: Border.all(
                      color: AppColors.morenaLightColor.withOpacity(0.7),
                      width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                width: 280,
                height: 460,
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Text(
                        "${register.nombre ?? "No disponible"} ${register.apellidos ?? "No disponible"}",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20),
                      Text("Matrícula"),
                      Text(register.matricula ?? "No disponible"),
                      SizedBox(height: 20),
                      Text("CURP"),
                      Text(register.curp ?? "No disponible"),
                      SizedBox(height: 20),
                      Text("Grado"),
                      Text(register.grado ?? "No disponible"),
                      SizedBox(height: 20),
                      Text("Grupo"),
                      Text(register.grupo ?? "No disponible"),
                      SizedBox(height: 20),
                      Text("Turno"),
                      Text(register.turno ?? "No disponible"),
                      SizedBox(height: 20),
                      Text("Correo"),
                      Text(register.correo ?? "No disponible"),
                      SizedBox(height: 20),
                      Text("Celular"),
                      Text(register.celular ?? "No disponible"),
                    ]))),
            showCnangePassword == true
                ? OutlinedButton(
                    onPressed: () {
                      AuthActions.showChangePassword(context);
                    },
                    child: Text("Cambiar contraseña",
                        style: TextStyle(
                            fontSize: 13,
                            color:
                                AppColors.morenaLightColor.withOpacity(0.7))))
                : Container(),
            OutlinedButton(
                onPressed: () {
                  print(register);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DigitalCredentialScreen(register)));
                  //AuthActions.showChangePassword(context);
                },
                child: Text("Credencial digital",
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.morenaLightColor.withOpacity(0.7))))
          ]),
        )
      ])),
    ));
  }
}
