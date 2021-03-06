import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:sadaeniswa/Pages/about.dart';
import 'package:sadaeniswa/Resources/FirebaseAuthenticationMethods.dart';
import 'package:sadaeniswa/forget_password_email.dart';
import 'package:sadaeniswa/Pages/help.dart';
import 'package:sadaeniswa/Pages/signup_page.dart';
import 'package:sadaeniswa/Screens/dashboard.dart';
import 'package:sadaeniswa/Resources/auth_rss.dart';

FirebaseAuthenticationRepository _firebaseAuthenticationRepository = new FirebaseAuthenticationRepository();


class LoginPage extends StatefulWidget {
  static String tag = "login-page";

  //final get_username = TextEditingController();
  //final get_password = TextEditingController();
//----------------------------------------------------------- Firebase-------------------------------------//
//login_auth lauth;
  auth_resources authr = new auth_resources();
  @override
  _LoginPageState createState() => _LoginPageState();

 Future<FirebaseUser>  getSign() async
  {var user;
      user = await _firebaseAuthenticationRepository.getCurrentUser();
   FirebaseUser users;
   users= user;
   return users;
  }

}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    final place_of_peace = Container(
      alignment: Alignment.topCenter,
      child: Icon(Icons.person, color: Colors.pinkAccent.shade200, size: 75.0),
    );

    final text_1 = Text(
      "Place of Peace",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 45.0, color: Colors.black45, fontWeight: FontWeight.w400),
    );

    final email = new Theme(
      data: new ThemeData(
        primaryColor: Colors.redAccent,
        primaryColorDark: Colors.red,
      ),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
          //labelText: 'Email',
          hintText: 'Email Address...',
          //errorText: "Error",
          contentPadding:
          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0)),
        ),

      ),
    );

    final password = new Theme(
      data: new ThemeData(
        primaryColor: Colors.redAccent,
        primaryColorDark: Colors.red,
      ),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
          //labelText: 'Password',
          hintText: 'Your Password...',
          //errorText: "Error",
          contentPadding:
          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );


    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),

        onPressed: () {
          Navigator.of(context).pushNamed(Dashboard.tag);
//          signInWithGoogle().whenComplete(() {
//            Navigator.of(context).pushNamed('/dashboard');
//            Navigator.push(context, MaterialPageRoute(builder: (context) {
//              return Dashboard();
//            }
//            )
//            );
//          });
//           return showDialog(
//              context: context,
//                builder: (context)
//                    {
//                      return AlertDialog(content: Text(get_username.text));
        },
        padding: EdgeInsets.all(12),
        color: Colors.pinkAccent,
        child: Text(
            'Login', style: TextStyle(color: Colors.white, fontSize: 17.0)),
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

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SignupPage();
          }));
        },
        padding: EdgeInsets.all(12),
        color: Colors.pinkAccent,
        child: Text('Sign Up',
            style: TextStyle(color: Colors.white, fontSize: 17.0)),
      ),
    );

    final forgot_label = FlatButton(
      child: Text(
        'Forget Password?',
        style: TextStyle(color: Colors.purple, fontSize: 15),
      ),
      onPressed: () {
//        Navigator.of(context).pushNamed(ForgetPasswordEmail.tag);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ForgetPasswordEmail();
        }));
      },
    );

    final loginWithGoogle = new FlatButton(
        child: Text(
          'Login with Google?',
          style: TextStyle(color: Colors.purple, fontSize: 15),
        ),
        onPressed: () {
          performLogin();
        }
    );
      return Scaffold(

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
                  Navigator.push(context,
                      // ignore: missing_return
                      MaterialPageRoute(builder: (context) {
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
            ],
          ),
        ),


        backgroundColor: Colors.white,
        body: SafeArea(
//minimum: ,
          child: ListView(

            shrinkWrap: true,
            padding: EdgeInsets.fromLTRB(24, 36, 24, 24),
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              place_of_peace,
              text_1,
              SizedBox(height: 35.0),
              email,
              SizedBox(height: 15.0),
              password,
              SizedBox(height: 10.0),
              loginButton,
              signup_button,
              forgot_label,
              loginWithGoogle,
            ],
          ),
        ),
      );
  }


  void performLogin() {
    print("tring to perform login");
    _firebaseAuthenticationRepository.signIn().then((FirebaseUser user) {
      print("something");
      if (user != null) {
        authenticateUser(user);
      } else {
        print("There was an error");
      }
    });
  }

  void authenticateUser(FirebaseUser user) {
    _firebaseAuthenticationRepository.authenticateUser(user).then((isNewUser) {
      if (isNewUser) {
        _firebaseAuthenticationRepository.addDataToDb(user).then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                return Dashboard();
              }));
        });
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return Dashboard();
            }));
      }
    });
  }


}