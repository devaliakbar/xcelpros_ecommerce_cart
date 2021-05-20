import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver flutterDriver;

  setUpAll(() async {
    flutterDriver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (flutterDriver != null) {
      flutterDriver.close();
    }
  });

  group("Product Page : ", () {
    test("Product Page Qty changing", () async {
      final buttonFinder = find.byValueKey('productBtnKey');
      await flutterDriver.tap(buttonFinder);

      final cartBtn = find.byValueKey('cartBtn');
      final cartText = find.byValueKey('cart_count');

      final product1Qty = find.byValueKey('2_qty');
      final product1Incr = find.byValueKey('2_increment_btn');
      final product1Descr = find.byValueKey('2_decrement_btn');

      final product2Qty = find.byValueKey('4_qty');
      final product2Incr = find.byValueKey('4_increment_btn');
      final product2Descr = find.byValueKey('4_decrement_btn');

      await flutterDriver.tap(product1Incr);
      expect(
        await flutterDriver.getText(product1Qty),
        '1',
      );

      await flutterDriver.tap(product1Incr);
      expect(
        await flutterDriver.getText(product1Qty),
        '2',
      );

      await flutterDriver.tap(product1Descr);
      await flutterDriver.tap(product1Incr);
      expect(
        await flutterDriver.getText(product1Qty),
        '2',
      );

      expect(
        await flutterDriver.getText(cartText),
        '1',
      );

      await flutterDriver.tap(product2Incr);
      expect(
        await flutterDriver.getText(cartText),
        '2',
      );
      await flutterDriver.tap(product2Incr);
      await flutterDriver.tap(product2Incr);
      await flutterDriver.tap(product2Descr);
      expect(
        await flutterDriver.getText(product2Qty),
        '2',
      );
      expect(
        await flutterDriver.getText(cartText),
        '2',
      );

      await flutterDriver.tap(cartBtn);

      final cartDecr = find.byValueKey('0_decrement_btn');

      await flutterDriver.tap(cartDecr);
      await flutterDriver.tap(cartDecr);

      await flutterDriver.tap(cartDecr);
      await flutterDriver.tap(cartDecr);

      await flutterDriver.tap(find.pageBack());

      expect(
        await flutterDriver.getText(product1Qty),
        '0',
      );

      expect(
        await flutterDriver.getText(product2Qty),
        '0',
      );
      expect(
        await flutterDriver.getText(cartText),
        '0',
      );

      await flutterDriver.tap(find.pageBack());
    });
  });

  group("Graphql Demo Page : ", () {
    test("Show Graphql Demo Data after loading", () async {
      final buttonFinder = find.byValueKey('graphqlDemoBtnKey');
      await flutterDriver.tap(buttonFinder);

      await flutterDriver.waitFor(find.byValueKey('loading'));

      await flutterDriver.waitFor(find.byValueKey('demoList'));

      await flutterDriver.tap(find.pageBack());
    });
  });

  group("Graphql Mutation Page : ", () {
    final emailTextField = find.byValueKey('emailKey');
    final passwordTextField = find.byValueKey('passwordKey');
    final loginBtn = find.byValueKey('loginBtnKey');

    test("Prevent Login if invalid username or password", () async {
      await flutterDriver.tap(find.byValueKey('graphqlMutationDemoBtnKey'));

      await flutterDriver.tap(loginBtn);
      await flutterDriver.waitFor(find.text('Please enter email'));

      await flutterDriver.tap(emailTextField);
      await flutterDriver.enterText('invalid@email.com');
      await flutterDriver.waitFor(find.text('invalid@email.com'));

      await flutterDriver.tap(loginBtn);
      await flutterDriver.waitFor(find.text('Please enter password'));

      await flutterDriver.tap(passwordTextField);
      await flutterDriver.enterText('passwordTextField');
      await flutterDriver.waitFor(find.text('passwordTextField'));

      await flutterDriver.tap(loginBtn);
      await flutterDriver.waitFor(find.text('Failed to login'));
    });

    test("Login if username or password is correct", () async {
      await flutterDriver.tap(emailTextField);
      await flutterDriver.enterText('ali.akbar@xcelpros.com');
      await flutterDriver.waitFor(find.text('ali.akbar@xcelpros.com'));

      await flutterDriver.tap(passwordTextField);
      await flutterDriver.enterText('Ali1234@');
      await flutterDriver.waitFor(find.text('Ali1234@'));

      await flutterDriver.tap(loginBtn);

      //After Login check wheather listview is showing
      await flutterDriver.waitFor(find.byValueKey('feedList'));
      await flutterDriver.tap(find.byValueKey("signOutBtnKey"));
    });
  });
}
