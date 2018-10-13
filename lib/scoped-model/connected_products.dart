import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/product.dart';
import '../models/user.dart';

class ConnectedProductsModel extends Model {
  List<Product> _products = [];
  User _authenticatedUser;
  bool _isLoading = false;

  String get userEmail {
    return _authenticatedUser.email;
  }

  String get userId {
    return _authenticatedUser.id;
  }

  void addProduct(Product product) {
    _isLoading = true;
    final Map<String, dynamic> productData = {
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'image':
          'https://image.shutterstock.com/image-photo/milk-chocolate-pieces-isolated-on-260nw-648010627.jpg',
      'isFavorite': product.isFavorite,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id
    };

    http
        .post('https://curso-flutter-udemy.firebaseio.com/products.json',
            body: json.encode(productData))
        .then((http.Response response) {
      _isLoading = false;
      notifyListeners();
    });
  }
}

class ProductsModel extends ConnectedProductsModel {
  bool _showFavorites = false;

  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get displayProducts {
    if (_showFavorites) {
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  void deleteProduct(Product product) {
    _products.remove(product);
  }

  void updateProduct(Product product) {
    _isLoading = true;

    Map<String, dynamic> data = {
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'image':
          'https://image.shutterstock.com/image-photo/milk-chocolate-pieces-isolated-on-260nw-648010627.jpg',
      'isFavorite': product.isFavorite,
      'userEmail': product.userEmail,
      'userId': product.userId
    };

    http
        .put(
            'https://curso-flutter-udemy.firebaseio.com/products/${product.id}.json',
            body: json.encode(data))
        .then((http.Response response) {
      _isLoading = false;
      notifyListeners();
    });
  }

  void toggleProductFavoriteStatus(int index) {
    final bool isCurrentlyFavorite = _products[index].isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    Product product = Product(
        title: _products[index].title,
        description: _products[index].description,
        image: 'assets/food.jpg',
        price: _products[index].price,
        isFavorite: newFavoriteStatus,
        userEmail: _authenticatedUser.email,
        userId: _authenticatedUser.id);

    this.updateProduct(product);
    _products[index] = product;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }

  void fetchProducts() {
    _isLoading = true;
    final List<Product> fetchedProducts = [];

    http
        .get('https://curso-flutter-udemy.firebaseio.com/products.json')
        .then((http.Response response) {
      final Map<String, dynamic> productListData = json.decode(response.body);
      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            image: productData['image'],
            price: productData['price'],
            isFavorite: productData['isFavorite'],
            userEmail: productData['userEmail'],
            userId: productData['userId']);

        fetchedProducts.add(product);
      });
      _products = fetchedProducts;
      _isLoading = false;

      notifyListeners();
    });
  }

  bool get favoriteStatus {
    return _showFavorites;
  }
}

class UserModel extends ConnectedProductsModel {
  void login(String email, String passwrod) {
    _authenticatedUser = User(id: '12121', email: email, password: passwrod);
  }
}

class UtilityModel extends ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
