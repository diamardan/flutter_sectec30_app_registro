/*import 'package:flutter/material.dart';
import 'package:cetis32_app_registro/src/screens/deep_links/not_found_screen.dart';
import 'package:cetis32_app_registro/src/screens/initial_screen.dart';
import 'package:provider/provider.dart';
import 'package:cetis32_app_registro/src/bloc/deep_link_bloc.dart';
import 'package:cetis32_app_registro/src/screens/deep_links/attendance_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //DeepLinkBloc _bloc = Provider.of<DeepLinkBloc>(context);
    DeepLinkBloc _bloc = DeepLinkBloc();
    return StreamBuilder<String>(
      stream: _bloc.streamDL,
      builder: (context, snapshot) {
       /* return AttendanceLinkScreen(
            urlString: "https://attendance-lumen.web.app/oNVcJDbgcyWwG8txqRrN");*/
        
         if (!snapshot.hasData) {
          return InitialScreen();
        } else {
          /*bool toAttendance = snapshot.data.endsWith("/attendance");
          if (toAttendance)*/
            return AttendanceLinkScreen(urlString: snapshot.data);
          /*else
            return NotFoundScreen();*/
        }
      },
    );
  }
}
*/