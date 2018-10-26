import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-model/main.dart';

class ProductCreateScreen extends StatefulWidget {
  ProductCreateScreen();

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                      decoration: InputDecoration(labelText: 'Description'),
                      onSaved: (String value) {
                        this.description = value;
                      },
                      maxLines: 4,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Price'),
                      keyboardType: TextInputType.number,
                      onSaved: (String value) {
                        this.price = double.parse(value);
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ScopedModelDescendant<MainModel>(
                        builder: (context, child, model) => RaisedButton(
                              color: Theme.of(context).accentColor,
                              textColor: Colors.white,
                              child: Text('Save'),
                              onPressed: () {
                                _formKey.currentState.validate();
                                _formKey.currentState.save();
                                model.addProduct(Product(
                                    title: title,
                                    description: description,
                                    image: 'assets/food.jpg',
                                    price: price)).then((success){
                                      if(success){
                                         Navigator.pushReplacementNamed(context, "/");
                                      }else{
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context){
                                        return AlertDialog(
                                            title:Text('Algo deu errado'),
                                            content: Text('Tente novamente'),
                                            actions: <Widget>[
                                              FlatButton(child: Text('Ok'), onPressed: () {Navigator.of(context).pop();},)
                                            ],
                                            
                                          );});
                                      }
                                    });
                               
                              },
                            )),
                  ],
                ))));
  }
}
