// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AccessDataSource extends CalendarDataSource {
  AccessDataSource(List<Access> source) {
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

class Access {
  int presenceId;
  DateTime date;
  DateTime dateUTC;
  String eventName;
  String email;
  String userName;
  String card;
  int sentSMS;
  int sentEmail;
  String id;
  String description;
  String device;

  Access({
    this.presenceId,
    this.date,
    this.dateUTC,
    this.eventName,
    this.email,
    this.userName,
    this.card,
    this.sentSMS,
    this.sentEmail,
    this.id,
    this.description,
    this.device,
  });

  factory Access.fromJson(Map<String, dynamic> json) {
    return Access(
      presenceId: json["IDASISTENCIA"],
      date: DateTime.parse(json["FECHA"]),
      //   dateUTC: DateTime.parse(json["FECHA_UTC"]),
      eventName: json["EVENTO"],
      email: json["CORREO"],
      userName: json["NOMBRE"],
      card: json["TARJETA"],
      sentSMS: json["ENVIONSMS"],
      sentEmail: json["ENVIOCORREO"],
      id: json["ID"],
      description: json["DESCRIPCIONUNO"],
      device: json["DISPOSITIVO"],
    );
  }

  Map<String, dynamic> toJson() => {
        "IDASISTENCIA": presenceId,
        "FECHA": date,
        "FECHA_UTC": dateUTC,
        "EVENTO": eventName,
        "CORREO": email,
        "NOMBRE": userName,
        "TARJETA": card,
        "ENVIONSMS": sentSMS,
        "ENVIOCORREO": sentEmail,
        "ID": id,
        "DESCRIPCIONUNO": description,
        "DISPOSITIVO": device,
      };
}
