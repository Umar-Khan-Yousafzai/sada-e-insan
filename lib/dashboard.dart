/*;*/
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sadaeniswa/Models/UserModel.dart';
import 'package:sadaeniswa/Resources/FirebaseAuthenticationMethods.dart';
import 'package:sadaeniswa/Screens/login_page.dart';
import 'package:sadaeniswa/about.dart';
import 'package:sadaeniswa/auth_rss.dart';
import 'package:sadaeniswa/help.dart';
import 'package:sadaeniswa/post_page.dart';
import 'package:sadaeniswa/post_view.dart';
import 'package:sadaeniswa/privacy_policy.dart';
import 'package:sadaeniswa/report_problem.dart';

final userdisplayname = authr.googleSignIn.currentUser.displayName;
final userid = authr.googleSignIn.currentUser.id;
final userEmail = authr.googleSignIn.currentUser.email;
final userPhotoUrl = authr.googleSignIn.currentUser.photoUrl;
auth_resources authr = new auth_resources();
PostPage posts = new PostPage();
FirebaseAuthenticationRepository _fbAuth =
    new FirebaseAuthenticationRepository();

class Dashboard extends StatefulWidget {
  static String tag = 'dashboard';
  UserModel user = new UserModel();

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isSearching = false;
  QuerySnapshot post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 23,
        backgroundColor: Colors.pinkAccent.shade100,
        title: !isSearching
            ? Text(
                'SADA-E-INSAN',
                textAlign: TextAlign.center,
              )
            : TextField(
                decoration: InputDecoration(
                    //  icon: Icon(Icons.search),
                    hintText: "Search here..."),
              ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                this.isSearching = !this.isSearching;
              });
            },
          ),
        ],
      ),
      //persistentFooterButtons: <Widget>[
      //Text("SADA-E-NISWA"),
      //],
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person_outline),
              ),

              title: Text(authr.googleSignIn.currentUser.displayName),

              //  title: Text("Sham e Firaq"),
              subtitle: Text("How are you doing?"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return About();
                }));
              },
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.apps),
              ),
              title: Text("About"),
              subtitle: Text("app development"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return About();
                }));
              },
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.help),
              ),
              title: Text("Help"),
              subtitle: Text("any problem?"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Help();
                }));
              },
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.print),
              ),
              title: Text("Privacy Policy"),
              subtitle: Text("we are confident about our application"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PrivacyPolicy();
                }));
              },
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.report_problem),
              ),
              title: Text("Report a Problem"),
              subtitle: Text("feel free to ask"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ReportProblem();
                }));
              },
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.account_box),
              ),
              title: Text("Logout"),
              subtitle: Text("session will be closed"),
              onTap: () {
                authr.signOutGoogle();
                //  dispose();

                _fbAuth.signOut();

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: _posts(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.pinkAccent,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            authr.googleSignIn.signInSilently();

            return PostPage();
          }));
        },
      ),
    );
  }

  Widget _posts() {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('posts')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> post) {
          if (post.data == null) return CircularProgressIndicator();
          {
            return ListView.builder(
              itemCount: post.data.documents.length,
              //padding: EdgeInsets.all(16.0) ,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, i) {
                DocumentSnapshot ds = post.data.documents[i];

                if (ds['imageUri'] == null) {}
                return Container(
                    padding: EdgeInsets.fromLTRB(10, 14, 10, 14),
                    height: 530,
                    width: 400,
                    child: Material(
                        borderRadius: BorderRadius.circular(20.00),
                        shadowColor: Colors.blueGrey,
                        elevation: 24,
                        color: Colors.white,
                        child: InkWell(
                            onTap: () {
                              var route = new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new PostView(
                                          documentID: post
                                              .data.documents[i].documentID));
                              print(post.data.documents[i].documentID +
                                  "yeh document ID hai");
                              Navigator.of(context).push(route);
                            },
                            child: Column(children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        post.data.documents[i].data['title']
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 240,
                                      width: 330,
                                      //  padding: const EdgeInsets.all(16),
                                      child: FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Image.network(
                                          post.data.documents[i]
                                              .data['imageUri']
                                              .toString(),
                                          width: 330,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ), //IMAGE Container
                              Column(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 110,
                                    padding: const EdgeInsets.fromLTRB(
                                        14, 2, 10, 14),
                                    child: Text(
                                      post.data.documents[i].data['post']
                                              .toString() +
                                          "...",
                                      maxLines: 5,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  //    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //              mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 5, 10, 10),
                                      child: ClipOval(
                                        child: Image.network(
                                          post.data.documents[i]
                                              .data['userPhotoUrluserName']
                                              .toString(),
                                          width: 40,
                                          height: 40,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(2, 0, 10, 0),
                                          child: Text(
                                            "Umar Khan Yousafzai",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 13),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(2, 0, 10, 0),
                                          child: Text(
                                            "17th April 2020",
                                            style: TextStyle(
                                                color: Color(0xffe5452e),
                                                fontWeight: FontWeight.w900,
                                                fontSize: 13),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.fromLTRB(70, 0, 0, 0),
                                      child: Icon(
                                        FontAwesomeIcons.thumbsUp,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Icon(
                                        FontAwesomeIcons.comment,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Icon(
                                        FontAwesomeIcons.heart,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                  ])
                            ]))));
              },
            );
          }
        });
  }
}
//Arslan hafeez
//Umar Farooq Khan Yousafzai
