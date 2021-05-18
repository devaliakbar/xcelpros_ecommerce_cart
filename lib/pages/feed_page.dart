import 'package:ecommerce/models/feed.dart';
import 'package:ecommerce/provider/feed_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatelessWidget {
  static const String routeName = '/feed_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feed"),
        actions: [
          FlatButton(
            onPressed: () {},
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
              if (feedProvider.feeds == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                    itemCount: feedProvider.feeds.length,
                    itemBuilder: (BuildContext context, int index) {
                      Feed feed = feedProvider.feeds[index];
                      return ListTile(
                        title: Text(feed.postTitle),
                        dense: true,
                        subtitle: Text(feed.postDescription),
                      );
                    });
              }
            },
          ),
        ),
      ),
    );
  }
}
