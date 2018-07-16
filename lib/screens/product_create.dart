import 'package:flutter/material.dart';

class ProductCreateScreen extends StatefulWidget {
  final Function addProduct;

  ProductCreateScreen(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductCreateState();
  }
}

class _ProductCreateState extends State<ProductCreateScreen> {
  String title = '';
  String description = '';
  double price = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            TextField(
                decoration: InputDecoration(labelText: 'Title'),
                onChanged: (String value) {
                  setState(() {
                    this.title = value;
                  });
                }),
            TextField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 4,
                onChanged: (String value) {
                  setState(() {
                    this.description = value;
                  });
                }),
            TextField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  setState(() {
                    this.price = double.parse(value);
                  });
                }),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              child: Text('Save'),
              onPressed: () {
                final Map<String, dynamic> product = {
                  'title': title,
                  'description': description,
                  'image': 'assets/food.jpg',
                  'price': price
                };
                widget.addProduct(product);
                Navigator.pushReplacementNamed(context, "/");
              },
            )
          ],
        ));
  }
}
