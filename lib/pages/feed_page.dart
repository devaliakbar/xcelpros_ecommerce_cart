import 'dart:async';

import 'package:ecommerce/config/graphql_config.dart';
import 'package:ecommerce/models/feed.dart';
import 'package:ecommerce/pages/home_page.dart';
import 'package:ecommerce/provider/feed_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatelessWidget {
  static const String routeName = '/feed_page';

  @override
  Widget build(BuildContext context) {
    Provider.of<FeedProvider>(context, listen: false).fetchAllFeeds();

    return Scaffold(
      appBar: AppBar(
        title: Text("Feed"),
        actions: [
          FlatButton(
            key: Key("signOutBtnKey"),
            onPressed: () {
              GraphQLConfig().signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  HomePage.routeName, (Route<dynamic> route) => false);
            },
            child: Text(
              'Sign Out',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Consumer<FeedProvider>(
            builder: (BuildContext context, FeedProvider feedProvider,
                Widget child) {
              if (feedProvider.loginState == LoginState.logOut) {
                Timer(Duration(milliseconds: 1), () async {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      HomePage.routeName, (Route<dynamic> route) => false);
                });
              }

              if (feedProvider.loginState == LoginState.errorState) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Failed to fetch'),
                      RaisedButton(
                        onPressed: () {
                          feedProvider.retry();
                        },
                        child: Text("Retry"),
                      )
                    ],
                  ),
                );
              }

              if (feedProvider.loginState == LoginState.loaded) {
                return ListView.builder(
                  key: Key("feedList"),
                  itemCount: feedProvider.feeds.length,
                  itemBuilder: (BuildContext context, int index) {
                    Feed feed = feedProvider.feeds[index];
                    return ListTile(
                      title: Text(feed.postTitle),
                      dense: true,
                      subtitle: Text(feed.postDescription),
                    );
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  key: Key("loadingKey"),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
