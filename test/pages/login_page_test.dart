import 'package:ecommerce/pages/feed_page.dart';
import 'package:ecommerce/pages/login_page.dart';
import 'package:ecommerce/provider/login_provider.dart';
import 'package:ecommerce/provider/repositories/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  Widget makeTestableWidget(
      {@required Widget child,
      @required MockLoginRepository mockLoginRepository}) {
    return ChangeNotifierProvider(
        create: (context) =>
            LoginProvider(loginRepository: mockLoginRepository),
        child: MaterialApp(
          home: child,
          routes: {
            FeedPage.routeName: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text('Feed'),
                  ),
                ),
          },
        ));
  }

  testWidgets('If user is logged in, Navigate to feed page',
      (WidgetTester tester) async {
    final MockLoginRepository mockLoginRepository = MockLoginRepository();

    when(mockLoginRepository.checkAlredyLogin()).thenAnswer((_) async => true);

    await tester.pumpWidget(makeTestableWidget(
        child: LoginPage(), mockLoginRepository: mockLoginRepository));

    //Waiting for loading to finish
    await tester.pumpAndSettle(Duration(seconds: 3));

    expect(find.text("Feed"), findsOneWidget);
  });

  testWidgets('If user is not logged in, find 2 TextField , 1 Button',
      (WidgetTester tester) async {
    final MockLoginRepository mockLoginRepository = MockLoginRepository();

    when(mockLoginRepository.checkAlredyLogin()).thenAnswer((_) async => false);

    await tester.pumpWidget(makeTestableWidget(
        child: LoginPage(), mockLoginRepository: mockLoginRepository));

    //Waiting for loading to finish
    await tester.pump(Duration(seconds: 1));

    Finder emailTextField = find.byKey(Key("emailKey"));
    expect(emailTextField, findsOneWidget);

    Finder passwordTextField = find.byKey(Key("passwordKey"));
    expect(passwordTextField, findsOneWidget);

    Finder loginButton = find.byKey(Key("loginBtnKey"));
    expect(loginButton, findsOneWidget);
  });

  testWidgets('If username or password empty, show snackbar with message',
      (WidgetTester tester) async {
    final MockLoginRepository mockLoginRepository = MockLoginRepository();

    when(mockLoginRepository.checkAlredyLogin()).thenAnswer((_) async => false);

    when(mockLoginRepository.login(
            email: "test@email.com", password: "password"))
        .thenAnswer((_) async => true);

    await tester.pumpWidget(makeTestableWidget(
        child: LoginPage(), mockLoginRepository: mockLoginRepository));

    await tester.pump(Duration(seconds: 1));

    Finder emailTextField = find.byKey(Key("emailKey"));
    Finder passwordTextField = find.byKey(Key("passwordKey"));
    Finder loginButton = find.byKey(Key("loginBtnKey"));

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

  testWidgets('If username or password is wrong, snow snackbar with message',
      (WidgetTester tester) async {
    final MockLoginRepository mockLoginRepository = MockLoginRepository();

    when(mockLoginRepository.checkAlredyLogin()).thenAnswer((_) async => false);

    when(mockLoginRepository.login(
            email: "wrong@email.com", password: "wrongPassword"))
        .thenAnswer((_) async => false);

    await tester.pumpWidget(makeTestableWidget(
        child: LoginPage(), mockLoginRepository: mockLoginRepository));

    await tester.pump(Duration(seconds: 1));

    Finder emailTextField = find.byKey(Key("emailKey"));
    Finder passwordTextField = find.byKey(Key("passwordKey"));
    Finder loginButton = find.byKey(Key("loginBtnKey"));

    await tester.enterText(emailTextField, "wrong@email.com");

    await tester.enterText(passwordTextField, "wrongPassword");

    await tester.tap(loginButton);

    verify(mockLoginRepository.login(
            email: "wrong@email.com", password: "wrongPassword"))
        .called(1);

    await tester.pumpAndSettle(Duration(seconds: 3));

    expect(find.text("Failed to login"), findsOneWidget);
  });

  testWidgets('If username and password is correct, Navigate to feed page',
      (WidgetTester tester) async {
    final MockLoginRepository mockLoginRepository = MockLoginRepository();

    when(mockLoginRepository.checkAlredyLogin()).thenAnswer((_) async => false);

    when(mockLoginRepository.login(
            email: "test@email.com", password: "password"))
        .thenAnswer((_) async => true);

    await tester.pumpWidget(makeTestableWidget(
        child: LoginPage(), mockLoginRepository: mockLoginRepository));

    await tester.pump(Duration(seconds: 1));

    Finder emailTextField = find.byKey(Key("emailKey"));
    Finder passwordTextField = find.byKey(Key("passwordKey"));
    Finder loginButton = find.byKey(Key("loginBtnKey"));

    await tester.enterText(emailTextField, "test@email.com");

    await tester.enterText(passwordTextField, "password");

    await tester.tap(loginButton);

    verify(mockLoginRepository.login(
            email: "test@email.com", password: "password"))
        .called(1);

    await tester.pumpAndSettle(Duration(seconds: 1));

    expect(find.text("Feed"), findsOneWidget);
  });
}
