import 'package:flutter/material.dart';

class GraphQLQueryHelper {
  static const String getGraphQLDemoQuery = """
{
  post_getPublicHomePageFeed(take: 10, skip: 0, order: "DESC") {
    items {
      user_details {
        id
        first_name
        last_name
        profile_pic
        email
      }
    }
  }
}
  """;

  static const String getFeedsQuery = """
{
  post_getHomePageFeed {
    items {
      id
      post_title
      post_description
    }
  }
}
  """;

  static String getLoginQuery(
      {@required String email, @required String password}) {
    return """
mutation {
  user_loginUser(
    email: "$email"
    password: "$password"
    device_token: "ner5fuuqc9l"
  ) {
    first_name
    access_token
    refresh_token
  }
}
        """;
  }

  static const String refreshToken = """
mutation {
  user_getTokens {
    access_token
    refresh_token
  }
}
  """;

  static const String signOutQuery = """
{
  user_logout
}
  """;
}
