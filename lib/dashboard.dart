/*;*/
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sadaeniswa/about.dart';
import 'package:sadaeniswa/help.dart';
import 'package:sadaeniswa/login_page.dart';
import 'package:sadaeniswa/post_page.dart';
import 'package:sadaeniswa/privacy_policy.dart';
import 'package:sadaeniswa/report_problem.dart';
import 'package:sadaeniswa/auth_rss.dart';

final userdisplayname = authr.googleSignIn.currentUser.displayName;
final userid = authr.googleSignIn.currentUser.id;
final userEmail = authr.googleSignIn.currentUser.email;
final userPhotoUrl = authr.googleSignIn.currentUser.photoUrl;
auth_resources authr = new auth_resources();
PostPage posts = new PostPage();

class Dashboard extends StatefulWidget {
  static String tag = 'dashboard';

  @override
  _DashboardState createState() => _DashboardState();
}

PostPage posted = new PostPage();

class _DashboardState extends State<Dashboard> {
  bool isSearching = false;
  QuerySnapshot post;

  @override
  void initState() {
    posted.getPosts().then((results) {
      setState(() {
        post = results;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent.shade100,
        title: !isSearching
            ? Text(
                'SADA-E-NISWA',
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
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        backgroundColor: Colors.pinkAccent,
        label: Text('Add Post'),
        onPressed: () {
          //   authr.signInWithGoogle();

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            authr.googleSignIn.signInSilently();
            return PostPage();
          }));
        },
      ),
    );
  }

  Widget _posts() {
    GoogleSignIn gsn;

    return StreamBuilder(
        stream: Firestore.instance
            .collection('posts')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, post) {
          if (post.data == null) return CircularProgressIndicator();
          {
            GoogleSignIn signIn;

            return ListView.builder(
              itemCount: post.data.documents.length,
              //padding: EdgeInsets.all(16.0) ,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, i) {
              return Container(
               padding: EdgeInsets.fromLTRB(10,17,10,17), height: 530,
            width: 400,
                child:Material(

                    borderRadius: BorderRadius.circular(20.00),
                    shadowColor: Colors.blueGrey,
                    elevation: 24,
                    color: Colors.white,
                    child : Column(
                    children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(16),
                          child:FittedBox(
                            fit:BoxFit.contain,
                            child: Text(post.data.documents[i].data['title'].toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),),
                          ) ,
                        )

                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                post.data.documents[i].data['imageUri'].toString()
                            ,width: 330,
                            ),
                          ),

                        ) ,
                      ),

                      ],
                    ), //IMAGE Container
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.start,

                      children: <Widget>[
                        Container(

                          height: 110,
                          padding: const EdgeInsets.fromLTRB(14, 2, 10, 14),
                          child: Text(
                            post.data.documents[i].data['post'].toString()+"..."
                            ,
                            maxLines: 5,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 16
                            ),
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
                       padding: EdgeInsets.fromLTRB(10, 1, 10, 10),
                       child: ClipOval(
                         child: Image.network(post.data.documents[i].data['userPhotoUrluserName'].toString()
                         ,width: 60,
                         height: 60,),
                       ),
                     ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[

                            Container(
                              padding: EdgeInsets.fromLTRB(4, 1, 10, 0),
                              child:  Text("Umar Khan Yousafzai"
                              ),
                            ),Container(
                              padding: EdgeInsets.fromLTRB(4, 0, 10,0),
                              child:  Text("17th April 2020"
                              ),
                            ),
                          ],
                        ),

                      ]
                      )


                  ]


                    )));

              },
            );
          }
        });
  }


}
//Arslan hafeez
//Umar Farooq Khan Yousafzai
