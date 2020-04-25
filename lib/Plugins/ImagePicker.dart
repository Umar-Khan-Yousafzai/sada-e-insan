import 'package:flutter/material.dart';
import 'dart:async';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:sadaeniswa/Pages/DrawerPages/about.dart';
import 'package:sadaeniswa/Pages/Posts/post_page.dart';

import '../Screens/dashboard.dart';
import '../Pages/DrawerPages/help.dart';


class ImagePicker extends StatefulWidget {
  @override
  FImagePicker createState() => new FImagePicker();
}

class FImagePicker extends State<ImagePicker> {
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 200,
          height: 200,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#000000",
          actionBarTitle: "Sada-E-Niswan",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }
  @override
  Widget build(BuildContext context) {

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
        body: Column(
          children: <Widget>[
            Center(child: Text('Error: $_error')),
            RaisedButton(
              child: Text("Pick images"),
              onPressed: loadAssets,
            ),
            Expanded(
              child: buildGridView(),
            ),
            RaisedButton(
              child: Text("Submit"),
              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) {
                if(images !=null)
                  {print("Images not null");}
                return PostPage();
              }));
              },
            ),
          ],
        ),
      );

  }
}