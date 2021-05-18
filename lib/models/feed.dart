import 'package:flutter/material.dart';

class Feed {
  final String id;
  final String postTitle;
  final String postDescription;

  Feed(
      {@required this.id,
      @required this.postTitle,
      @required this.postDescription});

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
        id: json['id'],
        postTitle: json['post_title'],
        postDescription: json['post_description']);
  }
}
