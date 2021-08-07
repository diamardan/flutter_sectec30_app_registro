import 'package:flutter/material.dart';

class AppColors {
  static const logoheader = Color.fromRGBO(255, 0, 0, 1);
  static const white = Color.fromRGBO(255, 255, 255, 1);
  static const whatsappColor = Color.fromRGBO(37, 211, 102, 1);
  static const paymentInfoHeader = Color.fromRGBO(103, 218, 255, .5);
  static const primaryText = const Color.fromRGBO(255, 255, 255, 1);
  static const morenaColor = const Color.fromRGBO(94, 33, 41, 1);
/*   static const br = Border.radius(12); */

  static const text = Color.fromRGBO(0, 0, 0, 1);
  static const text2 = Color.fromRGBO(21, 21, 21, 1);

  /*  static const paymentDecoration = BoxDecoration(
                         borderRadius: 12,
                         boxShadow: [
                           BoxShadow(
                            color: Colors.black26,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(2.0,4.0)
                         )],
                         color: Colors.white,);
 */
}

class AppConstants {
   //backendUrl hace referencia ya sea a la url de producción o a la de desarrollo
  /* static const backendUrl =  "http://192.168.1.64:5000/api/v1/firebase";   */
  static const backendUrl = 'https://api.escuelas.infon.mx/api/v1/firebase';
  static const backendPublicUrl = 'https://api.escuelas.infon.mx/public';
  //static const backendUrl = 'https://api.escuelas.infon.mx/api/v1';
  static const whatsappNumber = 'https://wa.me/5215520779800';
  static const whatsappText = 'hola, necesito ayuda con la app';
  static const pdfPagoUrl =
      "https://api.escuelas.infon.mx/public/pdfs/LUMEN%20FORMATO%20PAGO.pdf";
  static const urlAttendance = "https://attendance-lumen.web.app/";
  static const urlAttendanceIdPosition = 33;
    //fsCollectionName almacena el nombre de la collection que hace referencia a la escuela sobre la que se va a trabajar
  static const fsCollectionName = "cetis32";
}
