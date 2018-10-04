import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  ProductListScreen(this.products);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Image.asset(
            products[index]['image'],
            width: 35.0,
          ),
          title: Text(products[index]['title']),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
        );
      },
      itemCount: products.length,
    );
  }
}
