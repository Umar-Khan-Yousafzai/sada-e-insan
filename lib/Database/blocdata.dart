
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'Firestore_database.dart';
import 'dart:core';
import 'package:sadaeniswa/dashboard.dart';
import 'package:sadaeniswa/post_page.dart';
Repository _repository = new Repository();
 class  Bloc
{
  void initState(){
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

  Stream<QuerySnapshot> getAnything(String ComparisionItem,ItemNeeded )
  {
   var item = _repository.getAnything(ComparisionItem, ItemNeeded);
  return item;
  }
  Future <List<Map<dynamic, dynamic>>> getCollection(String ComparisionItem,String ItemNeeded ) async{
    List<DocumentSnapshot> tempList;
    List<Map<dynamic, dynamic>> list = new List();
    CollectionReference collectionRef = Firestore.instance.collection("users");
    QuerySnapshot collectionSnapshot = await collectionRef.where(ComparisionItem,isEqualTo: ItemNeeded).getDocuments();

    tempList = collectionSnapshot.documents; // <--- ERROR

    list = tempList.map((DocumentSnapshot docSnapshot){
      return docSnapshot.data;
    }).toList();

    return list;
  }
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

  DateTime dateTime = DateTime.now();


    Future<void> createDocument() async {
print("Image Address bloc"+ imageaddress.toString());
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
        // "postID": reference.documentID.toString(),
      };

      Map<String, dynamic> UserDocument = <String, dynamic>{

        "userID": userid,
        "userEmail": userEmail,
        "userPhotoUrl":userPhotoUrl,
        "userName": userdisplayname,
        "timestamp": dateTime,
        "postID": postreference.documentID,
        "userDocumentID":userreference.documentID,
        // "postID": reference.documentID.toString(),
      };

    _repository.createPostDocument(PostDocument).catchError((e){print(e);});
    _repository.createUserDocument(UserDocument).catchError((e){print(e);});
    }
    Future<void>createComment(String userPhoto,String userName, DateTime datetStamp, String Comment, String postReference, int Replies){
  Map<String, dynamic> PostComment = <String, dynamic>{
    "userPhotoUrl": userPhoto,
    "userName": userName,
    "timestamp": datetStamp,
    "Comment": commentReference.documentID,
    "postID":  postReference,
    "Replies": Replies,
  };
    _repository.createCommentDocument(PostComment);}
}
