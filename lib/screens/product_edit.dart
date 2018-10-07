import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductEditScreen extends StatefulWidget {
  final Function updateProduct;
  final Product product;
  final int index;

  ProductEditScreen({this.product, this.updateProduct, this.index}) {
    print("produto stateless" + product.toString());
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductEditState();
  }
}

class _ProductEditState extends State<ProductEditScreen> {
  _ProductEditState1() {
    widget.product != null
        ? print("produto" + widget.product.toString())
        : print('null');
  }

  String title = '';
  String description = '';
  double price = 0.0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Product'),
        ),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
                margin: EdgeInsets.all(10.0),
                child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        TextFormField(
                            initialValue: widget.product == null
                                ? ''
                                : widget.product.title,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Title is required';
                              }
                            },
                            decoration: InputDecoration(labelText: 'Title'),
                            onSaved: (String value) {
                              this.title = value;
                            }),
                        TextFormField(
                          initialValue: widget.product == null
                              ? ''
                              : widget.product.description,
                          decoration: InputDecoration(labelText: 'Description'),
                          onSaved: (String value) {
                            this.description = value;
                          },
                          maxLines: 4,
                        ),
                        TextFormField(
                          initialValue: widget.product == null
                              ? ''
                              : widget.product.price.toString(),
                          decoration: InputDecoration(labelText: 'Price'),
                          keyboardType: TextInputType.number,
                          onSaved: (String value) {
                            this.price = double.parse(value);
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Colors.white,
                          child: Text('Save'),
                          onPressed: () {
                            _formKey.currentState.validate();
                            _formKey.currentState.save();

                            widget.updateProduct(
                                widget.index,
                                Product(
                                    title: title,
                                    description: description,
                                    image: 'assets/food.jpg',
                                    price: price));
                            Navigator.pushReplacementNamed(context, "/");
                          },
                        )
                      ],
                    )))));
  }
}
