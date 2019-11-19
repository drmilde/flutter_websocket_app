import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  var channel = null;
  //String servername = "medsrv.informatik.hs-fulda.de:9876";
  String servername = "10.0.2.2:9876";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Websocket Test"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            sendContainer(),
            SizedBox(
              height: 20,
            ),
            closeContainer(),
            connectContainer(),
            anzeige(),
          ],
        ),
      ),
    );
  }

  Widget anzeige() {
    if (channel != null) {
      return StreamBuilder(
        stream: channel.stream,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
          );
        },
      );
    } else {
      return Text("messages pending");
    }
  }

  Container connectContainer() {
    return Container(
      child: RaisedButton(
        onPressed: () {
          if (channel == null) {
            //channel = IOWebSocketChannel.connect('ws://10.0.2.2:8080/ws');
            channel = IOWebSocketChannel.connect('ws://${servername}/ws');
            print("connected");
            print(channel);
            setState(() {
              print("widget update");
            });
          }
        },
        child: Text(
          "connect",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Container closeContainer() {
    return Container(
      child: RaisedButton(
        onPressed: () {
          if (channel != null) {
            channel.sink.close(status.goingAway);
            channel = null;
          }
        },
        child: Text(
          "disconnect",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Container sendContainer() {
    return Container(
      child: RaisedButton(
        onPressed: () {
          if (channel != null) {
            var message = "Hello from Flutter";
            print(message);
            channel.sink.add(message);
          }
        },
        child: Text(
          "send message",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
