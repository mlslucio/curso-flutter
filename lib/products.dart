import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'scoped-model/main.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                Card(
                  child: Image.asset(model.products[index].image),
                ),
                Text(model.products[index].title),
                Text(model.products[index].price.toString()),
                Text(model.products[index].userEmail),
                FlatButton(
                  child: Icon(Icons.info),
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '/product/' + index.toString());
                  },
                ),
                ScopedModelDescendant<MainModel>(
                    builder: (BuildContext context, Widget child,
                            MainModel model) =>
                        FlatButton(
                          child: Icon(model.products[index].isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border),
                          onPressed: () {
                            model.toggleProductFavoriteStatus(index);
                          },
                        ))
              ],
            );
          },
          itemCount: model.displayProducts.length,
        );
      },
    );
  }
}
