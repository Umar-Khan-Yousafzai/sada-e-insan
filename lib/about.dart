import 'package:flutter/material.dart';
import 'package:sadaeniswa/signup_page.dart';
import 'package:sadaeniswa/dashboard.dart';

class About extends StatefulWidget {
  static String tag = "about";
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {



    final place_of_peace = Container(
      alignment: Alignment.topLeft,
      child: Icon(Icons.people,color: Colors.pinkAccent,size: 75.0),
    );

    final text_1= Text(
      "Place of Peace\n",
      style: TextStyle(
        fontSize: 45.0,
        color: Colors.black26,
        fontWeight: FontWeight.normal,
      ),
    );

    final text_about= Text(
      "This app is created for the Women's, who could not confess their problems with their families and friends. This app provide the platform which they can use and ask their problems and fine the solution without any identification. They also can post the solution for any problem. \n\n\n\n\n",
      style: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
    );


    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Center(child: Text("SADA-E-NISWA")),

      ),




      backgroundColor: Colors.white,

      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 20.0,),
            place_of_peace,
            text_1,
            text_about,

          ],
        ),
      ),
    );



  }
}
