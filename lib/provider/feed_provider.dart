import 'package:ecommerce/models/feed.dart';
import 'package:ecommerce/provider/repositories/feed_repository.dart';
import 'package:flutter/material.dart';

class FeedProvider extends ChangeNotifier {
  final FeedRepository feedRepository;

  FeedProvider({@required this.feedRepository});

  List<Feed> feeds;

  Future<void> fetchAllFeeds() async {
    try {
      feeds = await feedRepository.fetchAllFeeds();
    } catch (e) {
      print(e.toString());
      //TODO CHECK AUTH ERROR
      // GraphQLConfig().signOut();
    }

    notifyListeners();
  }
}
