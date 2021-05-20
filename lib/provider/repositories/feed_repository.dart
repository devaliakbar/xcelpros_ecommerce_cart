import 'package:ecommerce/config/graphql_config.dart';
import 'package:ecommerce/helper/graphql_helper.dart';
import 'package:ecommerce/models/feed.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class FeedRepository {
  final GraphQLConfig _graphQLConfig;

  FeedRepository({@required GraphQLConfig graphQLConfig})
      : _graphQLConfig = graphQLConfig;

  Future<List<Feed>> fetchAllFeeds() async {
    GraphQLClient _graphQLClient = await _graphQLConfig.getPrivateClient();

    QueryResult result = await _graphQLClient.query(
      QueryOptions(
        document: gql(
          GraphQLQueryHelper.getFeedsQuery,
        ),
      ),
    );

    if (!result.hasException) {
      List<Feed> feeds = [];
      result.data['post_getHomePageFeed']['items'].forEach((element) {
        feeds.add(Feed.fromJson(element));
      });

      return feeds;
    }
    throw result.exception;
  }
}
