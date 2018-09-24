import 'package:flutter/material.dart';


void main() {

  runApp(WidgetsApp(onGenerateRoute: (RouteSettings settings) {
    return PageRouteBuilder(pageBuilder: (x, i, t)=> HelloApp());
  }, color: Colors.white));
}

class HelloApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red.shade500,
        child: Center(
            child: Text("Yo yo yo its ya boy", textDirection: TextDirection.ltr)
    ));
  }
}