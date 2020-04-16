import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sadaeniswa/Models/UserModel.dart';
import 'package:sadaeniswa/Models/CommentModel.dart';
class PostModel {
  final String id, title, body, imageURL,author;
  final DateTime postTime;
 // final int reacts, views;
 // final UserModel author;
  //final List<CommentModel> comments;

  const PostModel({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.imageURL,
    @required this.author,
    @required this.postTime,
  });

  String get postTimeFormatted => DateFormat.yMMMMEEEEd().format(postTime);
}
