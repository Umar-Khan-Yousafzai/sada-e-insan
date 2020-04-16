/*;*/
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    return StreamBuilder(
        stream: Firestore.instance
            .collection('posts')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, post) {
          if (post.data == null) return CircularProgressIndicator();
          {
            return ListView.builder(

              itemCount: post.data.documents.length,
              //padding: EdgeInsets.all(16.0) ,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(

                    child: new FittedBox(
                      fit: BoxFit.contain,
                      child: Card(
                        color: Colors.white,
                        elevation: 24,
                        //borderRadius: BorderRadius.vertical(),
                        //shadowColor: Color(0x802196F3),
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                        Container(
                          width: 300,
                          height: 300,
                        color: Colors.red,
                        alignment: Alignment.topCenter,
                       child: Column(
                         children: <Widget>[

                           Padding(
                             padding: const EdgeInsets.all(4.0), child: Text(post.data.documents[i].data['title'].toString(),
                             style: TextStyle(color: Color(0xffe6020a), fontSize: 20.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),),
                           Padding(
                             padding: const EdgeInsets.all(4.0), child: Text(post.data.documents[i].data['post'].toString(),
                             style: TextStyle(color: Colors.blueGrey, fontSize: 14.0),textAlign: TextAlign.left, maxLines: 1,),),

                           Row(

//mainAxisAlignment: MainAxisAlignment.end,
                             children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  color: Colors.amberAccent,
                                  child:Divider(color: Colors.green),
                                )
                              ],
                            ),

                               Container(
                            padding: EdgeInsets.all(3.0),
                                   color: Colors.blue,

                                 child:ClipOval(

                                     child: Image.network(

                                         post.data.documents[i].data['userPhotoUrluserName'],
                                         width: 30,
                                         height: 30,
                                         fit: BoxFit.cover
                                     )

                               ))
                             ],
                           ),
                         ],
                       ),
                      ),

                         SizedBox(
                              width: 10,
                              height: 300,
                            ),
                             Container(  width: 230,
                               height: 300,

                               alignment: Alignment.topRight,
                              child: ClipRRect(
                                  borderRadius: new BorderRadius.vertical(),
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Image(
                                      width: 230,
                                      height: 300,

                                      alignment: Alignment.topRight,
                                      fit: BoxFit.fill,
                                      // alignment: Alignment.centerRight,
                                      image: NetworkImage(
                                          post.data.documents[i].data['imageUri']),),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
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
