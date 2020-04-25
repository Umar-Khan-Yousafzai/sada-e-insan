import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../../Resources/blocdata.dart';
import '../../Screens/dashboard.dart';

Bloc bloc = new Bloc();
DateTime dateTime = DateTime.now();

// ignore: non_constant_identifier_names
final _get_comment = TextEditingController();

class PostView extends StatefulWidget {
  final String documentID;

  PostView({Key key, @required this.documentID}) : super(key: key);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
        stream: Firestore.instance
            .collection('posts')
            .document(widget.documentID)
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

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    children: <Widget>[
                      StreamBuilder(
                        stream: Firestore.instance
                            .collection('comments')
                            .where('postID', isEqualTo: widget.documentID)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> docShot) {
                          if (docShot.hasData) {
                            //  print("MOM"+docShot.data.documents[0].data['commentContent'].toString());
                            return Container(
                                // height: double.maxFinite,
                                child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: docShot.data.documents.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                    leading: ClipOval(
                                      child: Image.network(
                                        docShot.data.documents[index]
                                            .data['userPhotoUrl'].toString(),
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),

                                    title: Text(
                                  docShot.data.documents[index]
                                      .data['commentContent']
                                      .toString(),

                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ));
                              },
                            ));
                          }
                          return Container();
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: TextFormField(
                            textAlign: TextAlign.center,
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
                                onPressed: () {/*
                                  DocumentReference CommentReference = Firestore
                                      .instance
                                      .collection('comments')
                                      .document();
                                  Future<void> createCommentDocument() async {
                                    Map<String, dynamic> postComment =
                                    <String, dynamic>{
                                      "postID": widget.documentID,
                                      //"commentID":commentReference.documentID,
                                      "commentContent":
                                      _get_comment.text.toString(),
                                      "userID": userid,
                                      "userEmail": userEmail,
                                      "userPhotoUrl": userPhotoUrl,
                                      "userName": userdisplayname,
                                      "timestamp": dateTime,
                                      "commentID": CommentReference.documentID
                                    };
                                    CommentReference.setData(postComment);
                                  }

                                  createCommentDocument();
                                */},
                              ),
                              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
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
