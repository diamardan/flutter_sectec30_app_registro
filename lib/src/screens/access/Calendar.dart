import 'dart:collection';

import 'package:cetis32_app_registro/src/models/acceses_model.dart';
import 'package:cetis32_app_registro/src/models/user_model.dart';
import 'package:cetis32_app_registro/src/services/AccessService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key key, this.reg}) : super(key: key);
  final Registration reg;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  AccessService accesService = AccessService();
  Registration r;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  var events;

  @override
  void initState() {
    events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    r = widget.reg;
    print(r.toString());
    _getAccess(r.idbio.toString());
    super.initState();
  }

  _getAccess(String idBio) async {
    try {
      var result = await accesService.getAllById(idBio);

      createMap(result);
    } catch (error) {
      print('estoy en catch');
      print(error);
    }
    return;
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  createMap(List<Access> access) {
    access.forEach((a) {
      if (events[a.date] == null)
        events[a.date] = [a];
      else
        events[a.date].add(a);
    });
    print(events);
  }

  List<Access> _getAccessForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'es-ES',
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _focusedDay,
      calendarFormat: CalendarFormat.month,
      calendarStyle: CalendarStyle(
          defaultTextStyle:
              TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04)),
      headerStyle: HeaderStyle(
          titleCentered: true,
          titleTextFormatter: (date, locale) =>
              DateFormat.yMMM(locale).format(date).toString().toUpperCase(),
          formatButtonVisible: false,
          titleTextStyle:
              TextStyle(fontSize: MediaQuery.of(context).size.width * 0.07)),
      selectedDayPredicate: (day) {
        // Use `selectedDayPredicate` to determine which day is currently selected.
        // If this returns true, then `day` will be marked as selected.

        // Using `isSameDay` is recommended to disregard
        // the time-part of compared DateTime objects.
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          // Call `setState()` when updating the selected day
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        }
      },
      eventLoader: _getAccessForDay,
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          // Call `setState()` when updating calendar format
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        // No need to call `setState()` here
        _focusedDay = focusedDay;
      },
    );
  }
}
