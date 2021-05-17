import 'package:ecommerce/core/res/app_resources.dart';
import 'package:ecommerce/core/services/size_config.dart';
import 'package:ecommerce/core/widgets/normal_text.dart';
import 'package:ecommerce/core/widgets/tapped.dart';
import 'package:ecommerce/features/cart/presentation/pages/cart_page.dart';
import 'package:ecommerce/features/cart/presentation/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: SizeConfig.width(3)),
      child: Tapped(
        onTap: () {
          Navigator.pushNamed(context, CartPage.routeName);
        },
        child: Stack(
          children: [
            Center(
              child: Container(
                child: Icon(
                  Icons.shopping_bag,
                  size: IconSizes.iconSizeM,
                  color: Colors.white,
                ),
              ),
            ),
            Consumer<CartProvider>(
              builder: (context, cart, child) {
                return NormalText(
                  "${cart.cartItems.length}",
                  color: Colors.white,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
