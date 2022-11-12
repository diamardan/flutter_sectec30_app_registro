import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:conalep_izt3_app_registro/src/models/user_model.dart';
import 'package:conalep_izt3_app_registro/src/provider/user_provider.dart';
import 'package:conalep_izt3_app_registro/ui/res/colors.dart';
import 'package:conalep_izt3_app_registro/ui/screens/credential/render_crendetial_screen.dart';
import 'package:conalep_izt3_app_registro/src/utils/imageUtil.dart';
import 'package:conalep_izt3_app_registro/src/utils/widget_to_image.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for date format
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:barcode_widget/barcode_widget.dart';

class DigitalCredentialScreen extends StatefulWidget {
  DigitalCredentialScreen({Key key}) : super(key: key);

  @override
  State<DigitalCredentialScreen> createState() =>
      _DigitalCredentialScreenState();
}

class _DigitalCredentialScreenState extends State<DigitalCredentialScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
