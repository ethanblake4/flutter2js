import 'package:flutter/material.dart';


void main() {

  runApp(HelloApp());
}

class HelloApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) => const Center(
      child: const Text('Hello flutter2js!', textDirection: TextDirection.ltr)
  );
}