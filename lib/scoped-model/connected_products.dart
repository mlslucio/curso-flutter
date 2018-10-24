import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<bool> addProduct(Product product) async{
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
    try{
      final http.Response response = await http
          .post('https://curso-flutter-udemy.firebaseio.com/products.json?auth=${_authenticatedUser.token}',
              body: json.encode(productData));
        _isLoading = false;
        
        if(response.statusCode != 200 && response.statusCode != 201){
          return false;
        }

        notifyListeners();
        return true;
    }catch(error){
      print(error);
      _isLoading = false;
       notifyListeners();
      return false;
    }        
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
    _isLoading = true;
    http
        .delete(
            'https://curso-flutter-udemy.firebaseio.com/products/${product.id}.json?auth=${_authenticatedUser.token}')
        .then((http.Response response) {
      _isLoading = false;
      notifyListeners();
    });

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
            'https://curso-flutter-udemy.firebaseio.com/products/${product.id}.json?auth=${_authenticatedUser.token}',
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

  Future<Null> fetchProducts() {
    _isLoading = true;
    notifyListeners();
    final List<Product> fetchedProducts = [];

    return http
        .get('https://curso-flutter-udemy.firebaseio.com/products.json?auth=${_authenticatedUser.token}')
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

  get user{
    return _authenticatedUser;
  }
  
  Future<Map<String, dynamic>> login(String email, String password) async {
    Map<String, dynamic> authData = {'email':email, 'password':password, 'returnSecureToken':true};
    bool hasError = true;
    
    final http.Response response =  await http.post('https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyDHdSyo2JSiQAW-5QIhQZXqTlHEzYRiedQ',
    body:jsonEncode(authData), headers: {'Content-Type':'application/json'});

    final Map<String, dynamic> responseData = json.decode(response.body);

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('token', responseData['idToken']);
    prefs.setString('userId', responseData['localId']);
    prefs.setString('userEmail', responseData['localEmail']);

    if(responseData.containsKey('idToken')) {
      hasError = false;
    }
    return {'hasError': hasError};
  }

  Future<Map<String, dynamic>> signup(String email, String password) async{

    Map<String, dynamic> authData = {'email':email, 'password':password, 'returnSecureToken':true};
   
   final http.Response response = await http.post('https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyDHdSyo2JSiQAW-5QIhQZXqTlHEzYRiedQ',
    body: json.encode(authData), headers: {'Content-Type':'application/json'} );

    bool hasError = true;
    final Map<String, dynamic> responseData = json.decode(response.body);

    if(responseData.containsKey('idToken')) {
      hasError = false;
    }
    return {'hasError': hasError};
  }

  void autoAuth() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');

    if(token != null){
      String email = prefs.getString('token');
      String id = prefs.getString('userId');
      String token = prefs.getString('userEmail');

    _authenticatedUser = User(id: id, email: email, 
    token: token);
    notifyListeners();
    }
  }
}

class UtilityModel extends ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
