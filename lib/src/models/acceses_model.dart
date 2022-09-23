// ignore_for_file: non_constant_identifier_names

class Event {
  String biostarId;
  DateTime date;
  String userName;
  DateTime checkInTime;
  DateTime departureTime;
  String description;
  String type;

  Event({
    this.biostarId,
    this.date,
    this.userName,
    this.checkInTime,
    this.departureTime,
    this.description,
    this.type,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      biostarId: json["ID_BIOSTAR"],
      date: DateTime.parse(json["FECHA"]),
      userName: json["NOMBRE"],
      checkInTime:
          json["ENTRADA"] != null ? DateTime.parse(json["ENTRADA"]) : null,
      departureTime: json["SALIDA"] != null && json["SALIDA"] != ''
          ? DateTime.parse(json["SALIDA"])
          : null,
      description: json["DESCRIPCION"],
      type: json["TIPO"],
    );
  }
}

class Access {
  String type;
  DateTime time;

  Access({
    this.type,
    this.time,
  });
}
