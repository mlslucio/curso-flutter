import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './products.dart';

class ProductManager extends StatelessWidget {
  ProductManager();

  @override
  Widget build(BuildContext context) {
    return Column(children: [Expanded(child: Products())]);
  }
}
