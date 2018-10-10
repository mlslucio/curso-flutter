import 'package:scoped_model/scoped_model.dart';
import './product.dart';
import './user.dart';
import './connected_products.dart';

class MainModel extends Model with ConnectedProducts, ProductsModel, UserModel  {

}