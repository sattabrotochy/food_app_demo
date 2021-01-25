import 'package:flutter/cupertino.dart';

class CartModel {
  final String image;
  final String name;
  final String price;
  final int quantiry;

  CartModel({
    @required this.image,
    @required this.name,
    @required this.price,
    @required this.quantiry,
  });
}
