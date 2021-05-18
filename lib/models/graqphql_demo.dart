import 'package:flutter/material.dart';

class GraphQLDemo {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String profilePic;

  GraphQLDemo(
      {@required this.id,
      @required this.firstName,
      @required this.lastName,
      @required this.email,
      @required this.profilePic});

  factory GraphQLDemo.fromJson(Map<String, dynamic> json) {
    return GraphQLDemo(
        id: json['user_details']['id'],
        firstName: json['user_details']['first_name'],
        lastName: json['user_details']['last_name'],
        email: json['user_details']['email'],
        profilePic: json['user_details']['profile_pic']);
  }
}
