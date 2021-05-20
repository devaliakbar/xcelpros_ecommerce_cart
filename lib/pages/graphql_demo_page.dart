import 'package:ecommerce/models/graqphql_demo.dart';
import 'package:ecommerce/provider/graphql_demo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GraphQlDemoPage extends StatelessWidget {
  static const String routeName = '/graphql_demo_page';

  @override
  Widget build(BuildContext context) {
    Provider.of<GraphQLDemoProvider>(context, listen: false).getDatas();

    return Scaffold(
      appBar: AppBar(
        title: Text("GraphQLDemo"),
      ),
      body: SafeArea(
        child: Consumer<GraphQLDemoProvider>(builder: (BuildContext context,
            GraphQLDemoProvider graphQLDemoProvider, Widget child) {
          if (graphQLDemoProvider.datas == null) {
            return Center(
              child: Text(
                "Loading ...",
                key: Key("loading"),
              ),
            );
          }
          return ListView.builder(
              key: Key("demoList"),
              itemCount: graphQLDemoProvider.datas.length,
              itemBuilder: (BuildContext context, int index) {
                GraphQLDemo data = graphQLDemoProvider.datas[index];
                return ListTile(
                  dense: true,
                  title: Text(data.firstName + " " + data.lastName),
                  leading: SizedBox(
                    height: 30,
                    width: 30,
                    child: (data.profilePic == null || data.profilePic == "")
                        ? Icon(Icons.error_outline)
                        : Image.network(
                            data.profilePic,
                            fit: BoxFit.fill,
                          ),
                  ),
                  subtitle: Text(data.email),
                );
              });
        }),
      ),
    );
  }
}
