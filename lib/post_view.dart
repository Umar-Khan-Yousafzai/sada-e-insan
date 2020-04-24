import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sadaeniswa/Database/Firestore_database.dart';
import 'package:sadaeniswa/about.dart';
import 'package:sadaeniswa/help.dart';
import 'package:sadaeniswa/login_page.dart';
import 'package:sadaeniswa/post_page.dart';
import 'package:sadaeniswa/post_view.dart';
import 'package:sadaeniswa/privacy_policy.dart';
import 'package:sadaeniswa/report_problem.dart';
import 'package:sadaeniswa/auth_rss.dart';
import 'package:intl/intl.dart';
import 'Database/blocdata.dart';
import 'dashboard.dart';

String doc;
Bloc bloc = new Bloc();
final _get_comment = TextEditingController();

class PostView extends StatelessWidget {
  bool isSearching = false;
  final String documentID;

  PostView({Key key, @required this.documentID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
        stream: Firestore.instance
            .collection('posts')
            .document(documentID)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var userDocument = snapshot.data;

          String date = DateFormat.yMMMd()
              .format(userDocument['timestamp'].toDate())
              .toString();

          return Scaffold(
            appBar: AppBar(
              elevation: 2,
              title: Column(
                children: <Widget>[
                  FittedBox(
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    child: Text(
                      userDocument['title'].toString(),
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              backgroundColor: Colors.pinkAccent,
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Material(
                elevation: 24,
                color: Colors.white,
                shadowColor: Colors.blueGrey,
                child: Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Image.network(userDocument['imageUri']),
                      ),
                    ],
                  ),
                  Row(
                    verticalDirection: VerticalDirection.down,
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.all(6),
                        child: Text(
                          userDocument['post'].toString(),
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 19,
                          ),
                        ),
                      ))
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.green,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                        child: ClipOval(
                          child: Image.network(
                            userDocument['userPhotoUrluserName'].toString(),
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(2, 0, 10, 0),
                            child: Text(
                              "Umar Khan Yousafzai",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 13),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(2, 0, 10, 0),
                            child: Text(
                              "17th April 2020",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Color(0xffe5452e),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextField(
                            controller: _get_comment,
                            keyboardType: TextInputType.multiline,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1000),
                            ],
                            maxLines: null,
                            autofocus: false,
                            decoration: InputDecoration(
                              hintText: "What's on your mind?",
                              suffixIcon: IconButton(
                                icon: Icon(Icons.comment),
                                onPressed: () {
                                  DateTime dateTime = DateTime.now();
                                  bloc.createComment(
                                    _get_comment.text.toString(),
                                    documentID.toString(),
                                  ).whenComplete((){
                                  _get_comment.clear();
                                  print("Comment Posted SuccessFully");
                                  }
                                  );
                                },
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ]),
              ),
            ),
          );
        });
  }
}
