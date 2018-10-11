import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/product.dart';
import '../models/user.dart';

class ConnectedProductsModel extends Model{
  List<Product> _products = [];
   User _authenticatedUser;
   bool isLoading = false;

    void addProduct(Product product) {
      isLoading = true;
      final Map<String, dynamic> productData ={
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'image': 'https://image.shutterstock.com/image-photo/milk-chocolate-pieces-isolated-on-260nw-648010627.jpg',
        'isFavorite': product.isFavorite,
        'userEmail': _authenticatedUser.email,
        'userId': _authenticatedUser.id
      };
     
      http.post('https://curso-flutter-udemy.firebaseio.com/products.json', body: json.encode(productData))
      .then((http.Response response){
        isLoading = false;
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);
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

  void updateProduct(int index, Product product) {
     product = Product(title: product.title, description: product.description, price: product.price,
      image:product.image, isFavorite: product.isFavorite, userEmail: _authenticatedUser.email,
      userId: _authenticatedUser.id);
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
        isFavorite: newFavoriteStatus,
        userEmail: _authenticatedUser.email,
        userId: _authenticatedUser.id);

    this.updateProduct(index, product);
    _products[index] = product;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }

  void fetchProducts(){
    this.isLoading = true;
    final List<Product> fetchedProducts = [];

    http.get('https://curso-flutter-udemy.firebaseio.com/products.json')
    .then((http.Response response){
      final Map<String, dynamic> productListData = json.decode(response.body);

      this.isLoading = false;

      productListData.forEach((String productId, dynamic productData){
        print("product");
        final Product product = Product(
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
       notifyListeners();
    });
  }

  bool get favoriteStatus {
    return _showFavorites;
  }
}

class UserModel extends ConnectedProductsModel{

  void login(String email, String passwrod){
    _authenticatedUser = User(id:'12121', email:email, password: passwrod);
  }
}
