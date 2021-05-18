import 'package:ecommerce/config/graphql_config.dart';
import 'package:ecommerce/helper/graphql_helper.dart';
import 'package:ecommerce/models/graqphql_demo.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLDemoProvider extends ChangeNotifier {
  List<GraphQLDemo> datas;

  final GraphQLClient _graphQLClient = GraphQLConfig().clientToQuery();

  Future<void> getDatas() async {
    QueryResult result = await _graphQLClient.query(
      QueryOptions(
        document: gql(
          GraphQLQueryHelper.getAllData,
        ),
      ),
    );

    if (!result.hasException) {
      datas = [];
      result.data['post_getPublicHomePageFeed']['items'].forEach((element) {
        datas.add(GraphQLDemo.fromJson(element));
      });
    } else {
      print(result.exception.toString());
    }

    notifyListeners();
  }
}
