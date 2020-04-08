import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sadaeniswa/about.dart';
import 'package:sadaeniswa/dashboard.dart';
import 'package:sadaeniswa/help.dart';
import 'package:sadaeniswa/login_page.dart';
import 'package:sadaeniswa/auth_rss.dart';
import 'package:firebase_storage/firebase_storage.dart';
auth_resources authorize = new auth_resources();
LoginPage lpg = new LoginPage();
final get_post = TextEditingController();
final get_postTitle = TextEditingController();

//FImagePicker imagePicker = new FImagePicker();
//final List<Image> images = imagePicker.returnImages();
class PostPage extends StatefulWidget {
  static String tag = 'post-page';

  @override
  _PostPageState createState() => _PostPageState();

  getPosts() async {
    return Firestore.instance.collection('posts').snapshots();
  }
}

class _PostPageState extends State<PostPage> {

  File _Image;
  StorageReference imageReference;

  Future getImage() async {
    File image;
    image = (await ImagePicker.pickImage(source: ImageSource.gallery));
    setState(()
    {
     _Image = image;
    });
  }//getImage();

  //Upload Image
  Future uploadImage() async{
    imageReference = FirebaseStorage.instance.ref().child(_Image.toString());
    StorageUploadTask storageUploadTask = imageReference.putFile(_Image);
    StorageTaskSnapshot storageTaskSnapshot = await storageUploadTask.onComplete;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    final placeOfPeace = Container(
      alignment: Alignment.topLeft,
      child: Icon(Icons.people, color: Colors.pinkAccent, size: 40.0),
    );

    final text_1 = Text(
      "Place of Peace\n",
      style: TextStyle(
        fontSize: 30.0,
        color: Colors.black26,
        fontWeight: FontWeight.normal,
      ),
    );

    final postTitle =new Theme(
        data: new ThemeData(
          primaryColor: Colors.pinkAccent.shade100,
          primaryColorDark: Colors.pinkAccent.shade100,
        ),
        child: TextFormField(
          controller: get_postTitle,

          keyboardType: TextInputType.text,
          inputFormatters: [
            LengthLimitingTextInputFormatter(100),
          ],
          maxLines: null,
          autofocus: false,
          decoration: InputDecoration(
            // labelText: 'Title',
            hintText: "Title that you want to give...",
            contentPadding: EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 10.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
        )
    );
    final post =new Theme(
      data: new ThemeData(
        primaryColor: Colors.pinkAccent.shade100,
        primaryColorDark: Colors.pinkAccent.shade100,
      ),
      child: TextField(

       controller: get_post,
      keyboardType: TextInputType.multiline,
        inputFormatters: [
        LengthLimitingTextInputFormatter(1000),
      ],
      maxLines: null,
      autofocus: false,
      decoration: InputDecoration(
        hintText: "What's on your mind...",
        suffixIcon: IconButton(icon: Icon(Icons.camera), onPressed: () {
          getImage();

        },
        ),
        contentPadding: EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),
        ),

      ),
    ),
    );


    final submit = Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        onPressed: () {
          //Navigator.of(context).pushNamed(SignupPage.tag);
          if(_Image != null)
            {
              uploadImage();
              _add();
            }
          else {
            _add();
          }
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Dashboard();
          }));
        },
        padding: EdgeInsets.all(5),
        color: Colors.pinkAccent,
        child: Text("Submit",
            style: TextStyle(color: Colors.white, fontSize: 15.0)),
      ),
    );

    return Scaffold(
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
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text(
              " "+authorize.googleSignIn.currentUser.toString()),
              subtitle: Text("How are you doing?"),
              onTap: () {
              },
            ),
            Divider(),




            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.home),
              ),
              title: Text("Home"),
              subtitle: Text("dashboard"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Dashboard();
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
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          //shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(
            //  height: 10,
            ),
            placeOfPeace,
            text_1,
            postTitle,
            SizedBox(width: 10,height: 10,),

            post,
          // child:   padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        //height: MediaQuery.of(context).size.height * 0.35,
            Row(
              children: <Widget>[
              Expanded(
                child: _Image == null ? Container() : Image.file(_Image,
                height: 100,
                width: 100,)
              )
              ],
            ),
submit,
// GetImages(),
],
),
),
);
}
final DateTime dateTime = new DateTime.now();
//final String user_id = authr.googleSignIn.currentUser.displayName.toString();

String user_id = " jhj";//authorize.googleSignIn.currentUser.displayName;
DocumentReference documentReference = Firestore.instance.collection('posts').document();
Future<void> _add() async {
  user_id = lpg.getSign();
  Map<String, String> data = <String, String>{
    "title": get_postTitle.text.toString(),
    "post": get_post.text.toString(),
    "documentID": documentReference.documentID,
    "userID":user_id,
    "timestamp": dateTime.toString(),
    "reference": imageReference.toString(),
  };

  documentReference.setData(data).catchError((e){print(e);});

}


}

