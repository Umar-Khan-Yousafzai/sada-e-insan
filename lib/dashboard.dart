import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sadaeniswa/about.dart';
import 'package:sadaeniswa/help.dart';
import 'package:sadaeniswa/login_page.dart';
import 'package:sadaeniswa/post_page.dart';
import 'package:sadaeniswa/privacy_policy.dart';
import 'package:sadaeniswa/report_problem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sadaeniswa/auth_rss.dart';

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
    posted.getPosts().then((results){
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
            ? Text('SADA-E-NISWA')
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
      persistentFooterButtons: <Widget>[
        Text("SADA-E-NISWA"),
      ],
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
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
                dispose();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body:_posts(),
     /* ListView.builder(
          itemCount: post.documents.length,
          padding: EdgeInsets.all(5.0) ,
          itemBuilder: (context, i){
            return new ListTile(
              title: Text(post.documents[i].data['Title']),
              subtitle: Text(post.documents[i].data['post']),
              leading: CircleAvatar(
                child: Icon(Icons.person),
                backgroundColor: Colors.pinkAccent.shade100,
                foregroundColor: Colors.white,
              ),
            );

          }),*//*),
            Divider(),
            ListTile(
              title: Text("Post Title..."),
              subtitle: Text("meta data of post..."),
             */

      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        backgroundColor: Colors.pinkAccent,
        label: Text('Add Post'),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PostPage();
          }
          )
          );
        },
      ),


    );
  }
  Widget _posts() {
    return StreamBuilder(
        stream: Firestore.instance.collection("posts").snapshots(),
    builder: (context, post) {
          if(post.data == null) return CircularProgressIndicator();{
    return ListView.builder(
        itemCount: post.data.documents.length,
        padding: EdgeInsets.all(5.0) ,
        itemBuilder: (context, i){
          return new ListTile(
            title: Text(post.data.documents[i].data['Title']),
            subtitle: Text(post.data.documents[i].data['post']),
            leading: CircleAvatar(
              child: Icon(Icons.person),
              backgroundColor: Colors.pinkAccent.shade100,
              foregroundColor: Colors.white,
            ),
          );
        },

      );
    }
    });

}
}

//Arslan hafeez
//Umar Farooq Khan Yousafzai