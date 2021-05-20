import 'package:ecommerce/pages/graphql_demo_page.dart';
import 'package:ecommerce/pages/login_page.dart';
import 'package:ecommerce/pages/products_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RaisedButton(
                key: Key("productBtnKey"),
                onPressed: () {
                  Navigator.pushNamed(context, ProductsPage.routeName);
                },
                child: Text(
                  "Products",
                ),
              ),
              RaisedButton(
                key: Key("graphqlDemoBtnKey"),
                onPressed: () {
                  Navigator.pushNamed(context, GraphQlDemoPage.routeName);
                },
                child: Text("Graphql Demo"),
              ),
              RaisedButton(
                key: Key("graphqlMutationDemoBtnKey"),
                onPressed: () {
                  Navigator.pushNamed(context, LoginPage.routeName);
                },
                child: Text("Graphql Mutation"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
