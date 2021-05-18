import 'package:ecommerce/models/cart_item.dart';
import 'package:ecommerce/pages/cart_page.dart';
import 'package:ecommerce/provider/cart_provider.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  static const String routeName = '/products_page';

  final List<Product> products = [];

  ProductsPage() {
    for (int i = 0; i < 15; i++) {
      products.add(Product(id: "${i + 1}", name: "Product ${i + 1}"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Products",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          _CartIcon(),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildProductTile(
              context: context,
              product: products[index],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
      ),
    );
  }

  Widget _buildProductTile(
      {@required BuildContext context, @required Product product}) {
    return ListTile(
      dense: true,
      title: Text(product.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FlatButton(
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false).addToCart(
                  newCartItem:
                      CartItem(id: product.id, name: product.name, quantity: 1),
                  opCode: CartOperation.decrement);
            },
            child: Text("-"),
          ),
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              int quantity = 0;

              for (CartItem cartItem in cart.cartItems) {
                if (cartItem.id == product.id) {
                  quantity = cartItem.quantity;
                  break;
                }
              }

              return Text(
                "$quantity",
              );
            },
          ),
          FlatButton(
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false).addToCart(
                  newCartItem:
                      CartItem(id: product.id, name: product.name, quantity: 1),
                  opCode: CartOperation.increment);
            },
            child: Text("+"),
          )
        ],
      ),
    );
  }
}

class _CartIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, CartPage.routeName);
        },
        child: Stack(
          children: [
            Center(
              child: Container(
                child: Icon(
                  Icons.shopping_bag,
                  color: Colors.white,
                ),
              ),
            ),
            Consumer<CartProvider>(
              builder: (context, cart, child) {
                return Text(
                  "${cart.cartItems.length}",
                  style: TextStyle(color: Colors.white),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
