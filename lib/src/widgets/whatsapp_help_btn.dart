import 'package:flutter/material.dart';
import 'package:cetis32_app_registro/src/utils/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cetis32_app_registro/src/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsappHelpBtn extends StatelessWidget {
  const WhatsappHelpBtn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom:40,
      left:90,
      right: 90,
      child: Container(
        height: 38,
        width: size.width * .3,
        decoration: BoxDecoration(
            color: AppColors.whatsappColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: Colors.grey[200], style: BorderStyle.solid, width: 1)),
        child: MaterialButton(
          elevation: 20,
          onPressed: () {
            enviarWhatsapp();
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          height: 15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.whatsapp,
                color: Colors.white,
              ),
              Text(
                'Ayuda',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        )),
    );
  }

  enviarWhatsapp() async {
  await launch(
      "${AppConstants.whatsappNumber}?text=${AppConstants.whatsappText}");
}
}