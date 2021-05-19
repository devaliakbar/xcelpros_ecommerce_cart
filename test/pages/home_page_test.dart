import 'package:ecommerce/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget makeTestableWidget({@required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('Find 3 Buttons , Products, Graphql Demo, Graphql Mutation',
      (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget(child: HomePage()));

    Finder productsButton = find.text("Products");
    expect(productsButton, findsOneWidget);

    Finder graphqlDemoButton = find.text("Graphql Demo");
    expect(graphqlDemoButton, findsOneWidget);

    Finder graphqlMutationButton = find.text("Graphql Mutation");
    expect(graphqlMutationButton, findsOneWidget);
  });
}
