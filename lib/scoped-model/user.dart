import 'package:scoped_model/scoped_model.dart';
import './connected_products.dart';

import '../models/user.dart';

class UserModel extends ConnectedProducts{

  void login(String email, String passwrod){
    authenticatedUser = User(id:'12121', email:email, password: passwrod);
  }
}