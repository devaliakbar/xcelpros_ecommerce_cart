import 'package:ecommerce/error/exceptions.dart';
import 'package:ecommerce/models/feed.dart';
import 'package:ecommerce/provider/repositories/feed_repository.dart';
import 'package:flutter/material.dart';

enum LoginState { loading, loaded, errorState, logOut }

class FeedProvider extends ChangeNotifier {
  final FeedRepository feedRepository;

  LoginState loginState = LoginState.loading;

  FeedProvider({@required this.feedRepository});

  List<Feed> feeds;

  Future<void> fetchAllFeeds() async {
    loginState = LoginState.loading;

    try {
      feeds = await feedRepository.fetchAllFeeds();
      loginState = LoginState.loaded;
    } on UnAuthorizedException {
      loginState = LoginState.logOut;
    } catch (e) {
      print(e.toString());
      loginState = LoginState.errorState;
    }

    notifyListeners();
  }

  Future<void> retry() async {
    loginState = LoginState.loading;
    notifyListeners();
    fetchAllFeeds();
  }
}
