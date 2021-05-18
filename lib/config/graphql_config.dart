import 'package:ecommerce/helper/graphql_helper.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GraphQLConfig {
  static const String graphQLEndPoint = "https://apigateway-dev.kyubook.com";

  static GraphQLClient _publicClient, _privateClient;

  GraphQLClient getPublicClient() {
    if (_publicClient == null) {
      _publicClient = GraphQLClient(
          link: HttpLink(
            graphQLEndPoint,
          ),
          cache: GraphQLCache());
    }

    return _publicClient;
  }

  Future<GraphQLClient> getPrivateClient() async {
    if (_privateClient == null) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      final String authorization = sharedPreferences.getString("authorization");

      _privateClient = GraphQLClient(
          link: HttpLink(graphQLEndPoint,
              defaultHeaders: {"authorization": authorization}),
          cache: GraphQLCache());
    }

    return _privateClient;
  }

  Future<void> saveUserTokens(
      {@required String authorization, @required String refreshToken}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("authorization", authorization);
    await sharedPreferences.setString("refresh_token", refreshToken);
  }

  Future<bool> isUserLogedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String authorization = sharedPreferences.getString("authorization");
    final String refreshToken = sharedPreferences.getString("refresh_token");

    return (authorization != null && refreshToken != null);
  }

  Future<void> refreshToken() async {
    _privateClient = null;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String refreshToken = sharedPreferences.getString("refresh_token");

    QueryResult result = await GraphQLClient(
            link: HttpLink(graphQLEndPoint,
                defaultHeaders: {"refresh_token": refreshToken}),
            cache: GraphQLCache())
        .mutate(
      MutationOptions(
        document: gql(
          GraphQLQueryHelper.refreshToken,
        ),
      ),
    );

    if (!result.hasException) {
      await saveUserTokens(
          authorization: result.data['user_getTokens']['access_token'],
          refreshToken: result.data['user_getTokens']['refresh_token']);
    }
  }

  Future<void> signOut() async {
    _privateClient = null;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final String authorization = sharedPreferences.getString("authorization");
    final String refreshToken = sharedPreferences.getString("refresh_token");

    sharedPreferences.setString("authorization", null);
    sharedPreferences.setString("refresh_token", null);

    GraphQLClient(
            link: HttpLink(graphQLEndPoint, defaultHeaders: {
              "authorization": authorization,
              "refresh_token": refreshToken,
            }),
            cache: GraphQLCache())
        .query(
      QueryOptions(
        document: gql(
          GraphQLQueryHelper.signOutQuery,
        ),
      ),
    );
  }
}
