import 'package:ecommerce/core/services/size_config.dart';
import 'package:ecommerce/core/widgets/normal_text.dart';
import 'package:ecommerce/features/cart/presentation/widgets/cart_icon.dart';
import 'package:ecommerce/features/product/presentation/providers/product_provider.dart';
import 'package:ecommerce/features/product/presentation/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    Provider.of<ProductProvider>(context, listen: false).getProduct();

    return Scaffold(
      appBar: AppBar(
        title: NormalText(
          "Products",
          color: Colors.white,
        ),
        actions: [
          CartIcon(),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(
            SizeConfig.width(5),
          ),
          child: Consumer<ProductProvider>(
              builder: (context, loginProvider, child) {
            ProductState productState = loginProvider.productState;
            if (productState is ProductErrorState) {
              return Center(
                child: NormalText(
                  productState.message,
                  color: Colors.red,
                ),
              );
            }

            if (productState is ProductLoadedState) {
              return ListView.separated(
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  return ProductTile(
                    product: productState.products[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
        ),
      ),
    );
  }
}
