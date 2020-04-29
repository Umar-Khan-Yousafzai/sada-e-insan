/*;*/
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sadaeniswa/Pages/about.dart';
import 'package:sadaeniswa/Pages/help.dart';
import 'package:sadaeniswa/Resources/FirebaseAuthenticationMethods.dart';
import 'package:sadaeniswa/Screens/login_page.dart';
import 'package:sadaeniswa/Screens/searchScreen.dart';
import 'package:sadaeniswa/post_page.dart';
import 'package:sadaeniswa/post_view.dart';
import 'package:sadaeniswa/Pages/privacy_policy.dart';
import 'package:sadaeniswa/Pages/report_problem.dart';
import 'package:sadaeniswa/Widgets/customappbar.dart';

final FirebaseAuthenticationRepository _authenticationRepository =
    new FirebaseAuthenticationRepository();
PostPage posts = new PostPage();

class Dashboard extends StatefulWidget {
  static String tag = 'dashboard';

  @override
  _DashboardState createState() => _DashboardState();
}

PostPage posted = new PostPage();
class _DashboardState extends State<Dashboard> {
  CustomWidget _customWidget = new CustomWidget();
  CustomBorder _customBorder = CustomBorder();
  bool isSearching = false;
  QuerySnapshot post;
  String currentUserDisplayName;

  @override
  void initState() {
    super.initState();
    _authenticationRepository.getCurrentUser().then((user) {
      setState(() {
        currentUserDisplayName = user.displayName;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //  User =  _loginPage.getSign() as FirebaseUser;
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
                    focusColor: Colors.white,
                    fillColor: Colors.white,
                    //  icon: Icon(Icons.search),
                    hintText: "Search here..."),
              ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {

                return SearchScreen();
              }));

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
              title: Text(currentUserDisplayName.toString()),
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
                dispose();
                _authenticationRepository.signOut();
                //  dispose();
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
      bottomNavigationBar: _customWidget.CustomBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.pinkAccent.shade400,
        shape: _customBorder,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                String date = DateFormat.yMMMd()
                    .format(post.data.documents[i].data['timestamp'].toDate());

                return Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 8), //height: 530,
                    // width: 400,

                    child: Material(
                        borderRadius: BorderRadius.circular(20.00),
                        shadowColor: Colors.blueGrey,
                        elevation: 8,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(16),
                                      child: Text(
                                        post.data.documents[i].data['title']
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          //color: Colors.purpleAccent.shade100,
                                          gradient: LinearGradient(
                                              begin: Alignment.topRight,
                                              end: Alignment.bottomLeft,
                                              colors: [
                                                Colors.pinkAccent.shade700,
                                                Colors.pinkAccent.shade200,
                                                Colors.pinkAccent.shade200
                                              ]),
                                          borderRadius: new BorderRadius.only(
                                              topLeft:
                                                  const Radius.circular(20.0),
                                              topRight:
                                                  const Radius.circular(20.0))),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Expanded(
                                    child: Image.network(post
                                        .data.documents[i].data['imageUri']),
                                  ),
                                ],
                              ), //IMAGE Container
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    //  height: 110,
                                    //
                                    child: Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            14, 2, 10, 14),
                                        child: Text(
                                          post.data.documents[i].data['post']
                                                  .toString() +
                                              "...",
                                          maxLines: 5,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(fontSize: 16),
                                        )),
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
                                              .data['userPhotoUrl']
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
                                            post.data.documents[i]
                                                .data['userName']
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 13),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(2, 0, 10, 0),
                                          child: Text(
                                            date,
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
