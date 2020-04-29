import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Screens/login_page.dart';
import 'Screens/dashboard.dart';
import 'Pages/signup_page.dart';
import 'package:sadaeniswa/post_page.dart';
void main() => runApp(MyApp());
  class MyApp extends StatefulWidget{


  /*final routes = <String, WidgetBuilder>{

    LoginPage.tag: (context) => LoginPage(),

  };*/
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

           'Screens/login_route': (context) => LoginPage(),

           'Screens/dashboard': (context) => Dashboard(),

           '/signup':(context) => SignupPage(),
           '/loginpage_email':(context) => LoginPage(),
           'Pages/post_page':(context) => PostPage(),
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
