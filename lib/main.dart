import 'package:flutter/material.dart';
import 'package:lumen_app_registro/src/routes/routes.dart';
 
void main() {
  Future.delayed(const Duration(seconds: 5), () {
    print("15 segundos");
    return runApp(MyApp());
  });
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LUMEN APP REGISTRO',
      debugShowCheckedModeBanner: false,
      routes: getApplicationRoutes(),
      initialRoute: 'inicio',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}