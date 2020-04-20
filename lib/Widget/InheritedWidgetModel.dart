import 'package:flutter/material.dart';
import 'package:sadaeniswa/Models/Model.dart';
import 'package:sadaeniswa/Models/PostModel.dart';


class InheritedPostModel extends InheritedWidget {
  //final PostModel postData;
  final Model modelData;
  final Widget child;

  InheritedPostModel({
    Key key,
    @required this.modelData,
    this.child,
  }) : super(key: key, child: child);

  static InheritedPostModel of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<InheritedPostModel>());
  }

  @override
  bool updateShouldNotify(InheritedPostModel oldWidget) {
    return true;
  }
}
