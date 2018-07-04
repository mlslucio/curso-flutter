import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('EasyList'),
            ),
            body: Column(children: [
              Card(
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/food.jpg'),
                    Text('Food Paradise'),
                  ],
                ),
              ),
            ])));
  }
}
