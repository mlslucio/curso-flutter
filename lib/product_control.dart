import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget {
  final Function _addProduct;

  ProductControl(this._addProduct);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Add Product'),
      onPressed: () {
        this._addProduct({'title': 'Chocolate', 'image': 'assets/food.jpg'});
      },
    );
  }
}
