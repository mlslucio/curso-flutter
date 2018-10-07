import 'package:flutter/material.dart';
import './products.dart';
import 'package:scoped_model/scoped_model.dart';
import 'scoped-model/product.dart';

class ProductManager extends StatelessWidget {
  ProductManager();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
        builder: (BuildContext context, Widget child, ProductsModel model) {
      return Column(children: [Expanded(child: Products())]);
    });
  }
}
