
import 'package:flutter/material.dart';
import 'package:sadaeniswa/Pages/about.dart';
import 'package:sadaeniswa/Pages/help.dart';
import 'package:sadaeniswa/Pages/privacy_policy.dart';
import 'package:sadaeniswa/Resources/auth_rss.dart';
import '../Screens/dashboard.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final getEmail = TextEditingController();
final getPassword = TextEditingController();
final getCPassword = TextEditingController();
auth_resources authr = new auth_resources();
class SignupPage extends StatefulWidget {
  final DBRef = FirebaseDatabase.instance.reference();

  static String tag = 'signup-page';

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final DocumentReference documentReference = Firestore.instance.document("/registered_users/users");
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final placeOfPeace = Container(
      alignment: Alignment.topLeft,
      child: Icon(Icons.person, color: Colors.pinkAccent.shade200, size: 75.0),
    );
    final text_1 = Text(
      "Place of Peace\n",
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: 45.0, color: Colors.black45, fontWeight: FontWeight.normal),
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
                  SizedBox(height: 20.0),
                  placeOfPeace,
                  text_1,
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    controller: getEmail,
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

                  SizedBox(height: 25.0),
                  TextFormField(
                    validator: (value) {
                      if (value.length<5) {
                        return 'Password is Weak';
                      }
                      return null;
                    },

                    controller: getPassword,
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


                  SizedBox(height: 25.0),
                  TextFormField(
                    validator: (value) {
                      if (getPassword.value != getPassword.value) {
                        return 'Password Not Matched';
                      }
                      return null;
                    },

                    controller: getCPassword,
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Re-enter New Password',
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
                            authr.handleSignUp(getEmail.text.toString(),
                                getPassword.text.toString())
                                .whenComplete(() {
                              Navigator.of(context).pushNamed('/login_route');
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return Dashboard();
                                  }));
                            });
                          }
                        },

                        padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                        color: Colors.pinkAccent,
                        child: Text('Sign Up',
                            style: TextStyle(color: Colors.white, fontSize: 17.0)),
                      )
                  ),

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
                                  return Dashboard();
                                }
                                )
                                );
                              }) ==
                              null);

                          else {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return SignupPage();
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
                          return SignupPage();
                        }
                        )
                        );
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

  void signUpData(){
    Map<String, String> data = <String, String>{
      "email" : "arslan@gmail.com",
      "password" : "abcd",
      "cpassword" : "abcd",
    };
    documentReference.setData(data).whenComplete((){
      print("Document Added");
    }).catchError((e) => (print(e)));



  }


} //class


