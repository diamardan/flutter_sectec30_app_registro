import 'package:cetis32_app_registro/src/models/subscription_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String authMethod;

  User(this.id, this.authMethod);
}

class Registration {
  String id;
  String name;
  String surnames;
  String curp;
  String email;
  String cellphone;
  String registrationCode;
  String career;
  String grade;
  String group;
  String turn;
  String sex;
  String password;
  String fotoUsuarioDrive;
  Timestamp fecha_registro;
  int idbio;
  String qrDrive;
  String firmaDrive;
  Subscription subscribedTo;
  List fcmTokens;
  List devices;
  int devicesMax;

  Registration({
    this.id,
    this.name,
    this.surnames,
    this.curp,
    this.email,
    this.cellphone,
    this.registrationCode,
    this.career,
    this.grade,
    this.group,
    this.turn,
    this.sex,
    this.password,
    this.fotoUsuarioDrive,
    this.idbio,
    this.qrDrive,
    this.firmaDrive,
    this.subscribedTo,
    this.fecha_registro,
    this.devicesMax,
    this.fcmTokens,
    this.devices,
  });

  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
        id: json["id"],
        name: json["nombres"],
        surnames: json["apellidos"],
        curp: json["curp"],
        email: json["correo"],
        cellphone: json["celular"],
        registrationCode: json["matricula"],
        career: json["carrera"],
        grade: json["grado"],
        group: json["grupo"],
        turn: json["turno"],
        sex: json["sexo"],
        password: json["password"],
        fotoUsuarioDrive: json["foto_usuario_drive"],
        idbio: json["idbio"],
        qrDrive: json["qr_drive"],
        firmaDrive: json["firma_drive"],
        fecha_registro: json["fecha_registro"],
        subscribedTo: json["subscribed_to"] == null
            ? null
            : Subscription.fromJson(json["subscribed_to"]),
        fcmTokens: json["fcm_tokens"],
        devices: json["devices"],
        devicesMax: json["devices_max"] ?? 3,
      );

  @override
  String toString() {
    var strOutput = ''' id $id 
            name: $name  
            surnames $surnames   
            curp: $curp  
            email: $email  
            cellphone: $cellphone   
            registrationCode: $registrationCode  
            carrera: $career 
            grade: $grade  
            group: $group  
            turn: $turn   
            sex: $sex   
            password: $password  
            subscribedTo: $subscribedTo 
            devicesMax: $devicesMax 
            fcmTokens: ${fcmTokens.toString()},
            devices: ${devices.toString()},
            idbio: $idbio
    
              ''';
    return strOutput;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombres": name,
        "apellidos": surnames,
        "curp": curp,
        "correo": email,
        "celular": cellphone,
        "matricula": registrationCode,
        "carrera": career,
        "grado": grade,
        "grupo": group,
        "turno": turn,
        "sexo": sex,
        "password": password,
        "fotoDriveId": fotoUsuarioDrive,
        "idbio": idbio,
        "qrDrive": qrDrive,
        "firmaDrive": firmaDrive,
        "subscribed_to": subscribedTo,
        "fcm_tokens": fcmTokens,
        "devices": devices,
        "fecha_registro": fecha_registro,
        "devices_max": devicesMax,
      };

  void resetMessagingInfo() {
    fcmTokens = null;
    subscribedTo = null;
  }
}
