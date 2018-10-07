import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';

class ProductsModel extends Model {
  List<Product> _products = [];

  List<Product> get products {
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
}
