import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  int quantity;

  CartItem({@required this.id, @required this.name, @required this.quantity});
}
