import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GridModel());
  }
}

// ignore: use_key_in_widget_constructors
class GridModel extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _GridModelState createState() => _GridModelState();
}

class _GridModelState extends State<GridModel> {
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    f();
  }

  Future<void> f() async {
    final res = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    final json = jsonDecode(res.body);
    setState(() {
      users = json['data'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleTextStyle: const TextStyle(color: Colors.white),
        title: const Text('GRID MODEL'),
        backgroundColor: Colors.blueAccent,
      ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {   
            // ignore: avoid_unnecessary_containers
            return Container(
              child: Column(
                children: [
                 const Padding(padding: EdgeInsets.only(top: 10.0)),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(users[index]['avatar']),
                  ),
                  Text(
                    users[index]['first_name'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(users[index]['email']),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
