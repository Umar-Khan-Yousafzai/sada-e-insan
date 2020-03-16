import 'package:flutter/material.dart';
import 'package:sadaeniswa/loginwithemail.dart';
import 'login_page.dart';
import 'dashboard.dart';
import 'about.dart';
import 'signup_page.dart';
import 'post_page.dart';
import 'help.dart';
import 'privacy_policy.dart';
import 'report_problem.dart';
import 'loginwithemail.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget{
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),

  };

  @override
  Widget build(BuildContext context) {
       return MaterialApp(
         title: 'SADA-E-NISWA',
         debugShowCheckedModeBanner: false,
         theme: ThemeData(
           primarySwatch: Colors.green,
           brightness: Brightness.light,
           fontFamily: 'Canvas',

         ),
         home: LoginPage(),
         initialRoute: '/login_route',
         routes: {
           '/login_route': (context) => LoginPage(),
           '/dashboard': (context) => Dashboard(),
           '/signup':(context) => SignupPage(),
           '/loginpage_email':(context) => LoginWithEmailPage(),


         },

       );
  }
}

//M A Hafeez IUB RYK