import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/provider/user_provider.dart';
import 'package:cetis32_app_registro/src/services/registrationService.dart';
import 'package:cetis32_app_registro/src/utils/auth_sign_psw.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/cupertino.dart';
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

  bool useNotificationDotOnAppIcon = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Perfil'),
          centerTitle: true,
          bottom: TabBar(
            //labelColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.person,
                ),
                text: 'Mis datos',
              ),
              Tab(icon: Icon(Icons.settings), text: 'Configuración'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            children: [
              Container(
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
                                                AuthSignPassword.changePassword(
                                                    context);
                                              },
                                              child: Text("Cambiar contraseña",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.blue)))))
                                  : Container(),
                            ]))
                      : Container()),
              SettingsList(
                platform: DevicePlatform.android,
                sections: [
                  SettingsSection(
                    title: Text('Biometricos'),
                    tiles: [
                      SettingsTile.switchTile(
                        initialValue: false,
                        onToggle: (_) {},
                        title: Text('Firma'),
                        leading: Icon(Icons.draw),
                      ),
                      SettingsTile.switchTile(
                        enabled: false,
                        initialValue: false,
                        onToggle: (value) {
                          setState(() {
                            useNotificationDotOnAppIcon = value;
                          });
                        },
                        title: Text('Reconocimiento facial'),
                        leading: Icon(Icons.face_outlined),
                        description: Text('No disponible en el dispositivo'),
                      ),
                      SettingsTile.switchTile(
                        initialValue: true,
                        leading: Icon(Icons.fingerprint),
                        onToggle: (_) {},
                        title: Text('Huella'),
                      ),
                      SettingsTile.switchTile(
                        initialValue: true,
                        leading: Icon(Icons.record_voice_over),
                        onToggle: (_) {},
                        title: Text('Reconocimiento de voz'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
