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
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 15.0),
                  TextFormField(
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
                      // errorText: "Enter Correct Mail",
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    validator: (value) {
                      if (value.length < 5) {
                        return 'Password is Weak';
                      }
                      return null;
                    },
                    controller: get_password,
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      hintText: 'Enter New Password',
                      //errorText: "Error",
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                  //     SizedBox(height: 24.0),
                  Padding(
                      // signup button
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, display a Snackbar.

                            authr
                                .handleSignUp(get_email.text.toString(),
                                    get_password.text.toString())
                                .whenComplete(() {
                              Navigator.of(context).pushNamed('/login_route');
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Dashboard();
                              }));
                            });
                          }
                        },
                        padding: EdgeInsets.all(12),
                        color: Colors.pinkAccent,
                        child: Text('Sign Up',
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.0)),
                      )),
                  //SizedBox(height: 24.0),
                  FlatButton(
                      child: Text('Signup with Google?',
                          style: TextStyle(color: Colors.purple, fontSize: 15)),
                      onPressed: () {
                        authr.signInWithGoogle().whenComplete(() {
                          if (GestureDetector(onTapCancel: () {
                                // Navigator.of(context).pushNamed('/dashboard');
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return SignupPage();
                                }));
                              }) !=
                              null);
                          else {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Dashboard();
                            }));
                          }
                          ;
                        });
                      }),
                  // SizedBox(height: 9.0),
                  FlatButton(
                      child: Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.purple, fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return LoginWithEmailPage();
                        }));
                      } // On Pressed
                      )
                ],
              ),
            ),
            // logo,
          ],
        ),
      ),
    );
  } //widget
} //class
