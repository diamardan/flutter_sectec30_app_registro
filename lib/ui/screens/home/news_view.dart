import "package:flutter/material.dart";

class NewsView extends StatelessWidget {
  const NewsView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Noticias y más"),
          centerTitle: true,
        ),
        body: Center(
            child: Card(
          child: Padding(
            child: Text(
              'Próximamente',
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
            padding: EdgeInsets.all(20),
          ),
        )));
  }
}
