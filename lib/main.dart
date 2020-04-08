import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_page.dart';
import 'dashboard.dart';
import 'signup_page.dart';

void main() => runApp(MyApp());
  class MyApp extends StatelessWidget{
  final routes = <String, WidgetBuilder>{

    LoginPage.tag: (context) => LoginPage(),

  };
  @override
 // Routing rout = new Routing();
  Widget build(BuildContext context) {
       var pageRoute;
       return MaterialApp(
         title: 'Place of Peace',
         debugShowCheckedModeBanner: false,
         theme: ThemeData(
           primarySwatch: Colors.green,
           brightness: Brightness.light,
           fontFamily: 'Canvas',
         ),
         home: validate(),
         //initialRoute: '/login_route',
         routes: {

           '/login_route': (context) => LoginPage(),

           '/dashboard': (context) => Dashboard(),

           '/signup':(context) => SignupPage(),

           '/loginpage_email':(context) => LoginPage(),
         },
       );
  }

   validate()
  {
    if(GoogleSignIn().isSignedIn()==true)
    {
     return Dashboard();
    }
    else
    {
      return LoginPage();
    }

  }
}


//M A Hafeez IUB RYK +923088384344
//Umar Farooq Khan Yousafzai
