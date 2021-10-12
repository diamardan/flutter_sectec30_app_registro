import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/provider/user_provider.dart';
import 'package:cetis32_app_registro/src/services/RegistrationService.dart';
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
  Registration registration = Registration();
  final RegistrationService registrationService = RegistrationService();
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
    Registration _registration = await registrationService.get(user.id);

    if (registration != null) {
      setState(() {
        registration = _registration;
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
                        "${registration.name ?? "No disponible"} ${registration.surnames ?? "No disponible"}",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20),
                      Text("Matrícula"),
                      Text(registration.registrationCode ?? "No disponible"),
                      SizedBox(height: 20),
                      Text("CURP"),
                      Text(registration.curp ?? "No disponible"),
                      SizedBox(height: 20),
                      Text("Grado"),
                      Text(registration.grade ?? "No disponible"),
                      SizedBox(height: 20),
                      Text("Grupo"),
                      Text(registration.group ?? "No disponible"),
                      SizedBox(height: 20),
                      Text("Turno"),
                      Text(registration.turn ?? "No disponible"),
                      SizedBox(height: 20),
                      Text("Correo"),
                      Text(registration.email ?? "No disponible"),
                      SizedBox(height: 20),
                      Text("Celular"),
                      Text(registration.cellphone ?? "No disponible"),
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
                : Container()
          ]),
        )
      ])),
    ));
  }
}
