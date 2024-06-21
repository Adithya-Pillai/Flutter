import 'package:flutter/material.dart';
import 'package:flutter_application_1/get_started.dart';

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homely',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GetStarted(), // Set the initial route to HomePage
    );
  }
}
