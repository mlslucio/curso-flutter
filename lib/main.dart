import 'package:flutter/material.dart';
import './screens/home.dart';
import './screens/product_admin.dart';
import './screens/product_detail.dart';
import './screens/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  void _addProduct(Map<String, dynamic> product) {
    setState(() {
      _products.add(product);
      print(_products);
    });
  }

  void _deleteProduct(int index) {
    setState(() => _products.removeAt(index));
  }

  List<Map<String, dynamic>> _products = [];

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.red,
            fontFamily: 'Oswald'),
        routes: {
          '/': (BuildContext context) => HomeScreen(_products),
          '/auth': (BuildContext context) => AuthScreen(),
          '/admin': (BuildContext context) =>
              ProductAdminScreen(_addProduct, _deleteProduct, _products),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');

          if (pathElements[0] != '') {
            return null;
          }

          if (pathElements[1] == 'product') {
            final int index = int.parse(pathElements[2]);
            return MaterialPageRoute<bool>(
                builder: (BuildContext context) => ProductDetailScreen(
                    _products[index]['title'], _products[index]['image']));
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return new MaterialPageRoute(
              builder: (BuildContext context) =>
                  ProductAdminScreen(_addProduct, _deleteProduct, _products));
        });
  }
}
