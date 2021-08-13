import 'package:flutter/material.dart';
import 'package:cetis32_app_registro/src/utils/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cetis32_app_registro/src/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cetis32_app_registro/src/utils/form_util.dart';
import 'dart:io';

class WhatsappHelpBtn extends StatefulWidget {
  WhatsappHelpBtn({Key key, @required this.context, this.showLabel = true})
      : super(key: key);
  final BuildContext context;
  final bool showLabel;
  _WhatsappHelpBtnState createState() => _WhatsappHelpBtnState();
}

class _WhatsappHelpBtnState extends State<WhatsappHelpBtn> {
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 40,
      left: 90,
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
              enviarWhatsapp(context);
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

  enviarWhatsapp(BuildContext _context) async {
    var url =
        "whatsapp://send?phone=${AppConstants.whatsappNumber}&text=${AppConstants.whatsappText}, ";
    /* var url =
        "${AppConstants.whatsappNumber}?text=${AppConstants.whatsappText}"; */
    if (Platform.isIOS) {
      print('ios1');
      if (await canLaunch('whatsapp://')) {
        await launch(
            "whatsapp://wa.me/${AppConstants.whatsappNumber}?text=${AppConstants.whatsappText},",
            forceSafariVC: false);
      } else {
                    print('android');

        await launch(url, forceSafariVC: true);
      }
    } else {
      await canLaunch(url)
          ? launch(url) :
      await FormUtil.showAlert(_context, 'Aviso', 'WhatsApp no instalado');
    }
    /* await launch(
        "${AppConstants.whatsappNumber}?text=${AppConstants.whatsappText}"); */
  }
}
