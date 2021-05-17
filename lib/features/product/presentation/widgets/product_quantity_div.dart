import 'package:ecommerce/features/cart/domain/entities/cart_item.dart';
import 'package:ecommerce/features/cart/presentation/providers/cart_provider.dart';
import 'package:ecommerce/features/product/domain/entities/product.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/core/res/app_resources.dart';
import 'package:ecommerce/core/services/size_config.dart';
import 'package:ecommerce/core/widgets/normal_text.dart';
import 'package:ecommerce/core/widgets/tapped.dart';
import 'package:provider/provider.dart';

class ProductQuantityDiv extends StatelessWidget {
  final Product product;
  ProductQuantityDiv({@required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Tapped(
          onTap: () {
            Provider.of<CartProvider>(context, listen: false).addToCart(
                newCartItem:
                    CartItem(id: product.id, name: product.name, quantity: 1),
                opCode: CartOperation.decrement);
          },
          child: Container(
            width: SizeConfig.height(4),
            height: SizeConfig.height(3.5),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  SizeConfig.height(2),
                ),
                bottomLeft: Radius.circular(
                  SizeConfig.height(2),
                ),
              ),
            ),
            child: Center(
              child: NormalText(
                "-",
                size: FontSizes.fontSizeL,
              ),
            ),
          ),
        ),
        Container(
          width: SizeConfig.height(4),
          height: SizeConfig.height(3.5),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
          ),
          child: Center(
            child: Consumer<CartProvider>(builder: (context, cart, child) {
              int quantity = 0;

              for (CartItem cartItem in cart.cartItems) {
                if (cartItem.id == product.id) {
                  quantity = cartItem.quantity;
                  break;
                }
              }

              return NormalText(
                "$quantity",
                size: FontSizes.fontSizeS,
              );
            }),
          ),
        ),
        Tapped(
          onTap: () {
            Provider.of<CartProvider>(context, listen: false).addToCart(
                newCartItem:
                    CartItem(id: product.id, name: product.name, quantity: 1),
                opCode: CartOperation.increment);
          },
          child: Container(
            width: SizeConfig.height(4),
            height: SizeConfig.height(3.5),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(
                  SizeConfig.height(2),
                ),
                bottomRight: Radius.circular(
                  SizeConfig.height(2),
                ),
              ),
            ),
            child: Center(
              child: NormalText(
                "+",
                size: FontSizes.fontSizeL,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
