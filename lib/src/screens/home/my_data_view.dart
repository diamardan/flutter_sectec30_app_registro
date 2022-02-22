import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/provider/user_provider.dart';
import 'package:cetis32_app_registro/src/screens/home/digital_credential_screen.dart';
import 'package:cetis32_app_registro/src/services/RegistrationService.dart';
import 'package:cetis32_app_registro/src/utils/auth_sign_psw.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDataView extends StatefulWidget {
  MyDataView({Key key}) : super(key: key);

  @override
  _MyDataViewState createState() => _MyDataViewState();
}

class _MyDataViewState extends State<MyDataView> {
  UserProvider userProvider;
  User user;
  Registration registration;
  final RegistrationService registrationService = RegistrationService();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getStudentData();
  }

  _getStudentData() {
    userProvider = Provider.of<UserProvider>(context, listen: true);
    user = userProvider.getUser;
    registration = userProvider.getRegistration;
    print(user.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis datos"),
        backgroundColor: AppColors.morenaLightColor,
      ),
      body: SingleChildScrollView(
          child: Stack(children: [
        Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                kToolbarHeight -
                kBottomNavigationBarHeight,
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
                      color: Colors.orange.withOpacity(
                          0.4), //AppColors.morenaLightColor.withOpacity(0.7),
                      width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                width: 280,
                height: 460,
                child: registration != null
                    ? SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text(
                              "${registration.name ?? "No disponible"} ${registration.surnames ?? "No disponible"}",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                            Divider(
                              height: 5,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Matrícula",
                              style: TextStyle(color: Colors.black45),
                            ),
                            Text(registration.registrationCode ??
                                "No disponible"),
                            SizedBox(height: 20),
                            Text("CURP",
                                style: TextStyle(color: Colors.black45)),
                            Text(registration.curp ?? "No disponible"),
                            SizedBox(height: 20),
                            Text("Grado",
                                style: TextStyle(color: Colors.black45)),
                            Text(registration.grade ?? "No disponible"),
                            SizedBox(height: 20),
                            Text("Grupo",
                                style: TextStyle(color: Colors.black45)),
                            Text(registration.group ?? "No disponible"),
                            SizedBox(height: 20),
                            Text("Turno",
                                style: TextStyle(color: Colors.black45)),
                            Text(registration.turn ?? "No disponible"),
                            SizedBox(height: 20),
                            Text("Correo",
                                style: TextStyle(color: Colors.black45)),
                            Text(registration.email ?? "No disponible"),
                            SizedBox(height: 20),
                            Text("Celular",
                                style: TextStyle(color: Colors.black45)),
                            Text(registration.cellphone ?? "No disponible"),
                          ]))
                    : Container()),
            SizedBox(height: 20),
            user.accessMethod == "email"
                ? Container(
                    color: Colors.white70,
                    width: 260,
                    height: 40,
                    padding: EdgeInsets.all(0),
                    child: OutlinedButton(
                        onPressed: () {
                          AuthSignPassword.changePassword(context);
                        },
                        child: Text("Cambiar contraseña",
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.morenaLightColor
                                    .withOpacity(0.7)))))
                : Container(),
            SizedBox(height: 5),
            Container(
                color: Colors.white70,
                width: 260,
                height: 40,
                padding: EdgeInsets.all(0),
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DigitalCredentialScreen(registration)));
                      //AuthActions.showChangePassword(context);
                    },
                    child: Text("Credencial digital",
                        style: TextStyle(
                            fontSize: 13,
                            color:
                                AppColors.morenaLightColor.withOpacity(0.7)))))
          ]),
        )
      ])),
    );
  }
}
