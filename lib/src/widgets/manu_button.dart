import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/utils/routes_arguments.dart';
import "package:flutter/material.dart";

class MenuButton extends StatelessWidget {
  final String route;
  final IconData iconData;
  final String title;
  final String subtitle;
  bool incoming;
  MenuButton(
      {this.title,
      this.iconData,
      this.route,
      this.subtitle,
      this.incoming = false});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130,
        child: ElevatedButton(
            onPressed: () {
              print(incoming);
              if (!incoming)
                Navigator.pushNamed(context, route);
              else
                Navigator.pushNamed(context, 'incoming',
                    arguments: IncomingScreenArguments(title));
            },
            style: OutlinedButton.styleFrom(
                elevation: 1,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7))),
            //  onSurface: Colors..withOpacity(0.0)),
            child: Row(children: [
              Icon(iconData,
                  size: 50, color: Color(0XFFAD1457).withOpacity(0.7)),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color:
                                  Colors.black.withOpacity(0.8).withBlue(20))),
                      Text(subtitle,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color:
                                  Colors.black.withOpacity(0.3).withBlue(20))),
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.black,
                      )))
            ])));
    ;
  }
}
