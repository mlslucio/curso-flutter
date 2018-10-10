import 'package:flutter/material.dart';
import '../screens/product_edit.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-model/main.dart';
import '../models/product.dart';

class ProductListScreen extends StatelessWidget {
  final List<Product> products;
  final Function updateProduct;

  ProductListScreen(this.products, this.updateProduct);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Image.asset(
              model.allProducts[index].image,
              width: 35.0,
            ),
            title: Text(model.allProducts[index].title),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return ProductEditScreen(
                    product: model.allProducts[index],
                    updateProduct: model.updateProduct,
                    index: index,
                  );
                }));
              },
            ),
          );
        },
        itemCount: model.allProducts.length,
      );
    });
  }
}
