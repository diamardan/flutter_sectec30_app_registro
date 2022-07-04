import 'package:cetis32_app_registro/src/constants/constants.dart';
import "package:flutter/material.dart";

class MenuButton extends StatelessWidget {
  final String route;
  final IconData iconData;
  final String title;
  MenuButton({this.title, this.iconData, this.route});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, route);
            },
            style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            //  onSurface: Colors..withOpacity(0.0)),
            child: Row(children: [
              Icon(iconData, size: 50, color: AppColors.morenaColor),
              SizedBox(
                width: 10,
              ),
              Text(title,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.8).withBlue(20))),
            ])));
    ;
  }
}
