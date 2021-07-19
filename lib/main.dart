import 'package:flutter/material.dart';
import 'package:lumen_app_registro/src/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lumen_app_registro/src/wrapper.dart';
import 'package:lumen_app_registro/src/bloc/deep_link_bloc.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  
  Future.delayed(const Duration(seconds: 3), () {
    print("10 segundos");
    return runApp(MyApp());
  });
   
}

class MyApp extends StatelessWidget {
   DeepLinkBloc _bloc = DeepLinkBloc();
  @override
  Widget build(BuildContext context) {
/*DeepLinkBloc _bloc = DeepLinkBloc();
    return Provider<DeepLinkBloc>(
                create: (context) => _bloc,
                dispose: (context, bloc) => bloc.dispose(),
                child:*/
                return MaterialApp(
      title: 'LUMEN APP REGISTRO',
      debugShowCheckedModeBanner: false,
      routes: getApplicationRoutes(),
     // initialRoute: 'inicio',
      home: Wrapper() /* Scaffold(body: Center(child:Text("Hola")) )*/   );
    
    
  }
  
}
