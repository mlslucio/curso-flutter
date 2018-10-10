import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import './connected_products.dart';

class ProductsModel extends ConnectedProducts {
  
  bool _showFavorites = false;

  List<Product> get allProducts {
    return List.from(products);
  }

  List<Product> get displayProducts {
    if (_showFavorites) {
      return products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(products);
  }

  void deleteProduct(Product product) {
    products.remove(product);
  }

  void updateProduct(int index, Product product) {
  products[index] = product;
  }

  void toggleProductFavoriteStatus(int index) {
    final bool isCurrentlyFavorite = products[index].isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    Product product = Product(
        title: products[index].title,
        description: products[index].description,
        image: 'assets/food.jpg',
        price: products[index].price,
        isFavorite: newFavoriteStatus);

    this.updateProduct(index, product);
    products[index] = product;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }

  bool get favoriteStatus {
    return _showFavorites;
  }
}
