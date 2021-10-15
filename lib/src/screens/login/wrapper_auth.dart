import 'package:cetis32_app_registro/src/provider/user_provider.dart';
import 'package:cetis32_app_registro/src/screens/initial_screen.dart';
import 'package:cetis32_app_registro/src/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var user = _auth.currentUser;
    if (user != null) {
      userProvider.inituSer();
      return HomeScreen();
    } else {
      return InitialScreen();
    }
  }
}
