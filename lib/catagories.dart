import 'package:flutter/material.dart';
import 'package:sadaeniswa/privacy_policy.dart';
import 'package:sadaeniswa/report_problem.dart';
import 'package:sadaeniswa/signup_page.dart';
import 'package:sadaeniswa/dashboard.dart';

import 'about.dart';
import 'help.dart';
import 'login_page.dart';

class Catagories extends StatefulWidget {
  static String tag = "catagories";

  @override
  _CatagoriesState createState() => _CatagoriesState();
}

class _CatagoriesState extends State<Catagories> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Center(child: Text("SADA-E-NISWA")),

      ),


      backgroundColor: Colors.white,

      body: Center(
        child: ListView(
          children: <Widget>[
            ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white30,
                  child: Icon(Icons.search),
                ),
                title: Form(
                  autovalidate: true,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white30,
                    ),

                    child: TextFormField(
                      autovalidate: true,
                      decoration: InputDecoration(

                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                )
            ),

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
//          ) ,


            ListTile(
              title: Text("Catagory Name..."),
              subtitle: Text("Meta data about catagory..."),
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
            Divider(),
            ListTile(
              title: Text("Catagory Name..."),
              subtitle: Text("Meta data about catagory..."),
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
            Divider(),
            ListTile(
              title: Text("Catagory Name..."),
              subtitle: Text("Meta data about catagory..."),
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
            Divider(),
            ListTile(
              title: Text("Catagory Name..."),
              subtitle: Text("Meta data about catagory..."),
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
            Divider(),
            ListTile(
              title: Text("Catagory Name..."),
              subtitle: Text("Meta data about catagory..."),
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
            Divider(),
          ],
        ),
      ),



    );



  }
}
