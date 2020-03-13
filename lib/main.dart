import 'package:flutter/material.dart';
import 'login_page.dart';



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
           primarySwatch: Colors.lightBlue,
           brightness: Brightness.light,
           fontFamily: 'Canvas',
         ),
         home: LoginPage(),
         routes: routes,
       );
  }
}

//M A Hafeez