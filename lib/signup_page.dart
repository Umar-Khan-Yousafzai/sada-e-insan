import 'package:flutter/material.dart';
import 'package:sadaeniswa/about.dart';
import 'package:sadaeniswa/help.dart';
import 'package:sadaeniswa/login_page.dart';
import 'package:sadaeniswa/loginwithemail.dart';
import 'package:sadaeniswa/privacy_policy.dart';
import 'package:sadaeniswa/auth_rss.dart';
import 'dashboard.dart';

auth_resources authr = new auth_resources();
final get_email = TextEditingController();
final get_password = TextEditingController();

class SignupPage extends StatefulWidget {
  static String tag = 'signup-page';

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
/*
    final user = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'User Name',
        hintText: 'New User Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),

      ),
    );
*/
    String isEmail(String em) {
      String p =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(p);

      if (p != regExp.hasMatch(em).toString()) {
        return "Incorrect Email";
      }

      return regExp.hasMatch(em).toString();
    }

    final email = TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      keyboardType: TextInputType.text,
      controller: get_email,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Your Active Email Address',
        errorText: isEmail(get_email.text.toString()),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    String validatePassword(String value) {
      if (!(value.length > 5) && value.isNotEmpty) {
        return "Password should contains more then 5 character";
      }
      return null;
    }

    final password = TextFormField(
      controller: get_password,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'New Password',
        hintText: 'Enter New Password',
        errorText: validatePassword(get_password.text.toString()),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final signupButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed: () {
            authr
                .handleSignUp(
                    get_email.text.toString(), get_password.text.toString())
                .whenComplete(() {
              Navigator.of(context).pushNamed('/login_route');
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Dashboard();
              }));
            });
          },
          padding: EdgeInsets.all(12),
          color: Colors.pinkAccent,
          child: Text('Sign Up',
              style: TextStyle(color: Colors.white, fontSize: 17.0)),
        ));

    final signupWithGoogle = FlatButton(
        child: Text(
          'Signup with Google?',
          style: TextStyle(color: Colors.purple, fontSize: 15),
        ),
        onPressed: () {
          authr.signInWithGoogle().whenComplete(() {
            AlertDialog(content: Text("Please Wait"));
            dispose();
            Navigator.of(context).pushNamed('/dashboard');
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Dashboard();
            }));
          });
        });

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.apps),
              ),
              title: Text("Login"),
              subtitle: Text("already have account?"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginWithEmailPage();
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
            itemBuilder: (context) {
              var popupMenuItem = PopupMenuItem(
                child: ListView(
                  children: <Widget>[],
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
            signupButton,
//            alreadyHaveAccountLabel,
            signupWithGoogle
          ],
        ),
      ),
    );
  }
}
