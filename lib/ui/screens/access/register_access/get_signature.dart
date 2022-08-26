// IMPORT PACKAGE
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class GetSignature {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.blue,
  );

  Widget _getCanvas() {
    return Signature(
      controller: _controller,
      width: 300,
      height: 300,
      backgroundColor: Colors.lightBlueAccent,
    );
  }

  Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            content: _getCanvas(),
            actionsAlignment: MainAxisAlignment.center,
            actions: [ElevatedButton(onPressed: () {}, child: Text("Enviar "))],
          );
        });
      },
    );
  }

  void _clearCanvas() {
    _controller.clear();
  }

  void _undo() {
    _controller.undo();
  }
}
