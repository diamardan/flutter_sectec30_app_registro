import 'package:cetis32_app_registro/src/screens/initial_screen.dart';
import 'package:cetis32_app_registro/src/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var user = _auth.currentUser;
    if (user != null) {
      return HomeScreen();
    } else {
      return InitialScreen();
    }
  }
}
