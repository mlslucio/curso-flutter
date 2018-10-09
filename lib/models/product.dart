import 'package:flutter/material.dart';

class Product {
  final String title, description, image;
  final double price;
  final bool isFavorite;

  Product(
      {@required this.title,
      @required this.description,
      @required this.price,
      @required this.image,
      this.isFavorite = false}) {}
}
