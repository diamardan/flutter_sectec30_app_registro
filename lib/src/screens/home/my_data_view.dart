import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/provider/user_provider.dart';
import 'package:cetis32_app_registro/src/services/registrationService.dart';
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

  Registration user;
  final RegistrationService userService = RegistrationService();

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

    user = userProvider.getRegistration;
    print(user.toString());
  }

  @override
  Widget build(BuildContext context) {
    double _fontSize = 22;
    double deviderHeight = 5;
    return SingleChildScrollView(
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
            Card(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  //color: Colors,
                  child: Text("Mis datos",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400))),
            ),
            Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                /*    decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  border: Border.all(
                      color: Colors.orange.withOpacity(
                          0.4), //AppColors.morenaLightColor.withOpacity(0.7),
                      width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                width: 280,
                height: 460,*/
                child: Container(
                    //padding: EdgeInsets.symmetric(horizontal: 20),
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: user != null
                        ? SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                _blockInfo("Apellidos:",
                                    "${user.surnames ?? "No disponible"}"),
                                _blockInfo("Nombre:",
                                    "${user.name ?? "No disponible"} "),
                                _blockInfo("Matricula", user.registrationCode),
                                _blockInfo("CURP", user.curp),
                                _blockInfo("Grado", user.grade),
                                _blockInfo("Grupo", user.group),
                                _blockInfo("Turno", user.turn),
                                _blockInfo("Correo", user.email),
                                _blockInfo("Celular", user.cellphone),
                                user.accessMethod == "email"
                                    ? Center(
                                        child: Container(
                                            color: Colors.white70,
                                            width: 260,
                                            height: 40,
                                            padding: EdgeInsets.all(0),
                                            child: TextButton(
                                                onPressed: () {
                                                  AuthSignPassword
                                                      .changePassword(context);
                                                },
                                                child: Text(
                                                    "Cambiar contraseña",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.blue)))))
                                    : Container(),
                              ]))
                        : Container())),
            SizedBox(height: 0),
            SizedBox(height: 5),
          ]),
        )
      ]),
    );
  }

  __blockInfo(label, field) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(label,
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.black45)),
            TextFormField(
              initialValue: field ?? "No disponible",
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            /*   Divider(
              height: 5,
              color: Colors.black54,
            )*/
          ],
        ));
  }

  _blockInfo(label, field) {
    return ListTile(
      subtitle: Text(label),
      title: TextFormField(
        initialValue: field ?? "No disponible",
        enabled: false,
        style: TextStyle(color: AppColors.morenaColor),
      ),
    );
  }
}
