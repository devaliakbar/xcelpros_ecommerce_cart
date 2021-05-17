import 'package:ecommerce/features/cart/presentation/pages/cart_page.dart';
import 'package:ecommerce/features/product/presentation/pages/products_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ProductsPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return ProductsPage();
          },
        );

      case CartPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return CartPage();
          },
        );

      default:
        assert(false, 'Need to implement ${settings.name}');
        return null;
    }
  }
}
