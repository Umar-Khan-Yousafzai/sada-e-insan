import 'package:flutter/material.dart';
import 'package:sadaeniswa/forget_password_verification_code.dart';

class ForgetPasswordEmail extends StatefulWidget {
  static String tag = "forget-password-email";

  @override
  _ForgetPasswordEmailState createState() => _ForgetPasswordEmailState();
}

class _ForgetPasswordEmailState extends State<ForgetPasswordEmail> {
  @override
  Widget build(BuildContext context) {

    final placeOfPeace = Container(
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

    final emailField = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Enter email address...',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),

      ),

    );


    final nextButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          //Navigator.of(context).pushNamed(SignupPage.tag);
          Navigator.push(context,
              MaterialPageRoute(builder: (context){
                return ForgetPasswordVerificationCode();
              }
              )
          );

        },
        padding: EdgeInsets.all(12),
        color: Colors.pinkAccent,
        child: Text(
            'Next', style: TextStyle(color: Colors.white, fontSize: 17.0)),
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

      backgroundColor: Colors.white,

      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 20.0,),
            placeOfPeace,
            text_1,
            emailField,
            nextButton,


          ],
        ),
      ),
    );


  }
}
