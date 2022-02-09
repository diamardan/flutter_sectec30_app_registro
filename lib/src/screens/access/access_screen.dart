import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/screens/access/Calendar.dart';
import 'package:flutter/material.dart';

class AccessesScreen extends StatefulWidget {
  final Registration register;

  AccessesScreen(this.register, {Key key}) : super(key: key);
  @override
  _AccessesScreenState createState() => _AccessesScreenState();
}

_getEventsForDay(DateTime day) {}

class _AccessesScreenState extends State<AccessesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Calendar(reg: widget.register),
      ),
    );
    //);
  }
}

/* Map<DateTime, List> convertJsonToDateMap(String jsonSource) {
    var json = jsonDecode(jsonSource);
    var jsonEvents = json['Events'];
    Map<DateTime, List<String>> events = {};
    for (var event in jsonEvents) {
      var date = parseDate(event['FECHA']);
      events.putIfAbsent(date, () => <String>[]);
      events[date].add(event['EVENTO']);
    }
    return events;
  }

  DateTime parseDate(String date) {
    var parts = date.split('-').map(int.tryParse).toList();
    return DateTime(parts[0], parts[1], parts[2]);
  } */

/*  List<Accesos> _getDataSource()  {
    final List<Accesos> meetings = <Accesos>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(
        Accesos('Confi', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }*/

/* class AccesosDataSource extends CalendarDataSource {
  AccesosDataSource(List<Accesos> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}
 */
/* class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
} */
