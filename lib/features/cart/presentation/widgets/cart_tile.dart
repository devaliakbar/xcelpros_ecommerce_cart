import 'package:ecommerce/core/widgets/normal_text.dart';
import 'package:ecommerce/features/cart/domain/entities/cart_item.dart';
import 'package:ecommerce/features/cart/presentation/widgets/cart_quantity_div.dart';
import 'package:flutter/material.dart';

class CartTile extends StatelessWidget {
  final CartItem cartItem;
  CartTile({@required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: NormalText(cartItem.name),
      trailing: CartQuantityDiv(cartItem: cartItem),
    );
  }
}
