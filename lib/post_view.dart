import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sadaeniswa/Database/blocdata.dart';

import 'Models/Model.dart';
import 'Models/PostModel.dart';
import 'Widget/InheritedWidgetModel.dart';

class PostViewKeys {
  static final ValueKey wholePage = ValueKey("wholePage");
  static final ValueKey bannerImage = ValueKey("bannerImage");
  static final ValueKey summary = ValueKey("summary");
  static final ValueKey mainBody = ValueKey("mainBody");
}

DocumentSnapshot documentSnapshot;
Bloc blocdata  = new Bloc();
class PostView extends StatelessWidget {
//final Model modelData;
final String documentID;
   PostView({Key key, @required this.documentID}) : super(key: key);


@override
  Widget build(BuildContext context) {
 documentSnapshot = blocdata.getSingleDocument(documentID);
    return Scaffold(
      appBar: AppBar(title: Text(documentSnapshot.data['title'].toString())),
      body: ListView(
          key: PostViewKeys.wholePage,
          children: <Widget>[
            _BannerImage(key: PostViewKeys.bannerImage),
            _NonImageContents(),
          ],
        ),

    );
  }
}

class _NonImageContents extends StatelessWidget {
  const _NonImageContents({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Model modelData = InheritedPostModel.of(context).modelData;

    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Summary(key: PostViewKeys.summary),
          //PostTimeStamp(),
          _MainBody(key: PostViewKeys.mainBody),
          //UserDetailsWithFollow(
            //userData: postData.author,
          //),
          SizedBox(height: 8.0),
         // PostStats(),
          //CommentsList(),
        ],
      ),
    );
  }
}

class _BannerImage extends StatelessWidget {
  const _BannerImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(

        documentSnapshot.data['imageUri'].toString(),
        fit: BoxFit.fitWidth,
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
          documentSnapshot.data['post'].toString(),
        maxLines: 3,
      ),
    );
  }
}

class _MainBody extends StatelessWidget {
  const _MainBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
       documentSnapshot.data['post'].toString()
             ),
    );
  }
}
