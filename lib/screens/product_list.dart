import 'package:flutter/material.dart';
import '../screens/product_edit.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-model/product.dart';
import '../models/product.dart';

class ProductListScreen extends StatelessWidget {
  final List<Product> products;
  final Function updateProduct;

  ProductListScreen(this.products, this.updateProduct);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
        builder: (BuildContext context, Widget child, ProductsModel model) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Image.asset(
              model.products[index].image,
              width: 35.0,
            ),
            title: Text(model.products[index].title),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return ProductEditScreen(
                    product: model.products[index],
                    updateProduct: model.updateProduct,
                    index: index,
                  );
                }));
              },
            ),
          );
        },
        itemCount: model.products.length,
      );
    });
  }
}
