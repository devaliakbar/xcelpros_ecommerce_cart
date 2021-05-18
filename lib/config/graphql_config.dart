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
      final String refreshToken = sharedPreferences.getString("refresh_token");

      _privateClient = GraphQLClient(
          link: HttpLink(graphQLEndPoint, defaultHeaders: {
            "authorization": authorization,
            "refresh_token": refreshToken,
          }),
          cache: GraphQLCache());
    }

    return _privateClient;
  }
}
