import 'package:flutter/material.dart';
import './screens/home.dart';
import './screens/product_admin.dart';
import './screens/product_detail.dart';
import './screens/auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'scoped-model/main.dart';

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
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: MainModel(),
      child: MaterialApp(
          theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.red,
              fontFamily: 'Oswald'),
              //home: AuthScreen(),
          routes: {
            '/': (BuildContext context) => HomeScreen(),
            '/auth': (BuildContext context) => AuthScreen(),
            '/admin': (BuildContext context) => ProductAdminScreen(),
          },
          onGenerateRoute: (RouteSettings settings) {
            final List<String> pathElements = settings.name.split('/');

            if (pathElements[0] != '') {
              return null;
            }

            if (pathElements[1] == 'product') {
              final int index = int.parse(pathElements[2]);
              return MaterialPageRoute<bool>(
                  builder: (BuildContext context) =>
                      ProductDetailScreen(index));
            }
            return null;
          },
          onUnknownRoute: (RouteSettings settings) {
            return new MaterialPageRoute(
                builder: (BuildContext context) => ProductAdminScreen());
          }),
    );
  }
}
