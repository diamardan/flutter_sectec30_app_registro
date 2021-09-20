// To parse this JSON data, do
//
//     final employee = employeeFromJson(jsonString);

import 'dart:convert';

Employee employeeFromJson(String str) => Employee.fromJson(json.decode(str));

String employeeToJson(Employee data) => json.encode(data.toJson());

class Employee {
  String id;
  String uid;
  String idBio;
  String apellidos;
  String nombre;
  String curp;
  String nss;
  String empresa;
  String puesto;
  String sangre;
  String direccion;
  String estado;
  String municipio;
  String otraEnfermedad;
  String emergencia;
  String impresa;
  String qr;
  String foto;
  String rol;
  String alergias;
  String especifiqueAlergia;
  String enfermedadesCronodegenerativas;
  String estatus;

  Employee(
      {this.id,
      this.uid,
      this.idBio,
      this.apellidos,
      this.nombre,
      this.curp,
      this.nss,
      this.empresa,
      this.puesto,
      this.sangre,
      this.direccion,
      this.emergencia,
      this.impresa,
      this.qr,
      this.foto,
      this.rol,
      this.alergias,
      this.estado,
      this.municipio,
      this.otraEnfermedad,
      this.especifiqueAlergia,
      this.enfermedadesCronodegenerativas,
      this.estatus});

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        uid: json["uid"],
        idBio: json["id_bio"],
        apellidos: json["apellidos"],
        nombre: json["nombre"],
        curp: json["curp"],
        nss: json["nss"],
        empresa: json["empresa"],
        puesto: json["puesto"],
        sangre: json["sangre"],
        direccion: json["direccion"],
        emergencia: json["emergencia"],
        impresa: json["impresa"],
        qr: json["qr"],
        foto: json["foto"],
        rol: json["rol"],
        alergias: json["alergias"],
        estado: json["estado"],
        municipio: json["municipio"],
        otraEnfermedad: json["otra_enfermedad"],
        especifiqueAlergia: json["especifique_alergia"],
        enfermedadesCronodegenerativas: json["enfermedades_cronodegenerativas"],
        estatus: json["estatus"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "id_bio": idBio,
        "apellidos": apellidos,
        "nombre": nombre,
        "curp": curp,
        "nss": nss,
        "empresa": empresa,
        "puesto": puesto,
        "sangre": sangre,
        "direccion": direccion,
        "emergencia": emergencia,
        "impresa": impresa,
        "qr": qr,
        "foto": foto,
        "rol": rol,
        "alergias": alergias,
        "estado": estado,
        "municipio": municipio,
        "otra_enfermedad": otraEnfermedad,
        "especifique_alergia": especifiqueAlergia,
        "enfermedades_cronodegenerativas": enfermedadesCronodegenerativas,
        "estatus": estatus
      };
}
