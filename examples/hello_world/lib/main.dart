import 'package:flutter/material.dart';


void main() {

  runApp(HelloApp());
}

class HelloApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Container(color: Colors.red.shade500,
  child: Center(child: Text("Yo yo yo its ya boy", textDirection: TextDirection.ltr,)));
}