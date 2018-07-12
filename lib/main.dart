import 'package:flutter/material.dart';
import './screens/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme:
            ThemeData(brightness: Brightness.light, primarySwatch: Colors.red),
        home: Scaffold(body: AuthScreen()));
  }
}
