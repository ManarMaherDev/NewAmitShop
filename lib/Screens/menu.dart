import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {


  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("Menu Screen"),
        ),
      ),


    );
  }
}
