import 'package:flutter/material.dart';
class PostModel {
  String title;
  String post;
  String userEmail;
  String userPhotoUrl;
  String userName;
  DateTime timestamp;
  String  imageUri;String postID ;
  bool issue;
  // final int reacts, views;
 // final UserModel author;
  //final List<CommentModel> comments;
  PostModel( {
    @required this.userEmail,
    @required this.userPhotoUrl,
    @required this.postID,
    @required this.title,
    @required this.post,
    @required this.imageUri,
    @required this.userName,
    @required this.timestamp,
  });

   PostModel.issue( {
    @required this.userEmail,
    @required this.userPhotoUrl,
    @required this.postID,
    @required this.title,
    @required this.post,
    @required this.imageUri,
    @required this.userName,
    @required this.timestamp,
    @required this.issue,
   });
  Map toPostMap(PostModel post) {
    var data = Map<String, dynamic>();
    data['userEmail'] = post.userEmail;
    data['userName'] = post.userName;
    data["post"] = post.post;
    data["title"] = post.title;
    data["userPhotoUrl"] = post.userPhotoUrl;
    data["imageUri"] = post.imageUri;
    data['timestamp'] = post.timestamp;
    data['postID'] = post.postID;
    return data;
  }



}
