import 'package:flutter/material.dart';
import 'package:sadaeniswa/login_page.dart';

class SignupPage extends StatefulWidget {
  static String tag = 'signup-page';
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
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

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Your Active Email Address',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'New Password',
        hintText: 'Enter New Password',
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
          Navigator.of(context).pushNamed(LoginPage.tag);

        },
        padding: EdgeInsets.all(12),
        color: Colors.pinkAccent,
        child: Text(
            'Sign Up', style: TextStyle(color: Colors.white, fontSize: 17.0)),
      ),
    );

    final alreadyHaveAccountLabel = FlatButton(
      child: Text(
        'Already have account? Login here',
        style: TextStyle(color: Colors.purple, fontSize: 15),
      ),
      onPressed: () {
        // Navigator.of(context).pushNamed(LoginPage.tag);
//        Navigator.push(context,
//            MaterialPageRoute(builder: (context){
//              return new LoginPage();
//            }
//            )
//        );
      Navigator.push(context, MaterialPageRoute(
        builder: (context)=>LoginPage()
      ));
      },
    );


    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Center(child: Text("SADA-E-NISWA")),
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

            )



          ],
        ),
      ),

      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            // logo,
            SizedBox(height: 50.0),
            user,
            SizedBox(height: 15.0),
            email,
            SizedBox(height: 15.0),
            password,
            SizedBox(height: 24.0),
            SizedBox(height: 24.0),
            signupButton,
            alreadyHaveAccountLabel,
          ],
        ),
      ),
    );


  }
}

