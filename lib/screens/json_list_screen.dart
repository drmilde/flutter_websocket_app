import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class JsonListScreen extends StatefulWidget {
  @override
  _JsonListScreenState createState() => _JsonListScreenState();
}

class _JsonListScreenState extends State<JsonListScreen> {
  StreamController<Photo> controller;
  List<Photo> list = [];

  @override
  void initState() {
    super.initState();

    controller = StreamController.broadcast();

    controller.stream.listen((p) {
      setState(() {
        list.add(p);
      });
    });

    load(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StreamListView Example"),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (BuildContext context, index) => _makeElement(index),
        ),
      ),
    );
  }

  void load(StreamController sc) async {
    String url = "https://jsonplaceholder.typicode.com/photos";
    var client = new http.Client();

    var req = http.Request("get", Uri.parse(url));

    var streamedRes = await client.send(req);

    streamedRes.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .expand((e) => e)
        .map((map) => Photo.fromJsonMap(map))
        .pipe(controller);
  }

  @override
  void dispose() {
    super.dispose();
    controller?.close();
    controller = null;
  }

  Widget _makeElement(int index) {
    if (index >= list.length) {
      return null;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.amberAccent,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              print(list[index].toJsonString() + "\n");
              print(list.length);
            },
            child: Column(
              children: <Widget>[
                Text(list[index].title),
                Text(list[index].url),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Photo {
  final String title;
  final String url;

  Photo.fromJsonMap(Map map)
      : title = map['title'],
        url = map['url'];

  String toJsonString() {
    return json.encode({
      'title': title,
      'url': url,
    });
  }

  Map toMap() {
    return {
      'title': title,
      'url': url,
    };
  }
}
