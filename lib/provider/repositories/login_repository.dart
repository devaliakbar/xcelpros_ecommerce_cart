import 'package:ecommerce/config/graphql_config.dart';
import 'package:ecommerce/helper/graphql_helper.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LoginRepository {
  final GraphQLConfig graphQLConfig;

  GraphQLClient _graphQLClient;

  LoginRepository({@required this.graphQLConfig}) {
    _graphQLClient = graphQLConfig.getPublicClient();
  }

  Future<bool> login(
      {@required String email, @required String password}) async {
    QueryResult result = await _graphQLClient.mutate(
      MutationOptions(
        document: gql(
          GraphQLQueryHelper.getLoginQuery(email: email, password: password),
        ),
      ),
    );

    if (!result.hasException) {
      await graphQLConfig.saveUserTokens(
          authorization: result.data['user_loginUser']['access_token'],
          refreshToken: result.data['user_loginUser']['refresh_token']);

      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkAlredyLogin() async {
    return await graphQLConfig.isUserLogedIn();
  }
}
