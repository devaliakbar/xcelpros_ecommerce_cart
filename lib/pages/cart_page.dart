import 'package:ecommerce/models/cart_item.dart';
import 'package:ecommerce/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  static const String routeName = '/cart_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Consumer<CartProvider>(
          builder: (context, cart, child) {
            return cart.cartItems.length == 0
                ? Center(
                    child: Text(
                      "Cart is empty",
                    ),
                  )
                : ListView.separated(
                    itemCount: cart.cartItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildCartTile(
                          context: context,
                          cartItem: cart.cartItems[index],
                          index: index);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                  );
          },
        ),
      ),
    );
  }

  Widget _buildCartTile(
      {@required BuildContext context,
      @required CartItem cartItem,
      @required int index}) {
    return ListTile(
      dense: true,
      title: Text(cartItem.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FlatButton(
            key: Key("${index}_decrement_btn"),
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false).addToCart(
                  newCartItem: cartItem, opCode: CartOperation.decrement);
            },
            child: Text("-"),
          ),
          Text(
            "${cartItem.quantity}",
            key: Key("${index}_qty"),
          ),
          FlatButton(
            key: Key("${index}_increment_btn"),
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false).addToCart(
                  newCartItem: cartItem, opCode: CartOperation.increment);
            },
            child: Text("+"),
          )
        ],
      ),
    );
  }
}
