import 'package:ecommerce/config/graphql_config.dart';
import 'package:ecommerce/helper/graphql_helper.dart';
import 'package:ecommerce/models/feed.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class FeedProvider extends ChangeNotifier {
  List<Feed> feeds;

  final GraphQLConfig _graphQLConfig = GraphQLConfig();
  GraphQLClient _graphQLClient;

  Future<void> fetchAllFeeds() async {
    _graphQLConfig.getPrivateClient().then((value) {
      _graphQLClient = value;
      _fetch();
    });
  }

  Future<void> _fetch() async {
    QueryResult result = await _graphQLClient.query(
      QueryOptions(
        document: gql(
          GraphQLQueryHelper.getFeedsQuery,
        ),
      ),
    );

    if (!result.hasException) {
      feeds = [];
      result.data['post_getHomePageFeed']['items'].forEach((element) {
        feeds.add(Feed.fromJson(element));
      });
    } else {
      print(result.exception.toString());
      // if (error == "TOKEN EXPIRE") {
      //   await _graphQLConfig.refreshToken();
      //   fetchAllFeeds();
      // }
    }

    notifyListeners();
  }
}
