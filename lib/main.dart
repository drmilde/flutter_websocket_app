import 'package:flutter/material.dart';
import 'package:flutter_websocket_app/screens/example_screen.dart';
import 'package:flutter_websocket_app/screens/json_list_screen.dart';
import 'package:flutter_websocket_app/screens/message_screen.dart';
import 'package:web_socket_channel/io.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Websocket Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: MessageScreen(),
      home: JsonListScreen(),
    );
  }

  ExampleScreen startExample() {
    return ExampleScreen(
      title: "Websocket Example",
      //channel: IOWebSocketChannel.connect('ws://echo.websocket.org'),
      channel: IOWebSocketChannel.connect('ws://10.0.2.2:8080/ws'),
      //channel: IOWebSocketChannel.connect('ws://medsrv.informatik.hs-fulda.de:9876/ws'),
    );
  }
}

