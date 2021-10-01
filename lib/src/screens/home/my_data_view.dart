import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:flutter/material.dart';

class MyDataView extends StatelessWidget {
  const MyDataView({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("MIS DATOS"),
        centerTitle: true,
        backgroundColor: AppColors.morenaLightColor,
      ),
      body: Stack(children: [
        Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/img/fondo.jpg')))),
      ]),
    ));
  }
}
