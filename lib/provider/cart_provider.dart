import 'package:ecommerce/models/cart_item.dart';
import 'package:flutter/material.dart';

enum CartOperation { increment, decrement }

class CartProvider extends ChangeNotifier {
  List<CartItem> cartItems = [];

  void addToCart(
      {@required CartItem newCartItem, @required CartOperation opCode}) {
    for (int i = 0; i < cartItems.length; i++) {
      CartItem cartItem = cartItems[i];

      if (cartItem.id == newCartItem.id) {
        if (opCode == CartOperation.decrement) {
          int qty = cartItem.quantity - 1;
          if (qty < 1) {
            cartItems.removeAt(i);
          } else {
            cartItem.quantity = qty;
          }
          notifyListeners();
          return;
        } else {
          if (cartItem.quantity < 100) {
            cartItem.quantity += 1;
          }
          notifyListeners();
          return;
        }
      }
    }

    if (opCode == CartOperation.increment) {
      cartItems.add(
        newCartItem,
      );
    }

    notifyListeners();
  }
}
