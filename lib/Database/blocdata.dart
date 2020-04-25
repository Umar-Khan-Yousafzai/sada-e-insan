import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'Firestore_database.dart';
import 'dart:core';
import 'package:sadaeniswa/dashboard.dart';
import 'package:sadaeniswa/post_page.dart';

Repository _repository = new Repository();

class Bloc {
  void initState() {
    getAllDocuments();
  }

  final _documentData = BehaviorSubject<QuerySnapshot>();

//To listen documents data from StreamBuilder
  Stream<QuerySnapshot> get documentData => _documentData.stream;

//Our method we called into init state
  getAllDocuments() async {
    QuerySnapshot allDocuments = await _repository.getAllDocuments();

    _documentData.sink.add(allDocuments);
  }

  //After retrieve all documents, we sink into the pipe (stream)

//Do not forget to close our stream
  void dispose() async {
    await documentData.drain();
    _documentData.close();
  }

  Stream<DocumentSnapshot> getPostData(String documentId) {
    return _repository.getPostData(documentId);
  }

  Stream<DocumentSnapshot> getUserData(String documentId) {
    return _repository.getUserData(documentId);
  }

  Future<QuerySnapshot> getDocument(String collectionName,String whereAttribute, String isEqualTo) async
  {
    return await _repository.getRequiredDocument(collectionName, whereAttribute, isEqualTo);
  }
  DateTime dateTime = DateTime.now();

  Future<void> createDocument() async {
   // print("Image Address bloc" + imageaddress.toString());
    Map<String, dynamic> PostDocument = <String, dynamic>{
      "title": get_postTitle.text.toString(),
      "post": get_post.text.toString(),
      "userID": userid,
      "userEmail": userEmail,
      "userPhotoUrl": userPhotoUrl,
      "userName": userdisplayname,
      "timestamp": dateTime,
      "imageUri": imageaddress.toString(),
      "postID": postreference.documentID,
    };

    Map<String, dynamic> UserDocument = <String, dynamic>{
      "userID": userid,
      "userEmail": userEmail,
      "userPhotoUrl": userPhotoUrl,
      "userName": userdisplayname,
      "timestamp": dateTime,
      "postID": postreference.documentID,
      "userDocumentID": userreference.documentID,
    };

    _repository.createPostDocument(PostDocument).catchError((e) {
      print(e);
    });
    _repository.createUserDocument(UserDocument).catchError((e) {
      print(e);
    });




  }

  Future<void> createComment( String comment, String postReference) async {

    DateTime dateTime = DateTime.now();

    Map<String, dynamic> postComment = <String, dynamic>{
      "userPhotoUrl": userPhotoUrl,
      "userName": userdisplayname,
      "userID":  userid,
      "timestamp": dateTime,
      "commentID": commentReference.documentID,
      "postID": postReference,
      "commentContent": comment,
    };
   await _repository.createCommentDocument(postComment).catchError((e) {
      print(e);
    });
  }
}
