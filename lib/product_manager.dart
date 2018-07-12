import 'package:flutter/material.dart';

import './products.dart';
import './product_control.dart';

class ProductManager extends StatefulWidget {
  final Map starterProduct;

  ProductManager({this.starterProduct});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  List<Map<String, dynamic>> _products = [];

  @override
  void initState() {
    if (widget.starterProduct != null)
      this._products.add(widget.starterProduct);

    super.initState();
  }

  void _addProduct(Map<String, dynamic> product) {
    setState(() {
      _products.add(product);
    });
  }

  void _deleteProduct(int index) {
    setState(() => _products.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.all(10.0),
        child: ProductControl(this._addProduct),
      ),
      Expanded(child: Products(_products, deleteProduct: this._deleteProduct))
    ]);
  }
}
