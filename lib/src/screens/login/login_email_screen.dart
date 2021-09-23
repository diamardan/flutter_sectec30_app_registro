import 'package:flutter/material.dart';
import 'package:cetis32_app_registro/src/constants/constants.dart';

class LoginMailScreen extends StatefulWidget {
  _LoginMailScreenState createState() => _LoginMailScreenState();
}

class _LoginMailScreenState extends State<LoginMailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.morenaLightColor,
              title: Text("INICIAR SESIÓN"),
            ),
            backgroundColor: Color(0Xfafafaff),
            body: Stack(
              children: [
                Center(
                    child: Container(
                  width: MediaQuery.of(context).size.width * .80,
                  //decoration: BoxDecoration(color: Color(0Xcdcdcdff)),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _formUserPassword(),
                        SizedBox(
                          height: 20,
                        ),
                      ]),
                ))
              ],
            )));
  }

  _formUserPassword() {
    return (Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        decoration: BoxDecoration(
            //color: Colors.grey.withOpacity(0.07),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            Image.asset('assets/img/logo-3.png',
                height: 210, fit: BoxFit.contain),
            SizedBox(height: 40),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'email',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("ENTRAR"),
              style: ElevatedButton.styleFrom(
                  primary: Colors.black54,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  textStyle:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Si no cuentas con contraseña, puedes solicitarla aquí"),
          ],
        )));
  }
}
