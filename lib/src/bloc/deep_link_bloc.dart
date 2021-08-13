import 'dart:async';

import 'package:flutter/services.dart';

abstract class Bloc {
  void dispose();
}

class DeepLinkBloc extends Bloc {
  //Event Channel creation
  static const eventStream =
      const EventChannel('poc.deeplink.flutter.dev/events');

  //Method channel creation
  static const platform =
      const MethodChannel('poc.deeplink.flutter.dev/channel');

  StreamController<String> _streamController = StreamController();

  Stream<String> get streamDL => _streamController.stream;

  Sink<String> get stateSink => _streamController.sink;

  //Adding the listener into contructor
  DeepLinkBloc() {
    //Checking application start by deep link
    //startUri().then(_onRedirected);
    //Checking broadcast stream, if deep link was clicked in opened appication
    eventStream.receiveBroadcastStream().listen((d) => _onRedirected(d));
  }

  _onRedirected(String uri) {
    // Here can be any uri analysis, checking tokens etc, if it’s necessary
    // Throw deep link URI into the BloC's stream
    stateSink.add(uri);
  }

  @override
  void dispose() {
    _streamController.close();
  }

  Future<String> startUri() async {
    try {
      return platform.invokeMethod('initialLink');
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }
}
