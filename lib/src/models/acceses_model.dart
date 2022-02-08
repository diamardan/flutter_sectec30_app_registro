// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AccesosDataSource extends CalendarDataSource {
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

class Accesos {
  Accesos(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
} 

/* class Accesos {
  int IDASISTENCIA;
  DateTime FECHA;
  DateTime FECHA_UTC;
  String EVENTO;
  String CORREO;
  String NOMBRE;
  String TARJETA;
  int ENVIONSMS;
  int ENVIOCORREO;
  String ID;
  String DESCRIPCIONUNO;
  String DISPOSITIVO;

  Accesos({
    this.IDASISTENCIA,
    this.FECHA,
    this.FECHA_UTC,
    this.EVENTO,
    this.CORREO,
    this.NOMBRE,
    this.TARJETA,
    this.ENVIONSMS,
    this.ENVIOCORREO,
    this.ID,
    this.DESCRIPCIONUNO,
    this.DISPOSITIVO,
  });

  factory Accesos.fromJson(Map<String, dynamic> json) {
    return Accesos(
      IDASISTENCIA: json["IDASISTENCIA"],
      FECHA: json["FECHA"].toDate(),
      FECHA_UTC: json["FECHA_UTC"].toDate(),
      EVENTO: json["EVENTO"],
      CORREO: json["CORREO"],
      NOMBRE: json["NOMBRE"],
      TARJETA: json["TARJETA"],
      ENVIONSMS: json["ENVIONSMS"],
      ENVIOCORREO: json["ENVIOCORREO"],
      ID: json["ID"],
      DESCRIPCIONUNO: json["DESCRIPCIONUNO"],
      DISPOSITIVO: json["DISPOSITIVO"],
    );
  }

  Map<String, dynamic> toJson() => {
        "IDASISTENCIA": IDASISTENCIA,
        "FECHA": FECHA,
        "FECHA_UTC": FECHA_UTC,
        "EVENTO": EVENTO,
        "CORREO": CORREO,
        "NOMBRE": NOMBRE,
        "TARJETA": TARJETA,
        "ENVIONSMS": ENVIONSMS,
        "ENVIOCORREO": ENVIOCORREO,
        "ID": ID,
        "DESCRIPCIONUNO": DESCRIPCIONUNO,
        "DISPOSITIVO": DISPOSITIVO,
      };
}
 */