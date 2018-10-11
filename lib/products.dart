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
                Image(image: NetworkImage(model.allProducts[index].image),),
                Text(model.allProducts[index].title),
                Text(model.allProducts[index].price.toString()),
                Text(model.allProducts[index].userEmail),
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
                          child: Icon(model.allProducts[index].isFavorite
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
