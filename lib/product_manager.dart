import 'package:flutter/material.dart';
import './products.dart';
import 'package:scoped_model/scoped_model.dart';
import 'scoped-model/main.dart';

class ProductManager extends StatelessWidget {
  ProductManager();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Column(children: [Expanded(child: Products())]);
    });
  }
}
