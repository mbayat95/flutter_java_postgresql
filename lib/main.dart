import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _response = '';

  Future<void> _sendGetRequest() async {
    var response = await http.get(Uri.parse('http://localhost:9000/get'));
    setState(() {
      _response = response.body;
    });
  }

  Future<void> _sendPostRequest() async {
  var response = await http.post(
    Uri.parse('http://localhost:9000/post'),
    headers: {"Content-Type": "application/json"},
    body: json.encode({'content': _controller.text}),
  );
  setState(() {
    _response = response.body;
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Web App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter your message',
              ),
            ),
            ElevatedButton(
              onPressed: _sendGetRequest,
              child: Text('Send GET Request'),
            ),
            ElevatedButton(
              onPressed: _sendPostRequest,
              child: Text('Send POST Request'),
            ),
            Text(_response),
          ],
        ),
      ),
    );
  }
}
