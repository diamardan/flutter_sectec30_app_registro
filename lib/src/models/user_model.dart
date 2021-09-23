class AppUser {
  final String uid;

  AppUser({this.uid});
}

class Register {
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
  Register({
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
  });

  factory Register.fromJson(Map<String, dynamic> json) => Register(
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
      );

  Map<String, dynamic> toJson() => {
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
      };
}
