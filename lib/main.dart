import 'package:ecommerce/pages/cart_page.dart';
import 'package:ecommerce/pages/feed_page.dart';
import 'package:ecommerce/pages/graphql_demo_page.dart';
import 'package:ecommerce/pages/home_page.dart';
import 'package:ecommerce/pages/login_page.dart';
import 'package:ecommerce/provider/cart_provider.dart';
import 'package:ecommerce/pages/products_page.dart';
import 'package:ecommerce/provider/feed_provider.dart';
import 'package:ecommerce/provider/graphql_demo_provider.dart';
import 'package:ecommerce/provider/login_provider.dart';
import 'package:ecommerce/provider/repositories/feed_repository.dart';
import 'package:ecommerce/provider/repositories/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CartProvider()),
      ChangeNotifierProvider(create: (context) => GraphQLDemoProvider()),
      ChangeNotifierProvider(
          create: (context) => FeedProvider(
                feedRepository: FeedRepository(),
              )),
      ChangeNotifierProvider(
        create: (context) => LoginProvider(
          loginRepository: LoginRepository(),
        ),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ecommerce',
        theme: ThemeData(
          splashColor: Colors.transparent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: {
          HomePage.routeName: (context) => HomePage(),
          ProductsPage.routeName: (context) => ProductsPage(),
          CartPage.routeName: (context) => CartPage(),
          GraphQlDemoPage.routeName: (context) => GraphQlDemoPage(),
          LoginPage.routeName: (context) => LoginPage(),
          FeedPage.routeName: (context) => FeedPage(),
        });
  }
}
