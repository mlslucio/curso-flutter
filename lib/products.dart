import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'scoped-model/main.dart';
import './screens/product_edit.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Container(
                width: 80.0,
                child: Column(
                  children: <Widget>[
                    FadeInImage(
                      placeholder: AssetImage('assets/food.jpg'),
                      image: NetworkImage(model.allProducts[index].image),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(model.allProducts[index].title)
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(model.allProducts[index].price.toString())
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(model.allProducts[index].userEmail)
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ScopedModelDescendant<MainModel>(
                              builder: (BuildContext context, Widget child,
                                      MainModel model) =>
                                  FlatButton(
                                    child: Icon(
                                        model.allProducts[index].isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border),
                                    onPressed: () {
                                      model.toggleProductFavoriteStatus(index);
                                    },
                                  )),
                          FlatButton(
                            child: Icon(Icons.info),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/product/' + index.toString());
                            },
                          ),
                          FlatButton(
                            child: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return ProductEditScreen(
                                  product: model.allProducts[index],
                                  updateProduct: model.updateProduct,
                                  index: index,
                                );
                              }));
                            },
                          ),
                        ]),
                  ],
                ));
          },
          itemCount: model.displayProducts.length,
        );
      },
    );
  }
}
