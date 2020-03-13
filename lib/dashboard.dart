import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sadaeniswa/about.dart';
import 'package:sadaeniswa/help.dart';
import 'package:sadaeniswa/login_page.dart';
import 'package:sadaeniswa/post_page.dart';
import 'package:sadaeniswa/privacy_policy.dart';
import 'package:sadaeniswa/report_problem.dart';

class Dashboard extends StatefulWidget {
  static String tag = 'dashboard';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  bool isSearching = false;


  @override
  Widget build(BuildContext context) {

      return Scaffold(

        appBar: AppBar(

          backgroundColor: Colors.pinkAccent,

          title: !isSearching ? Text('SADA-E-NISWA') : TextField(decoration: InputDecoration(

              icon: Icon(Icons.search), hintText: "Search here..."),
          ),

          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                setState(() {
                  this.isSearching = !this.isSearching;
                });
              },
            ),
          ],

            //title: Center(child: Text("SADA-E-NISWA")),
//
//          actions: <Widget>[
//         PopupMenuButton(
//           itemBuilder: (context){
//             return PopupMenuItem(
//
//             );
//
//           },
//         )
//       ],

        ),

        drawer: Drawer(
          child: ListView(
            children: <Widget>[


              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.apps),
                ),
                title: Text("About"),
                subtitle: Text("app development"),
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return About();
                      }
                      )
                  );
                },
              ),

              Divider(),

              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.help),

                ),

                title: Text("Help"),
                subtitle: Text("any problem?"),
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return Help();
                      }
                      )
                  );
                },

              ),

              Divider(),

              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.print),

                ),

                title: Text("Privacy Policy"),
                subtitle: Text("we are confident about our application"),
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return PrivacyPolicy();
                      }
                      )
                  );
                },

              ),

              Divider(),

              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.report_problem),

                ),

                title: Text("Report a Problem"),
                subtitle: Text("feel free to ask"),
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return ReportProblem();
                      }
                      )
                  );
                },

              ),

              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.account_box),

                ),

                title: Text("Logout"),
                subtitle: Text("session will be closed"),
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return LoginPage();
                      }
                      )
                  );
                },

              )


            ],
          ),
        ),

        backgroundColor: Colors.white,

        body: Center(
        child: ListView(
          children: <Widget>[
//
//          Row(
//            children: <Widget>[
//              Container(
//                margin: EdgeInsets.all(10),
//                padding: EdgeInsets.all(10),
//                child: CircleAvatar(
//                  backgroundColor: Colors.pinkAccent,
//                  child: Icon(Icons.add),
//                ),
//              ),
//              Container(
//
//              )
//            ],
//          )

            ListTile(
              title: Text(
                  "Dashboard",
                style: TextStyle(height: 1, fontSize: 25, color: Colors.green),
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.dashboard),
              ),
            ),

            ListTile(
              title: Text("Post Title..."),
              subtitle: Text("meta data of post..."),
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),

            Divider(),

            ListTile(
              title: Text("Post Title..."),
              subtitle: Text("meta data of post..."),
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),

            Divider(),

            ListTile(
              title: Text("Post Title..."),
              subtitle: Text("meta data of post..."),
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),

            Divider(),

            ListTile(
              title: Text("Post Title..."),
              subtitle: Text("meta data of post..."),
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),

            Divider(),

            ListTile(
              title: Text("Post Title..."),
              subtitle: Text("meta data of post..."),
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),

            Divider(),

            ListTile(
              title: Text("Post Title..."),
              subtitle: Text("meta data of post..."),
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),

            Divider(),

            ListTile(
              title: Text("Post Title..."),
              subtitle: Text("meta data of post..."),
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),

            Divider(),

            ListTile(
              title: Text("Post Title..."),
              subtitle: Text("meta data of post..."),
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),

            Divider(),

            ListTile(
              title: Text("Post Title..."),
              subtitle: Text("meta data of post..."),
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),

            Divider(),

            ListTile(
              title: Text("Post Title..."),
              subtitle: Text("meta data of post..."),
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),

            Divider(),

            ListTile(
              title: Text("Post Title..."),
              subtitle: Text("meta data of post..."),
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),

            Divider(),

            ListTile(
              title: Text("Post Title..."),
              subtitle: Text("meta data of post..."),
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),

            Divider(),

            ListTile(
              title: Text("Post Title..."),
              subtitle: Text("meta data of post..."),
              leading: CircleAvatar(
                child: Icon(Icons.person),

              ),
            ),

          ],
          ),
      ),

//
//        floatingActionButton: FloatingActionButton(
//          onPressed: () {
//            Navigator.push(context,
//                MaterialPageRoute(builder: (context){
//                  return PostPage();
//                }
//                )
//            );
//
//          },
//          child: Icon(Icons.add),
//          backgroundColor: Colors.pinkAccent,
//
//        ),

       floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
         backgroundColor: Colors.pinkAccent,
          label: Text('Add Post'),

          onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context){
                  return PostPage();
                }
                )
            );
          },
        ),



      );





  }
}
