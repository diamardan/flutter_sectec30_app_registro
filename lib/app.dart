import 'package:cetis32_app_registro/ui/res/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cetis32_app_registro/src/provider/supscritions_provider.dart';
import 'package:cetis32_app_registro/src/provider/user_provider.dart';
import 'package:cetis32_app_registro/src/routes/routes.dart';
import 'package:cetis32_app_registro/ui/screens/login/wrapper_auth.dart';
import 'package:cetis32_app_registro/src/data/AuthenticationService.dart';
//import 'package:cetis32_app_registro/src/bloc/deep_link_bloc.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  // DeepLinkBloc _bloc = DeepLinkBloc();
  final ThemeData theme = ThemeData();
  @override
  Widget build(BuildContext context) {
/*DeepLinkBloc _bloc = DeepLinkBloc();
    return Provider<DeepLinkBloc>(
                create: (context) => _bloc,
                dispose: (context, bloc) => bloc.dispose(),
                child:*/

    return MultiProvider(
        providers: [
          Provider(
            create: (context) => SubscriptionsProvider(),
          ),
          ChangeNotifierProvider(create: (context) => UserProvider()),
          StreamProvider<User>(
            create: (_) => AuthenticationService().userState,
            initialData: null,
            //  updateShouldNotify: (u1, u2) => true,
          ),
        ],
        child: MaterialApp(
            title: 'CETIS 32 APP REGISTRO',
            debugShowCheckedModeBanner: false,
            routes: getApplicationRoutes(context),
            theme: ThemeData(
                primaryColor: AppColors.primary,
                appBarTheme: AppBarTheme(backgroundColor: AppColors.primary),
                scaffoldBackgroundColor: AppColors.background),
            /* initialRoute: 'wrapper', */
            home: Wrapper()));
  }
}
