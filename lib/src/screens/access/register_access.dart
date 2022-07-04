import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:cetis32_app_registro/src/widgets/manu_button.dart';
import 'package:cetis32_app_registro/src/widgets/whatsapp_help_btn.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class RegisterAccess extends StatefulWidget {
  RegisterAccess({Key key}) : super(key: key);

  @override
  State<RegisterAccess> createState() => _RegisterAccessState();
}

class _RegisterAccessState extends State<RegisterAccess> {
  List<String> biometrics = [
    "Firma",
    "Reconocimiento facial",
    "Huella",
    "Reconocimiento de voz",
    "Huella dactilar"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Acceso escolar"),
          //       style: TextStyle(fontStyle: FontStyle.italic),

          centerTitle: true,
          //toolbarHeight: 120,
        ),
        backgroundColor: Colors.white.withOpacity(0.97),
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: Column(
              children: [
                _horaAccesos(),
                SizedBox(
                  height: 5,
                ),
                _registerButtons()
              ],
            )));
  }

  Widget _horaAccesos() {
    return Card(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Column(
        children: [
          Text(
            "Martes",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          Text(
            "5 de julio de 2022",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 15,
          ),
          Row(children: [
            Expanded(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.circle, size: 18, color: Colors.black45),
                    Text(
                      "  ENTRADA",
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "7:00",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ],
            )),
            /*  Text(
              "-",
              style:
                  TextStyle(fontSize: 50, color: Colors.grey.withOpacity(0.5)),
            ),*/
            Expanded(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.circle, size: 18, color: Colors.black45),
                    Text(
                      "  SALIDA",
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "13:00",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ],
            ))
          ])
        ],
      ),
    ));
  }

  Widget _registerButtons() {
    return Expanded(
        child: Container(
            height: double.infinity,
            child: Card(
                elevation: 2,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        //mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_pin,
                            size: 100,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text("Registrar Acceso",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.morenaColor,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 30,
                          ),
                          _biometrics(),
                          SizedBox(
                            height: 20,
                          ),
                          _typeOfOperation(),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              height: 60,
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                  onPressed: () => {print("x")},
                                  icon: Icon(
                                    Icons.check,
                                    //  color: AppColors.morenaColor,
                                    size: 50,
                                  ),
                                  style: OutlinedButton.styleFrom(
                                      elevation: 1,
                                      alignment: Alignment.centerLeft,
                                      //  backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  label: Container(
                                      width: double.infinity,
                                      child: Center(
                                          child: Text(
                                        "REGISTRAR ",
                                        style: TextStyle(
                                            // color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ))))),
                        ])))));
  }

  Widget _biometrics() {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      items: biometrics.map((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
      //    hint: Text(hintText),
      onChanged: (_) => {},
      isDense: false,
      //value: ,
      /*validator: (value) =>
          value == null && validated ? 'Campo requerido' : null,*/
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        labelText: "Biométrico",
        labelStyle: TextStyle(
          fontSize: 14,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.black45)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.black45)),
      ),

      /*decoration: InputDecoration(
          labelText: "CÓD. TRABAJADOR",
          filled: true,
          fillColor: Color(0XFF48b8a9).withOpacity(0.2),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),*/
      elevation: 2,
      style: TextStyle(color: Colors.black87, fontSize: 16),
      //  isDense: true,
      iconSize: 30.0,
      iconEnabledColor: Colors.black87,
    );
  }

  Widget _typeOfOperation() {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      items: ["ENTRADA", "SALIDA"].map((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
      //    hint: Text(hintText),
      onChanged: (_) => {},
      isDense: false,
      //value: ,
      /*validator: (value) =>
          value == null && validated ? 'Campo requerido' : null,*/
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        labelText: "Entrada o Salida",
        labelStyle: TextStyle(
          fontSize: 14,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.black45)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.black45)),
      ),

      /*decoration: InputDecoration(
          labelText: "CÓD. TRABAJADOR",
          filled: true,
          fillColor: Color(0XFF48b8a9).withOpacity(0.2),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),*/
      elevation: 2,
      style: TextStyle(color: Colors.black87, fontSize: 16),
      //  isDense: true,
      iconSize: 30.0,
      iconEnabledColor: Colors.black87,
    );
  }
}
