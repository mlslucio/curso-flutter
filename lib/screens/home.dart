import 'package:flutter/material.dart';
import '../product_manager.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-model/main.dart';

class HomeScreen extends StatefulWidget {
  final MainModel model;

  HomeScreen(this.model);

  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeScreen> {
  @override
  void initState() {
    widget.model.fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      return Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text('Choose'),
              ),
              ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Manage Products'),
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, '/admin'))
            ],
          ),
        ),
        appBar: AppBar(
          actions: <Widget>[
            ScopedModelDescendant<MainModel>(
                builder: (context, child, model) => FlatButton(
                      child: Icon(model.favoriteStatus
                          ? Icons.favorite
                          : Icons.favorite_border),
                      onPressed: () {
                        model.toggleDisplayMode();
                      },
                    )),
          ],
          title: Text('Easy List'),
        ),
        body: listarProdutos(),
      );
    });
  }

  Widget listarProdutos() {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      Widget content;

      if (!model.isLoading) {
        content = ProductManager();
      } else {
        content = Center(
          child: CircularProgressIndicator(),
        );
      }
      return RefreshIndicator(child: content, onRefresh: model.fetchProducts);
    });
  }
}
