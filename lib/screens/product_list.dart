import 'package:flutter/material.dart';
import '../screens/product_edit.dart';
import '../models/product.dart';

class ProductListScreen extends StatelessWidget {
  final List<Product> products;
  final Function updateProduct;

  ProductListScreen(this.products, this.updateProduct);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Image.asset(
            products[index].image,
            width: 35.0,
          ),
          title: Text(products[index].title),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return ProductEditScreen(
                  product: products[index],
                  updateProduct: updateProduct,
                  index: index,
                );
              }));
            },
          ),
        );
      },
      itemCount: products.length,
    );
  }
}
