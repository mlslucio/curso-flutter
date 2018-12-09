import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:map_view/map_view.dart';

import './screens/home.dart';
import './screens/product_admin.dart';
import './screens/product_detail.dart';
import './screens/auth.dart';
import 'scoped-model/main.dart';
import 'api-config/keys.dart';

void main() {
  MapView.setApiKey("ewrew");
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
   final _model = MainModel();
   bool _isAuthenticated = false;
  @override
    void initState() {

      _model.autoAuth();
      _model.userSubject.listen((bool isAuthenticated){
        setState(() {
          _isAuthenticated = isAuthenticated;
        });
      });
      print(_isAuthenticated);
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    final _model = MainModel();

    print(_isAuthenticated.toString());
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
          theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.red,
              fontFamily: 'Oswald'),
              home: !_isAuthenticated ? AuthScreen() : HomeScreen(_model),
          routes: {
            '/home': (BuildContext context) => HomeScreen(_model),
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
