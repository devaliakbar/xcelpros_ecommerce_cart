import 'package:ecommerce/config/graphql_config.dart';
import 'package:ecommerce/pages/cart_page.dart';
import 'package:ecommerce/pages/graphql_demo_page.dart';
import 'package:ecommerce/pages/home_page.dart';
import 'package:ecommerce/provider/cart_provider.dart';
import 'package:ecommerce/pages/products_page.dart';
import 'package:ecommerce/provider/graphql_demo_provider.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

void main() {
  GraphQLConfig graphQLConfig = GraphQLConfig();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CartProvider()),
      ChangeNotifierProvider(create: (context) => GraphQLDemoProvider()),
    ],
    child: GraphQLProvider(
      client: graphQLConfig.client,
      child: MyApp(),
    ),
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
        routes: {
          HomePage.routeName: (context) => HomePage(),
          ProductsPage.routeName: (context) => ProductsPage(),
          CartPage.routeName: (context) => CartPage(),
          GraphQlDemoPage.routeName: (context) => GraphQlDemoPage(),
        });
  }
}
