import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Keep Notes",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var responseData = "Dummy data";
  _makeRequest() async {
  final response =  await http.get(Uri.parse("http://192.168.32.168:3500/api/keepNotes"));
  setState(() {
    responseData = response.body;
  });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Keep Notes"),
      ),
      body:  Center(
        child: Text(responseData),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
         _makeRequest();
        },
        child: const Text("Make request!"),
      ),
    );
  }
}
