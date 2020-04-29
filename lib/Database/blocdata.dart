import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sadaeniswa/Models/PostModel.dart';
import 'package:sadaeniswa/Models/UserModel.dart';
import 'package:sadaeniswa/Resources/FirebaseAuthenticationMethods.dart';
import 'Firestore_database.dart';
import 'dart:core';
import 'package:sadaeniswa/Screens/dashboard.dart';
import 'package:sadaeniswa/post_page.dart';
import 'package:sadaeniswa/Resources/auth_rss.dart';
Repository _repository = new Repository();
PostModel _postModel;
FirebaseAuthenticationRepository _authenticationRepository = new FirebaseAuthenticationRepository();

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

UserModel mymodel;

  Future<void> createPostDocument() async {
   // print("Image Address bloc" + imageaddress.toString());
   _postModel = PostModel(
     post: get_post.text.toString(),
     postID: postreference.documentID,
     //userEmail: auth_resources.email,
     userName: mymodel.username.toString(),
     userPhotoUrl: mymodel.profilePhoto.toString(),
     imageUri:imageaddress.toString(),
     title: get_postTitle.text.toString(),
     timestamp: dateTime,
   );

   _repository.createPostDocument(_postModel.toPostMap(_postModel)).catchError((e) {
     print(e);
   });


    /*   Map<String, dynamic> PostDocument = <String, dynamic>{
      "title": get_postTitle.text.toString(),
      "post": get_post.text.toString(),
      "userEmail": userEmail,
      "userPhotoUrl": userPhotoUrl,
      "userName": userdisplayname,
      "timestamp": dateTime,
      "imageUri": imageaddress.toString(),
      "postID": postreference.documentID,
    };*/



  }


  Future<void> addPostToDb(FirebaseUser currentUser) async {
    //String username = Utils.getUsername(currentUser.email);

    _postModel = PostModel(
      post: get_post.text.toString(),
      postID: postreference.documentID,
      userEmail: currentUser.email,
      userName: currentUser.displayName,
      userPhotoUrl: currentUser.photoUrl,
      imageUri: imageaddress.toString(),
      title: get_postTitle.text.toString(),
      timestamp: dateTime,
    );


    _repository.createPostDocument(_postModel.toPostMap(_postModel))
        .catchError((e) {
      print(e);
    });}

    void authenticateUser(FirebaseUser user) {
      _authenticationRepository.authenticateUser(user).then((checkUser) {
        if (checkUser != null) {
          _authenticationRepository.addPostToDb(user);

        }
        else
          print("error user" + user.uid);
      });
    }

  Future<void> postDocument() {
    _authenticationRepository.getCurrentUser().then((user) {
      if (user.uid != null) {
        authenticateUser(user);
      }
      else {
        print("Error");
      }
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
