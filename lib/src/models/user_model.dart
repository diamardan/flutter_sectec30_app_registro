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
  int idbio;
  String qrDrive;
  String firmaDrive;

  /*Registration({
  String fotoUsuarioDrive;
  int idbio;
  String qrDrive;
  String firmaDrive;*/

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
  });

  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
      id: json["id"],
      name: json["nombres"],
      surnames: json["apellidos"],
      curp: json["curp"],
      email: json["correo"],
      cellphone: json["celular"],
      registrationCode: json["matricula"],
      grade: json["grado"],
      group: json["grupo"],
      turn: json["turno"],
      sex: json["sexo"],
      password: json["password"],
      fotoUsuarioDrive: json["foto_usuario_drive"],
      idbio: json["idbio"],
      qrDrive: json["qr_drive"],
      firmaDrive: json["firma_drive"]);

  @override
  String toString() {
    var strOutput =
        " id $id\n name: $name \n surnames $surnames \n  curp: $curp \n email: $email \n cellphone: $cellphone \n  registrationCode: $registrationCode \n grade: $grade \n group: $group \n turn: $turn \n  sex: $sex \n  password: $password ";
    return strOutput;
  }
  /*factory Register.clone(Register reg) => Register(
        id: reg.id,
        nombre: reg.nombre,
        apellidos: reg.apellidos,
        curp: reg.curp,
        correo: reg.correo,
        celular: reg.celular,
        matricula: reg.matricula,
        grado: reg.grado,
        grupo: reg.grupo,
        turno: reg.turno,
        sexo: reg.sexo,
      );
*/

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombres": name,
        "apellidos": surnames,
        "curp": curp,
        "correo": email,
        "celular": cellphone,
        "matricula": registrationCode,
        "grado": grade,
        "grupo": group,
        "turno": turn,
        "sexo": sex,
        "password": password,
        "fotoDriveId": fotoUsuarioDrive,
        "idbio": idbio,
        "qrDrive": qrDrive,
        "firmaDrive": firmaDrive
      };
}
