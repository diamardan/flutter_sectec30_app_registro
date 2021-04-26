import 'package:flutter/material.dart';

class LastScreen extends StatelessWidget {
  const LastScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro finalizado"),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.popUntil(context, ModalRoute.withName('inicio'));
          },
        ),
      ),

      body: SafeArea(
        child: Stack(
          children: <Widget>[
            AppLogo(context),
            TextoFin(context),
            Center(
              child: Text("Su registro ha finalizado exitosamente"),
            )
          ],
        ),
      ),
    );
  }

  Widget AppLogo(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          height: size.height * .4 ,
          child: Image.asset('assets/img/logo.png'),
        )
      ],
    );
  }
  Widget TextoFin(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          height: size.height * .4 ,
          child: Image.asset('assets/img/logo.png'),
        )
      ],
    );
  }
}
