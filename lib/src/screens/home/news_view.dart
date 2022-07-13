import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/screens/home/popup_menu_widget.dart';
import 'package:cetis32_app_registro/src/screens/incoming_screen.dart';
//import 'package:cetis32_app_registro/src/screens/home/popup_menu_widget.dart';
import 'package:cetis32_app_registro/src/widgets/manu_button.dart';
import 'package:cetis32_app_registro/src/widgets/whatsapp_help_btn.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class NewsView extends StatelessWidget {
  const NewsView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Noticias y más"),
          centerTitle: true,
        ),
        body: Center(
            child: Card(
          child: Padding(
            child: Text(
              'Próximamente',
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
            padding: EdgeInsets.all(20),
          ),
        )));
  }
}
