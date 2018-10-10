import 'package:flutter/material.dart';

class Product {
  final String title, description, image;
  final String userId, userEmail;
  final double price;
  final bool isFavorite;

  Product(
      {@required this.title,
      @required this.description,
      @required this.price,
      @required this.image,
      @required this.userId,
      @required this.userEmail,
      this.isFavorite = false}) {}
}
