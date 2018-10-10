import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';

class ProductsModel extends Model {
  List<Product> _products = [];
  bool _showFavorites = false;

  List<Product> get products {
    return List.from(_products);
  }

  List<Product> get displayProducts {
    if (_showFavorites) {
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  void addProduct(Product product) {
    _products.add(product);
  }

  void deleteProduct(Product product) {
    _products.remove(product);
  }

  void updateProduct(int index, Product product) {
    _products[index] = product;
  }

  void toggleProductFavoriteStatus(int index) {
    final bool isCurrentlyFavorite = _products[index].isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    Product product = Product(
        title: _products[index].title,
        description: _products[index].description,
        image: 'assets/food.jpg',
        price: _products[index].price,
        isFavorite: newFavoriteStatus);

    this.updateProduct(index, product);
    _products[index] = product;
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
