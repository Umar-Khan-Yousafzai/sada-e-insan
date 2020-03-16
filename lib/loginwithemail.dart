

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sadaeniswa/about.dart';
import 'package:sadaeniswa/catagories.dart';
import 'package:sadaeniswa/forget_password_email.dart';
import 'package:sadaeniswa/help.dart';
import 'package:sadaeniswa/login_page.dart';
//import 'package:sadaeniswa/login_resource.dart';
import 'package:sadaeniswa/signup_page.dart';
import 'package:sadaeniswa/dashboard.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'privacy_policy.dart';
import 'package:sadaeniswa/auth_rss.dart';
final get_username = TextEditingController();
final get_password = TextEditingController();

//----------------------------------------------------------- Firebase-------------------------------------//
//login_auth lauth;
auth_resources authr = new auth_resources();
class LoginWithEmailPage extends  StatefulWidget
{
  static String tag = "loginwithemailpage";
  @override
  _LoginWithEmail createState() =>_LoginWithEmail();

}

class _LoginWithEmail extends State<LoginWithEmailPage>
{
  @override
  Widget build(BuildContext context) {
    final email = new Theme(
      data: new ThemeData(
        primaryColor: Colors.redAccent,
        primaryColorDark: Colors.red,
      ),
      child: TextFormField(
      keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'Enter your Email',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.pinkAccent),
              borderRadius: BorderRadius.circular(32.0)),
          prefixIcon: const Icon(
            Icons.email,
            color: Colors.pink,
          ),
        )
      ),
      );


      final password = new Theme(
      data: new ThemeData(
      primaryColor: Colors.redAccent,
      primaryColorDark: Colors.red,
    ),

      child:TextFormField(
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Enter Your Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),

        ),
      )
    );

      final loginButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),

          onPressed: () {
            Navigator.of(context).pushNamed(LoginPage.tag);
          },
          padding: EdgeInsets.all(12),
          color: Colors.pinkAccent,
          child: Text(
              'Login', style: TextStyle(color: Colors.white, fontSize: 17.0)),
        ),
      );
      final loginWithGoogle = new FlatButton(
        child: Text(
          'Login with Google?',
          style: TextStyle(color: Colors.purple, fontSize: 15),
        ),
        onPressed: () {
    authr.signInWithGoogle().whenComplete(() {
    Navigator.of(context).pushNamed('/dashboard');
    Navigator.push(context, MaterialPageRoute(builder: (context) {
    return Dashboard();
    }
    )
    );
    });}
    );
      return Scaffold
        (

        drawer: Drawer(
          child: ListView(
            children: <Widget>[


              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.apps),
                ),
                title: Text("Login"),
                subtitle: Text("already have account?"),
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return LoginPage();
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

              )



            ],
          ),
        ),

        backgroundColor: Colors.white,
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
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              // logo,
              SizedBox(height: 15.0),
              email,
              SizedBox(height: 15.0),
              password,
              SizedBox(height: 24.0),
              SizedBox(height: 24.0),
              loginButton,
//            alreadyHaveAccountLabel,
              loginWithGoogle,

            ],
          ),
        ),
      );



  }
  }

class Authenticate_Email_Password
    {
    final FirebaseAuth auth = FirebaseAuth.instance;

    Future<FirebaseUser> handleSignInEmail(String email, String password) async {

    AuthResult result = await auth.signInWithEmailAndPassword(email: email, password: password);
    final FirebaseUser user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await auth.currentUser();
    assert(user.uid == currentUser.uid);

    print('signInEmail succeeded: $user');

    return user;

    }

    Future<FirebaseUser> handleSignUp(email, password) async {

    AuthResult result = await auth.createUserWithEmailAndPassword(email: email, password: password);
    final FirebaseUser user = result.user;

    assert (user != null);
    assert (await user.getIdToken() != null);

    return user;

    }
    }







class login_auth
{


}