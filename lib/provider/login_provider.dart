import 'package:ecommerce/config/graphql_config.dart';
import 'package:ecommerce/helper/graphql_helper.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  final GraphQLClient _graphQLClient = GraphQLConfig().getPublicClient();

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
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString(
          "authorization", result.data['user_loginUser']['access_token']);
      await sharedPreferences.setString(
          "refresh_token", result.data['user_loginUser']['refresh_token']);

      return true;
    } else {
      return false;
    }
  }
}
