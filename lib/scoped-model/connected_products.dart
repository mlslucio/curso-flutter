import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../models/user.dart';

class ConnectedProducts extends Model{
  List<Product> products = [];
   User authenticatedUser;

    void addProduct(Product product) {

      product = Product(title: product.title, description: product.description, price: product.price,
      image:product.image, isFavorite: product.isFavorite, userEmail: authenticatedUser.email,
      userId: authenticatedUser.id);

      products.add(product);
  }
}