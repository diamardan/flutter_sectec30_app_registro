import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/screens/access/Calendar.dart';
import 'package:flutter/material.dart';

class AccessesScreen extends StatefulWidget {
  AccessesScreen({Key key}) : super(key: key);
  @override
  _AccessesScreenState createState() => _AccessesScreenState();
}

_getEventsForDay(DateTime day) {}

class _AccessesScreenState extends State<AccessesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Accesos'),
              centerTitle: true,
              //  backgroundColor: Colors.green,
              // foregroundColor: Colors.white,
              bottom: TabBar(
                //labelColor: Colors.white,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.clear_rounded,
                    ),
                    text: 'Torniquetes',
                  ),
                  Tab(icon: Icon(Icons.location_pin), text: 'Geolocalización'),
                ],
              ),
            ),
            body:
                SafeArea(child: TabBarView(children: [Calendar(), Calendar()])),
            floatingActionButton: Container(
              height: 70,
              child: FloatingActionButton.extended(
                  backgroundColor: AppColors.morenaColor,
                  onPressed: null,
                  /* () =>
                      Navigator.pushNamed(context, "register-access"),*/
                  icon: Icon(
                    Icons.check_box_rounded,
                    size: 35,
                  ),
                  label: Text("Registrar \nAcceso")),
            )));
    //);
  }
}
