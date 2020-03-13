import 'package:flutter/material.dart';
import 'package:sadaeniswa/about.dart';
import 'package:sadaeniswa/catagories.dart';
import 'package:sadaeniswa/forget_password_email.dart';
import 'package:sadaeniswa/help.dart';
import 'package:sadaeniswa/signup_page.dart';
import 'package:sadaeniswa/dashboard.dart';

class LoginPage extends StatefulWidget {
  static String tag = "login-page";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {

    final place_of_peace = Container(
      alignment: Alignment.topLeft,
      child: Icon(Icons.people,color: Colors.pinkAccent,size: 75.0),
    );

    final text_1= Text(
      "Place of Peace",
      style: TextStyle(
        fontSize: 45.0,
        color: Colors.black26,
        fontWeight: FontWeight.normal,
      ),
    );

    final user = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'User',
        hintText: 'User Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),

      ),

    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),

      ),

    );


    final login_button = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
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
        padding: EdgeInsets.all(12),
        color: Colors.pinkAccent,
        child: Text(
            'Log In', style: TextStyle(color: Colors.white, fontSize: 17.0)),
      ),
    );

    final signup_button = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          //Navigator.of(context).pushNamed(SignupPage.tag);
          Navigator.push(context,
              MaterialPageRoute(builder: (context){
                return SignupPage();
              }
              )
          );

        },
        padding: EdgeInsets.all(12),
        color: Colors.pinkAccent,
        child: Text(
            'Sign Up', style: TextStyle(color: Colors.white, fontSize: 17.0)),
      ),
    );

    final forgot_label = FlatButton(
      child: Text(
        'Forget Password?',
        style: TextStyle(color: Colors.purple, fontSize: 15),

      ),
      onPressed: () {
//        Navigator.of(context).pushNamed(ForgetPasswordEmail.tag);
        Navigator.push(context,
            MaterialPageRoute(builder: (context){
              return ForgetPasswordEmail();
            }
            )
        );
      },
    );


    final test = FlatButton(
      child: Text(
        'Catagories',
        style: TextStyle(color: Colors.purple, fontSize: 15),

      ),
      onPressed: () {
//        Navigator.of(context).pushNamed(ForgetPasswordEmail.tag);
        Navigator.push(context,
            MaterialPageRoute(builder: (context){
              return Catagories();
            }
            )
        );
      },
    );



    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.pink,
      title: Center(child: Text("SADA-E-NISWA")),


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
                    // ignore: missing_return
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

          ],
        ),
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
            SizedBox(height: 35.0),
            user,
            SizedBox(height: 15.0),
            password,
            SizedBox(height: 10.0),
            login_button,
            signup_button,
            forgot_label,
            test,


          ],
        ),
      ),
    );
  }
}
