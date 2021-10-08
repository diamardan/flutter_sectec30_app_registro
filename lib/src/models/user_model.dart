class User {
  final String id;
  final String authMethod;

  User(this.id, this.authMethod);
}

class Register {
  String id;
  String nombre;
  String apellidos;
  String curp;
  String correo;
  String celular;
  String matricula;
  String carrera;
  String grado;
  String grupo;
  String turno;
  String sexo;
  String qr;
  String password;
  Register({
    this.id,
    this.nombre,
    this.apellidos,
    this.curp,
    this.correo,
    this.celular,
    this.matricula,
    this.carrera,
    this.grado,
    this.grupo,
    this.turno,
    this.sexo,
    this.password,
  });

  factory Register.fromJson(Map<String, dynamic> json) => Register(
      id: json["id"],
      nombre: json["nombres"],
      apellidos: json["apellidos"],
      curp: json["curp"],
      correo: json["correo"],
      celular: json["celular"],
      matricula: json["matricula"],
      grado: json["grado"],
      grupo: json["grupo"],
      turno: json["turno"],
      sexo: json["sexo"],
      password: json["password"]);

  factory Register.clone(Register reg) => Register(
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

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombres": nombre,
        "apellidos": apellidos,
        "curp": curp,
        "correo": correo,
        "celular": celular,
        "matricula": matricula,
        "grado": grado,
        "grupo": grupo,
        "turno": turno,
        "sexo": sexo,
        "password": password,
      };
}
