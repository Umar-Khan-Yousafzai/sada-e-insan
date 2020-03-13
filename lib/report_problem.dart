import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sadaeniswa/signup_page.dart';
import 'package:sadaeniswa/dashboard.dart';

class ReportProblem extends StatefulWidget {
  static String tag = "report-problem";
  @override
  _ReportProblemState createState() => _ReportProblemState();
}

class _ReportProblemState extends State<ReportProblem> {
  @override
  Widget build(BuildContext context) {




//    return MaterialApp(
//      title: "SADA-E-NISWA",
//      home: Scaffold(
//        appBar: AppBar(
//          backgroundColor: Colors.pinkAccent,
//          title: Text("SADA-E-NISWA", textAlign: TextAlign.right,),
//        ),
//        body: MyCustomForm(),
//      ),
//    );
//  }
//}
//
//// Create a Form widget.
//class MyCustomForm extends StatefulWidget {
//  @override
//  MyCustomFormState createState() {
//    return MyCustomFormState();
//  }
//}
//
//// Create a corresponding State class.
//// This class holds data related to the form.
//class MyCustomFormState extends State<MyCustomForm> {
//  // Create a global key that uniquely identifies the Form widget
//  // and allows validation of the form.
//  //
//  // Note: This is a GlobalKey<FormState>,
//  // not a GlobalKey<MyCustomFormState>.
//  final _formKey = GlobalKey<FormState>();
//
//  @override
//  Widget build(BuildContext context) {
//    // Build a Form widget using the _formKey created above.
//    return Form(
//        key: _formKey,
//        child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//        TextFormField(
//        validator: (value) {
//    if (value.isEmpty) {
//    return 'Please enter some text';
//    }
//    return null;
//    },
//    ),
//    Padding(
//    padding: const EdgeInsets.symmetric(vertical: 16.0),
//    child: RaisedButton(
//    onPressed: () {
//    // Validate returns true if the form is valid, or false
//    // otherwise.
//    if (_formKey.currentState.validate()) {
//    // If the form is valid, display a Snackbar.
//    Scaffold.of(context)
//        .showSnackBar(SnackBar(content: Text('Processing Data')));
//    }
//    },
//    child: Text('Submit'),
//    ),
//    ),
//        ],
//        ),
//    );
  }
}
