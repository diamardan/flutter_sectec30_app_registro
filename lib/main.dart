import 'package:cetis32_app_registro/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:cetis32_app_registro/src/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cetis32_app_registro/src/screens/wrapper_screen.dart';
import 'package:cetis32_app_registro/src/bloc/deep_link_bloc.dart';
import 'package:provider/provider.dart';
import 'package:cetis32_app_registro/src/models/user_model.dart';

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
        title: 'CETIS 32 APP REGISTRO',
        debugShowCheckedModeBanner: false,
        routes: getApplicationRoutes(),
        theme: ThemeData(
            primaryColor: AppColors.morenaColor,
            scaffoldBackgroundColor: Color(0Xffffffff)),
        // initialRoute: 'inicio',
        home: Wrapper());
  }
}
