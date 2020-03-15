import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sadaeniswa/about.dart';
import 'package:sadaeniswa/dashboard.dart';
import 'package:sadaeniswa/help.dart';
import 'package:sadaeniswa/login_page.dart';

class PostPage extends StatefulWidget {
  static String tag = 'post-page';
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {

    final place_of_peace = Container(
      alignment: Alignment.topLeft,
      child: Icon(Icons.people,color: Colors.pinkAccent,size: 40.0),
    );

    final text_1= Text(
      "Place of Peace\n",
      style: TextStyle(
        fontSize: 30.0,
        color: Colors.black26,
        fontWeight: FontWeight.normal,
      ),
    );



    final post = TextField(
      keyboardType: TextInputType.multiline,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1000),
      ],
      maxLines: null,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Post',
        hintText: "What's on your mind...",
        contentPadding: EdgeInsets.fromLTRB(30.0, 100.0, 10.0, 100.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),

      ),

    );


    final submit = Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),

        onPressed: () {

          //Navigator.of(context).pushNamed(SignupPage.tag);

          Navigator.push(context,
              MaterialPageRoute(builder: (context){
                return Dashboard();
              }
              )
          );

        },
        padding: EdgeInsets.all(5),
        color: Colors.pinkAccent,
        child: Text(
            'Submit', style: TextStyle(color: Colors.white, fontSize: 15.0)),
      ),
    );

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Center(child: Text("SADA-E-NISWA")),


        actions: <Widget>[
          PopupMenuButton(
            // ignore: missing_return
            itemBuilder: (context){
              var popupMenuItem = PopupMenuItem(
                child: ListView(
                  children: <Widget>[
                  ],
                ),
              );
            },
          )
        ],

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
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return Dashboard();
                    }
                    )
                );
              },
            ),

            Divider(),

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



          ],
        ),
      ),

      backgroundColor: Colors.white,

      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 10,),
            place_of_peace,
            text_1,
            post,
            submit,
          ],
        ),
      ),



    );


  }
}
