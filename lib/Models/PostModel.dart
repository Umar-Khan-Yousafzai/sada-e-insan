import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sadaeniswa/Models/UserModel.dart';
import 'package:sadaeniswa/Models/CommentModel.dart';
class PostModel {
  final String title;
  final String postBody;
  final String userID;
  final String userPhotoUrl;
  final String userName;
  final DateTime timestamp;
  final String  imageUri;
  final String postID ;

  // final int reacts, views;
 // final UserModel author;
  //final List<CommentModel> comments;

  const PostModel( {
    @required this.userID,
    @required this.userPhotoUrl,
    @required this.postID,
    @required this.title,
    @required this.postBody,
    @required this.imageUri,
    @required this.userName,
    @required this.timestamp,
  });

  String get postTimeFormatted => DateFormat.yMMMMEEEEd().format(timestamp);
}
