import 'package:flutter/material.dart';
import 'package:sadaeniswa/post_page.dart';

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
        backgroundColor: Colors.pink,
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

        /* actions: <Widget>[
       PopupMenuButton(
         itemBuilder: (context){
           return PopupMenuItem(

           );

         },
       )
     ],*/

      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.home),
              ),
              title: Text("Home"),
              subtitle: Text("dashboard"),
            ),

            Divider(),

            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.apps),
              ),
              title: Text("About"),
              subtitle: Text("app development"),
            ),

            Divider(),

            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.help),

              ),

              title: Text("Help"),
              subtitle: Text("any problem?"),

            ),

            Divider(),

            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.print),

              ),

              title: Text("Privacy Policy"),
              subtitle: Text("we are confident about our application"),

            ),

            Divider(),

            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.report_problem),

              ),

              title: Text("Report a Problem"),
              subtitle: Text("feel free to ask"),

            ),

            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.account_box),

              ),

              title: Text("Logout"),
              subtitle: Text("session will be closed"),

            )



          ],
        ),
      ),

      backgroundColor: Colors.white,
/*
      body: Center(
      child: ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 24.0, right: 24.0),
      children: <Widget>[
      ],
        ),
    ),
 */

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context){
                return PostPage();
              }
              )
          );

        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pinkAccent,

      ),






    );







  }
}
