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
    return Scaffold(
      appBar: AppBar(
          title: Text('Accesos'),
          centerTitle: true,
          backgroundColor: Colors.green,
          foregroundColor: Colors.black87),
      body: SafeArea(
        child: Calendar(),
      ),
    );
    //);
  }
}
