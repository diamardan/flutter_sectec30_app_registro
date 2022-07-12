import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/screens/home/popup_menu_widget.dart';
//import 'package:cetis32_app_registro/src/screens/home/popup_menu_widget.dart';
import 'package:cetis32_app_registro/src/widgets/manu_button.dart';
import 'package:cetis32_app_registro/src/widgets/whatsapp_help_btn.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class MenuView extends StatelessWidget {
  const MenuView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 170,
          title: _header(),
          centerTitle: true,
          actions: [popupMenu()],
        ),
        body: Stack(children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              color: Color(0XFFEFEFEF).withOpacity(0.7),
              child: _body(context)),
          //WhatsappHelpBtn(context: context)

          //
        ]));
  }

  _header() {
    var headerFont = GoogleFonts.montserrat(
        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14);
    return Column(children: [
      SizedBox(
        height: 20,
      ),
      Image.asset(
        'assets/img/logo-3.png',
        color: Colors.white, //AppColors.morenaColor,
        width: 70,
      ),
      SizedBox(
        height: 15,
      ),
      Text(
        "SISTEMA ESCOLAR INTELIGENTE",
        textAlign: TextAlign.center,
        style: headerFont,
      )
    ]);
  }

  Widget _body(BuildContext ctx) {
    return SingleChildScrollView(
      child: Center(
          child: Container(
              height: 600,
              //    width: MediaQuery.of(context).size.width * .9,
              decoration: BoxDecoration(
                //color: AppColors.morenaColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,

                // mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  SizedBox(
                    height: 20,
                  ),
                  MenuButton(
                    title: "Accesos",
                    subtitle: "Tus horas de entrada y salida al plantel.",
                    iconData: Icons.account_box_outlined,
                    route: "access",
                    incoming: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MenuButton(
                    title: "Asistencia",
                    subtitle: "Tus horas de entrada y salida a clase. ",
                    iconData: Icons.account_box_outlined,
                    route: "access",
                    incoming: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MenuButton(
                      title: "Credencial Inteligente",
                      subtitle: "Descarga tu credencial escolar.",
                      iconData: Icons.ad_units_outlined,
                      route: "credential"),
                  SizedBox(
                    height: 10,
                  ),
                  /*   MenuButton(
                      title: "Mis dispositivos",
                      subtitle: "Revisa y registra tu acceso al plantel",
                      iconData: Icons.phone_android_outlined,
                      route: "my-devices"),
                  SizedBox(
                    height: 10,
                  ),*/
                  MenuButton(
                    title: "Recompensas",
                    subtitle: "Premisos a la puntualidad y otros.",
                    iconData: Icons.star,
                    route: "access",
                    incoming: true,
                  ),
                ],
              ))),
    );
  }
}
