import 'package:ecommerce/models/feed.dart';
import 'package:ecommerce/pages/feed_page.dart';
import 'package:ecommerce/pages/home_page.dart';
import 'package:ecommerce/provider/feed_provider.dart';
import 'package:ecommerce/provider/repositories/feed_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockFeedRepository extends Mock implements FeedRepository {}

void main() {
  Widget makeTestableWidget(
      {@required Widget child,
      @required MockFeedRepository mockFeedRepository}) {
    return ChangeNotifierProvider(
      create: (context) => FeedProvider(
        feedRepository: mockFeedRepository,
      ),
      child: MaterialApp(
        home: child,
        routes: {
          HomePage.routeName: (context) => Scaffold(
                appBar: AppBar(
                  title: Text('Home'),
                ),
              ),
        },
      ),
    );
  }

  testWidgets('If user pressed SignOut, Navigate to Home page',
      (WidgetTester tester) async {
    final MockFeedRepository mockFeedRepository = MockFeedRepository();

    when(mockFeedRepository.fetchAllFeeds()).thenAnswer((_) async => []);

    await tester.pumpWidget(makeTestableWidget(
        child: FeedPage(), mockFeedRepository: mockFeedRepository));

    Finder signOutButton = find.byKey(Key("signOutBtnKey"));

    await tester.tap(signOutButton);

    //Waiting for loading to finish
    await tester.pumpAndSettle(Duration(seconds: 3));

    expect(find.text("Home"), findsOneWidget);
  });

  testWidgets('Show Loading before data loading', (WidgetTester tester) async {
    final MockFeedRepository mockFeedRepository = MockFeedRepository();

    when(mockFeedRepository.fetchAllFeeds()).thenAnswer((_) async => []);

    await tester.pumpWidget(makeTestableWidget(
        child: FeedPage(), mockFeedRepository: mockFeedRepository));

    expect(find.byKey(Key("loadingKey")), findsOneWidget);
  });

  testWidgets('Hide Loading after data loaded', (WidgetTester tester) async {
    final MockFeedRepository mockFeedRepository = MockFeedRepository();

    when(mockFeedRepository.fetchAllFeeds()).thenAnswer((_) async => []);

    await tester.pumpWidget(makeTestableWidget(
        child: FeedPage(), mockFeedRepository: mockFeedRepository));

    //Waiting for loading to finish
    await tester.pumpAndSettle(Duration(seconds: 3));

    expect(find.byKey(Key("loadingKey")), findsNothing);
  });

  testWidgets('Show Data After Loading', (WidgetTester tester) async {
    final MockFeedRepository mockFeedRepository = MockFeedRepository();

    when(mockFeedRepository.fetchAllFeeds()).thenAnswer((_) async => [
          Feed(id: "1", postTitle: "Test1", postDescription: "Test1 Desc"),
          Feed(id: "2", postTitle: "Test2", postDescription: "Test2 Desc"),
        ]);

    await tester.pumpWidget(makeTestableWidget(
        child: FeedPage(), mockFeedRepository: mockFeedRepository));

    //Waiting for loading to finish
    await tester.pumpAndSettle(Duration(seconds: 3));

    expect(find.text("Test1"), findsOneWidget);
    expect(find.text("Test2"), findsOneWidget);
  });
}
