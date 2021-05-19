import 'package:ecommerce/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget makeTestableWidget({@required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets(
      'Find 2 TextField , 1 Button, if email or password is empty show snackbar',
      (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget(child: LoginPage()));

    Finder emailTextField = find.byKey(Key("emailKey"));
    expect(emailTextField, findsOneWidget);

    Finder passwordTextField = find.byKey(Key("passwordKey"));
    expect(passwordTextField, findsOneWidget);

    Finder loginButton = find.byKey(Key("loginBtnKey"));
    expect(loginButton, findsOneWidget);

    await tester.tap(loginButton);

    await tester.pump();

    expect(find.text("Please enter email"), findsOneWidget);

    await tester.enterText(emailTextField, "test@email.com");

    await tester.tap(loginButton);

    await tester.pumpAndSettle(Duration(seconds: 3));

    expect(find.text("Please enter email"), findsNothing);

    expect(find.text("Please enter password"), findsOneWidget);

    await tester.enterText(passwordTextField, "password");

    await tester.tap(loginButton);

    await tester.pumpAndSettle(Duration(seconds: 3));

    expect(find.text("Please enter email"), findsNothing);

    expect(find.text("Please enter password"), findsNothing);
  });
}
