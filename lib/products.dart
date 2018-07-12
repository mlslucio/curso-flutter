import 'package:flutter/material.dart';
import './screens/product_detail.dart';

class Products extends StatelessWidget {
  final List<Map> _products;
  final Function deleteProduct;

  Products(this._products, {this.deleteProduct});

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(_products[index]['image']),
          Text(_products[index]['title']),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Details'),
                onPressed: () => Navigator
                        .push<bool>(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ProductDetailScreen(
                                        _products[index]['title'],
                                        _products[index]['image'])))
                        .then((bool value) {
                      if (value) {
                        this.deleteProduct(index);
                        print("delete" + index.toString());
                      }
                    }),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return this._products.length > 0
        ? ListView.builder(
            itemBuilder: _buildProductItem,
            itemCount: _products.length,
          )
        : Center(
            child: Text('Empty'),
          );
  }
}
