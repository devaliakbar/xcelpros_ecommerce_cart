import 'package:ecommerce/core/widgets/normal_text.dart';
import 'package:ecommerce/features/product/domain/entities/product.dart';
import 'package:ecommerce/features/product/presentation/widgets/product_quantity_div.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  ProductTile({@required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: NormalText(product.name),
      trailing: ProductQuantityDiv(product: product),
    );
  }
}
