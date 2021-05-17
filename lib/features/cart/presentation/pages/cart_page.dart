import 'package:ecommerce/core/res/app_resources.dart';
import 'package:ecommerce/core/services/size_config.dart';
import 'package:ecommerce/core/widgets/normal_text.dart';
import 'package:ecommerce/features/cart/presentation/providers/cart_provider.dart';
import 'package:ecommerce/features/cart/presentation/widgets/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  static const String routeName = '/cart_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: NormalText(
          "Cart",
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(
            SizeConfig.width(5),
          ),
          child: Consumer<CartProvider>(
            builder: (context, cart, child) {
              return cart.cartItems.length == 0
                  ? Center(
                      child: NormalText(
                        "Cart is empty",
                        size: FontSizes.fontSizeL,
                      ),
                    )
                  : ListView.separated(
                      itemCount: cart.cartItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CartTile(
                          cartItem: cart.cartItems[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
